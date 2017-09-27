
const webpack = require('webpack');
const { resolve } = require('path');

const ManifestPlugin = require('webpack-manifest-plugin');
const webpackConfigLoader = require('react-on-rails/webpackConfigLoader');
const cortexPluginLibraries = require("../tmp/cortex_plugin_libraries.json");

const configPath = resolve('..', 'config');
const { devBuild, manifest, webpackOutputPath, webpackPublicOutputDir } =
  webpackConfigLoader(configPath);

const config = {

  context: resolve(__dirname),

  entry: {
    'webpack-bundle': [
      'es5-shim/es5-shim',
      'es5-shim/es5-sham',
      'babel-polyfill',
      './app/bundles/cortex/startup/cortex_app',
    ].concat(cortexPluginLibraries),
  },

  output: {
    // Name comes from the entry section.
    filename: '[name]-[hash].js',

    // Leading slash is necessary
    publicPath: `/${webpackPublicOutputDir}`,
    path: webpackOutputPath,
  },

  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      cortex: resolve('./app/bundles/cortex'),
      constants: resolve('./app/bundles/cortex/constants'),
      containers: resolve('./app/bundles/cortex/containers'),
      components: resolve('./app/bundles/cortex/components')
    }
  },

  plugins:[
    new webpack.EnvironmentPlugin({
      NODE_ENV: 'development', // use 'development' unless process.env.NODE_ENV is defined
      DEBUG: false,
    }),
    new ManifestPlugin({ fileName: manifest, writeToFileEmit: true }),
  ],
  module: {
    rules: [
      {
        test: require.resolve('react'),
        use: {
          loader: 'imports-loader',
          options: {
            shim: 'es5-shim/es5-shim',
            sham: 'es5-shim/es5-sham',
          },
        },
      },
      {
        test: /\.jsx?$/,
        use: 'babel-loader',
        exclude: /node_modules(?!\/cortex-plugins-.)/, // don't run babel on node_modules except for Cortex plugins
      },
    ],
  },
};

module.exports = config;

if (devBuild) {
  console.log('Webpack dev build for Rails'); // eslint-disable-line no-console
  module.exports.devtool = 'eval-source-map';
} else {
  console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}
