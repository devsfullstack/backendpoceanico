const express = require('express')
const app = express()
const config = require('./config')
const morgan = require('morgan')
const cors = require('cors')
const path = require('path')

app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname,'../public')))


const users = require('../routes/users')
const auth = require('../routes/auth')

//app.use('/auth', auth)
app.use('/api', users)
app.use('/api', auth)

app.use('/api/admin', (req, res)=>{res.sendFile(__dirname + '/pages/admin/admin.html')});

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