// protractor.conf.js

exports.config = {
  //seleniumAddress: '', // The address of a running selenium server.
  framework: 'jasmine2',

  directConnect: true,

  // Capabilities to be passed to the webdriver instance.
  capabilities: {
    browserName: 'chrome'
  },

  suites: {
    angularDemo: 'spec/js/angularSiteSpec.js'
  },

  // Options to be passed to Jasmine-node.
  jasmineNodeOpts: {
    showColors: true, // Use colors in the command line report.

    // If true, display spec names.
    isVerbose: true,

    // If true, include stack traces in failures.
    includeStackTrace: true,
    // Default time to wait in ms before a test fails.
    defaultTimeoutInterval: 350000
  },

  allScriptsTimeout: 300000,

  onPrepare: function() {
    require('./spec/js/support/extend.js');
    var env = require('./spec/js/support/env.js');

    console.log("Environment: " + env.name());
    console.log("webappUrl: " + env.webappUrl());
  },

  /**
   * onComplete will be called just before the driver quits.
   */
  onComplete: function () {
    console.log("Completed");
  }
};
