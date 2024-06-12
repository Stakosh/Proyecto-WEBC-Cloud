// App.test.js
import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';  // Adjust the path as necessary

describe('App Component', () => {
  test('renders without crashing', () => {
    render(<App />);
    expect(screen.getByRole('button', { name: /login/i })).toBeInTheDocument();
  });
});
