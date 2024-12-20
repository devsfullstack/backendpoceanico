require('dotenv').config()

module.exports = {
    port: process.env.PORT || 4001,
    mysql: {
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'mydb'
},
    jwt: {
    secretkey: process.env.SECRET_KEY || 'secretkey',
    tokenExpiresIn: process.env.TEI || '1h'
}
}
