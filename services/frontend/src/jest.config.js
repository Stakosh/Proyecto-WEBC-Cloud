// jest.config.js
module.exports = {
  moduleNameMapper: {
    "^axios$": "axios/dist/node/axios.cjs"
  },
  setupFilesAfterEnv: [
    "<rootDir>/src/setupTests.js"  // Typical setup file for React Testing Library
  ],
  testEnvironment: "jsdom",  // Specifies the environment in which the tests should run
  transform: {
    "^.+\\.jsx?$": "babel-jest",  // Transform JavaScript and JSX files with babel-jest
  }
};
