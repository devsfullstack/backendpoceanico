const express = require('express');
const router = express.Router();
const controllers = require('../controllers/authController'); // Asegúrate de que la ruta sea correcta
const verifyToken = require('../middleware/verifyToken'); // Asegúrate de que la ruta sea correcta

// Ruta para registrar un nuevo usuario
router.post('/register', controllers.register); // Usa 'register' directamente

// Ruta para iniciar sesión
router.post('/login', controllers.login); // Usa 'login' directamente

// Ruta protegida

const {rol} = req.body

router.get('/ruta-protegida', controllers.verifyToken, (req, res) => {
    if (rol !== 'admin') {
        return res.status(403).json({ error: 'Acceso denegado.' });
    }

    // Lógica para los usuarios admin
    return res.status(200).json({ message: 'Acceso permitido para admin.' });
});

module.exports = router;
