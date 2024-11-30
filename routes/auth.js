const express = require('express');
const router = express.Router()
const controllers = require('../controllers/authController')

router.get('/register', controllers.register)

module.exports = router;