const express = require('express');
const router = express.Router()
const controllers = require('../controllers/users')
const path = require('path')

router.get('/', controllers.getAll)
router.get('/:id', controllers.getOne)
router.post('/', controllers.create),
router.put('/:id', controllers.update),
router.delete('/:id', controllers.deleted)

module.exports = router;
