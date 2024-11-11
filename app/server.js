const express = require('express')
const app = express()
const config = require('./config')
const morgan = require('morgan')
const cors = require('cors')

app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api', require('../routes'));

const port = config.port

const server = async()=>{
    try {
        await app.listen(port, () => {
            console.log(`Servidor corriendo por el puerto: ${port}`)
            })    
    } catch (error) {
        throw new Error(error)
    }
    
}

module.exports = server;