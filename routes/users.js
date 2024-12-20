const express = require('express');
const router = express.Router()
const controllers = require('../controllers/users')

router.get('/users', controllers.getAll)
router.get('/user', controllers.getOne)
router.post('/user', controllers.create),
router.put('/', controllers.update),
router.delete('/', controllers.deleted)

module.exports = router;
