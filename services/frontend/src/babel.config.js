// babel.config.js
module.exports = {
  presets: [
    "@babel/preset-env",   // Transpiles ES6+ down to ES5
    "@babel/preset-react"  // Transpiles JSX
  ],
  plugins: [
    "@babel/plugin-proposal-private-property-in-object"  // Enable parsing of private properties in objects
  ]
};
