const express = require('express');
const router = express.Router()
const controllers = require('../controllers/users')

router.get('/users', controllers.getAll)
router.get('/user', controllers.getOne)
router.post('/users', controllers.create),
router.put('/user/:id', controllers.update),
router.delete('/user/:id', controllers.deleted)

module.exports = router;
