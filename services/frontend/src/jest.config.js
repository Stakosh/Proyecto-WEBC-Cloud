// jest.config.js
module.exports = {
    transformIgnorePatterns: [
      "node_modules/(?!axios)/"
    ],
    transform: {
      '^.+\\.jsx?$': 'babel-jest'
    },
    moduleNameMapper: {
      '\\.(css|less|scss|sass|jpg|jpeg|png|gif|webp|svg)$': 'identity-obj-proxy'
    },
    testEnvironment: 'jsdom'
  };
  