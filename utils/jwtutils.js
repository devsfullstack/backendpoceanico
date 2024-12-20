// jwtUtils.js
const db = require('../app/db')
const jwt = require('jsonwebtoken');
const config = require('../app/config/');


const generateToken = (user) => {
  return jwt.sign({ id: user.id }, config.jwt.jwtSecret, { expiresIn: config.jwt.expiresIn });
};

const verifyToken = (generateToken) => {
  try {
    return jwt.verify(token, config.jwt.jwtSecret);
  } catch (err) {
    throw new Error('Token verification failed');
  }
};

module.exports = { generateToken, verifyToken };