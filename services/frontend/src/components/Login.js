import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Container, Button, Row, Col, Form } from 'react-bootstrap';
import { useTranslation } from 'react-i18next';
import ImgFondo from '../img/fondo-1.jpg';  // Ensure the image path is correct

function Login() {
    const navigate = useNavigate();
    const { t } = useTranslation("global");
    const [formData, setFormData] = useState({ email: '', password: '' });

    const handleChange = (event) => {
        const { name, value } = event.target;
        setFormData(prevState => ({ ...prevState, [name]: value }));
    };

    const handleFormSubmit = (event) => {
        event.preventDefault();
        console.log('Login attempted:', formData);

        // Check if the email and password match the specific credentials
        if (formData.email === 'queso@queso.cl' && formData.password === 'queso') {
            navigate('/inicio'); // Navigate to the 'inicio' route if credentials match
        } else {
            alert('Invalid credentials, please try again.'); // Inform the user of invalid credentials
        }
    };

    return (
        <div style={{ backgroundImage: `url(${ImgFondo})`, backgroundSize: 'cover', backgroundPosition: 'center', height: '100vh' }}>
            <Container>
                <Row className="justify-content-center align-items-center" style={{ height: '100%' }}>
                    <Col md={6} lg={4} className="mt-20">
                        <div className="login-box bg-white p-4 rounded shadow">
                            <h2 className="text-center mb-4">{t('login')}</h2>
                            <Form onSubmit={handleFormSubmit}>
                                <Form.Group controlId="formEmail" className="mb-3">
                                    <Form.Label>{t('email')}:</Form.Label>
                                    <Form.Control
                                        type="email"
                                        name="email"
                                        value={formData.email}
                                        onChange={handleChange}
                                        placeholder={t('email')}
                                        required
                                    />
                                </Form.Group>

                                <Form.Group controlId="formPassword" className="mb-3">
                                    <Form.Label>{t('password')}:</Form.Label>
                                    <Form.Control
                                        type="password"
                                        name="password"
                                        value={formData.password}
                                        onChange={handleChange}
                                        placeholder={t('password')}
                                        required
                                    />
                                </Form.Group>

                                <Button type="submit" className="w-100 mb-2" style={{ backgroundColor: '#83d134', color: 'black' }}>
                                    {t('login')}
                                </Button>
                            </Form>
                            <div className="text-center">
                                <Button variant="link" onClick={() => navigate('/new')}>{t('newRegister')}</Button>
                                <Button variant="link" onClick={() => navigate('/forgot-password')}>{t('forgotPassword')}</Button>
                            </div>
                            <div className="text-center mt-3">
                            </div>
                        </div>
                    </Col>
                </Row>
            </Container>
        </div>
    );
}

export default Login;
