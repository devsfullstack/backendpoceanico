const jwt = require('jsonwebtoken');
const db = require('../app/db')
const bcrypt = require('bcryptjs')
const config = require('../app/config')

const tabla = 'users'


const login = async (req, res) => {

    const { user, password } = req.body

    const sql = `SELECT * FROM ${tabla} WHERE user = '${user}'`

    db.query(sql, (err, results) => {
        if (err) { return res.status(500).send(`No se encontro el usuario`) }
        if (results.length === 0) { return res.status(404).send(`No se encontro el usuario`) }

        return res.status(200).json({ message: 'Usuario encontrado, Bienvenido '+user,
            results
         })
        })}

        //const isValidPassword = bcrypt.compareSync(password, user.password)
        
        //if (!isValidPassword) {return res.status(401).json({ message: 'Contraseña invalida' })}
            
           // const token = jwt.sign({ id: user.id, user: user.user }, config.auth.secretkey, { expiresIn: config.auth.tokenExpiresIn})
        
       // if(!token){res.status(500).json({message: 'Error al generar token'})}
            
        //return res.status(200).json({ token })


                     
const register = async (req, res) => {
    
    res.sendFile(__dirname+'../app/pages/register.html')

    const { user, imagen, email, password, rol } = req.body;

    const password2 = bcrypt.hashSync(password, 10);
    
    if(!user || !email || !password || !rol) {return res.status(400).json({message: 'Debe llenar todos los campos solicitados'})}
    
    const usuarioRevisar = await db.users.findOne({ where: { user } })
    
    if(usuarioRevisar) {return res.status(400).json({message: 'El usuario ya existe'})}
        
    const sql = await (`INSERT INTO ${tabla} (user, imagen, email, password, rol) VALUES ("${user}", "${imagen}", "${email}", "${password2}", "${rol}")`)

    db.query(sql, (err, results) => {
            if (err) {
                console.error(err.message);
                return res.status(500).send(`Error creando registro en tabla: ${tabla}`);
                }
                return res.status(200).json(results)
                });

            /*const token = jwt.sign({id: users.id}, config.auth.secretkey, {
                expiresIn: config.auth.tokenExpiresIn
                });

                res.status(200).json({
                    auth: true,
                    token: token,
                    user: users
                })*/
        }
    




module.exports = {
    register,
    login
    }
