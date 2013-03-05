param($installPath, $toolsPath, $package, $project)

Import-Module (Join-Path $toolsPath "MSBuild.psm1")

function Get-RelativePath ( $folder, $filePath ) 
{
    Write-Verbose "Resolving paths relative to '$Folder'"
    $from = $Folder = split-path $Folder -NoQualifier -Resolve:$Resolve
    $to = $filePath = split-path $filePath -NoQualifier -Resolve:$Resolve

    while($from -and $to -and ($from -ne $to)) {
        if($from.Length -gt $to.Length) {
            $from = split-path $from
        } else {
            $to = split-path $to
        }
    }

    $filepath = $filepath -replace "^"+[regex]::Escape($to)+"\\"
    $from = $Folder
    while($from -and $to -and $from -gt $to ) {
        $from = split-path $from
        $filepath = join-path ".." $filepath
    }
    Write-Output $filepath
}

function Install-Targets ( $project, $importFile )
{
    $buildProject = Get-MSBuildProject

    $buildProject.Xml.Imports | Where-Object { $_.Project -match "TestFramework" } | foreach-object {     
        Write-Host ("Removing old import:      " + $_.Project)
        $buildProject.Xml.RemoveChild($_) 
    }

    $projectItem = Get-ChildItem $project.FullName
    Write-Host ("Adding MSBuild targets import: " + $importFile)

    $target = $buildProject.Xml.AddImport( $importFile )

    $project.Save()
}

function Copy-TargetsToSolutionRoot($project) {
    $solutionDir = Get-SolutionDir
    $testframeworkFolder = (Join-Path $solutionDir .testframework)

    # Get the target file's path
    $targetsFolder = Join-Path $toolsPath "..\targets" | Resolve-Path
    
    if(!(Test-Path $testframeworkFolder)) {
        mkdir $testframeworkFolder | Out-Null
    }

    $testframeworkFolder = resolve-path $testframeworkFolder

    Write-Host "Copying MSBuild targets to: $testframeworkFolder"

    Copy-Item "$targetsFolder\*.*" $testframeworkFolder -Force | Out-Null

    $projectItem = Get-ChildItem $project.FullName
    return '$(SolutionDir)\.testframework\TestFramework.targets'
}

function Main 
{
    $importFile = Copy-TargetsToSolutionRoot $project

    Install-Targets $project $importFile

    Write-Host ("Test Framework targets installed successfully")
}