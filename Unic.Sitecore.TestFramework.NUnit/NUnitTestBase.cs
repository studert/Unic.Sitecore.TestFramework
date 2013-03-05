// --------------------------------------------------------------------------------------------------------------------
// <copyright file="NUnitTestBase.cs" company="Unic AG">
//   Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/
// </copyright>
// <summary>
//   This class enables tests to use the Sitecore context by loading the configuration from the 
//   correct place.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace Unic.Sitecore.TestFramework.NUnit
{
    using global::NUnit.Framework;

    using global::Sitecore;

    /// <summary>
    /// Inherit from this base class to enable the Sitecore context when testing with NUnit.
    /// </summary>
    public abstract class NUnitTestBase
    {
        /// <summary>
        /// Enables the Sitecore context.
        /// </summary>
        [SetUp]
        public void SetUp()
        {
            Context.IsUnitTesting = true;
        }
    }
}
