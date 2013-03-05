// --------------------------------------------------------------------------------------------------------------------
// <copyright file="XUnitTestBase.cs" company="Unic AG">
//   Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/
// </copyright>
// <summary>
//   This class enables tests to use the Sitecore context by loading the configuration from the 
//   correct place.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace Unic.Sitecore.TestFramework.XUnit
{
    using global::Sitecore;

    /// <summary>
    /// Inherit from this base class to enable the Sitecore context when testing with xUnit.
    /// </summary>
    public abstract class XUnitTestBase
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="XUnitTestBase"/> class.
        /// Enables the Sitecore context.
        /// </summary>
        public XUnitTestBase()
        {
            Context.IsUnitTesting = true;
        }
    }
}
