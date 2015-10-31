var env = {

  name: function() {
    return (!process.env.BUILD_ENV) ? 'development' : process.env.BUILD_ENV;
  },

  webappUrl: function() {
    return 'https://angularjs.org';
  }

};

module.exports = env;