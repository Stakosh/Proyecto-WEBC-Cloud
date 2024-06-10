// App.test.js
import React from 'react';
import { render, screen } from '@testing-library/react';
import { BrowserRouter as Router } from 'react-router-dom';
import App from './App';

// Función de utilidad para envolver el componente en el Router
const renderWithRouter = (ui, { route = '/' } = {}) => {
  window.history.pushState({}, 'Test page', route);
  return render(ui, { wrapper: Router });
};

describe('App Routing', () => {
  test('redirecciona desde "/" a "/login"', () => {
    renderWithRouter(<App />);
    // Verifica que el usuario es redirigido a "/login" automáticamente
    expect(window.location.pathname).toEqual('/login');
  });

  // Puedes agregar más pruebas para verificar otras rutas si es necesario
});
