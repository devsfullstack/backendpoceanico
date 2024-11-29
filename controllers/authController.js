const jwt = require('jsonwebtoken');
const db = require('../app/db')
const bcrypt = require('bcryptjs')
const config = require('../app/config')


const register = (req, res) => {

    const {id} = req.body;

    const token = jwt.sign({ id }, config.auth.secretkey, {
        expiresIn: config.auth.tokenExpiresIn
        });
        
        res.status(200).json({ auth: true, token: token });

}

module.exports = register;