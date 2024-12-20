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


app.use('/api', require('../routes/users'))
app.use('/api', require('../routes/categorias'))
app.use('/api', require('../routes/clientes'))
app.use('/api', require('../routes/comisiones'))
app.use('/api', require('../routes/cuentas'))
app.use('/api', require('../routes/egresos'))
app.use('/api', require('../routes/ingresos'))
app.use('/api', require('../routes/movimientos'))
app.use('/api', require('../routes/presupuestos'))
app.use('/api', require('../routes/productos'))
app.use('/api', require('../routes/proveedores'))


// Middleware para manejo de errores
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Algo salió mal!');
});

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