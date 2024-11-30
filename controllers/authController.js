const jwt = require('jsonwebtoken');
const db = require('../app/db')
const bcrypt = require('bcryptjs')
const config = require('../app/config')

const tabla = 'users'


const login = async (req, res) => {
    const { email, password } = req.body
    const user = await db.User.findOne({ where: { email } })
    if (!user) {
        return res.status(401).json({ message: 'Invalid email or password' })
        }
        const isValidPassword = await bcrypt.compare(password, user.password)
        if (!isValidPassword) {
            return res.status(401).json({ message: 'Invalid email or password' })
            }
            const token = jwt.sign({ userId: user.id }, config.secret, { expiresIn: '1 h' })
            res.json({ token })
            }
        
const register = async (req, res) => {
    
    const { user, imagen, email, password, rol } = req.body;

    //const password2 = bcrypt.hashSync(password, 10);
 

    const sql = (`INSERT INTO ${tabla} (user, imagen, email, password, rol) VALUES ("${user}", "${imagen}", "${email}", "${password}", "${rol}")`)
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.status(500).send(`Error creando registro en tabla: ${tabla}`);
            }
            res.json(results)
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
