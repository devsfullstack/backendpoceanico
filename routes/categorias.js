const express = require('express');
const router = express.Router()
const controllers = require('../controllers/categorias')
const path = require('path')

router.get('/', controllers.getAll)
router.get(path.join('/'+'?:id'), controllers.getOne)
router.post('/', controllers.create)

module.exports = router;