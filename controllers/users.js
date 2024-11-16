const db = require('../app/db')
const bcrypt = require('bcryptjs');

const tabla = 'users'

const getAll = (req, res) => {

    const sql = (`SELECT * FROM ${tabla}`)
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.status(500).send(`Error al consultar la tabla: ${tabla}`);
            }
            return res.status(200).json({
                results
            })
            });
            };


const getOne = (req, res) => {
    const {id} = req.body
    const {user} = req.body
    const {email} = req.body
    const {nombre} = req.body

    if(id > 0){
        const sql = (`SELECT * FROM ${tabla} WHERE id = '${id}'`)
        db.query(sql, (err, results) => {
            if (err) {
                console.error(err.message);
                return res.status(500).send(`Error al consultar la tabla: ${tabla}`);
                }
                if (results.length === 0) {
                    return res.status(404).send(`El usuario con id ${id} no existe`);
                    }
                    return res.status(200).json({
                        results
    
    
        })
    })
    } 

    if (user){
        const sql = (`SELECT * FROM ${tabla} WHERE user = '${user}'`)
        db.query(sql, (err, results) => {
            if (err) {
                console.error(err.message);
                return res.status(500).send(`Error al consultar la tabla: ${tabla}`);
                }
                if (results.length === 0) {
                    return res.status(404).send(`El usuario con user ${user} no existe`);
                    }
                    return res.status(200).json({
                        results
                    })
                })
        }

        if(email){
            const sql = (`SELECT * FROM ${tabla} WHERE email = '${email}'`)
            db.query(sql, (err, results) => {
                if (err) {
                    console.error(err.message);
                    return res.status(500).send(`Error al consultar la tabla: ${tabla}`);
                    }
                    if (results.length === 0) {
                        return res.status(404).send(`El usuario con email ${email} no existe`);
                        }
                        return res.status(200).json({
                            results
                            })
                            })
        }

        if (nombre){
            const sql = (`SELECT * FROM ${tabla} WHERE nombre = '${nombre}'`)
            db.query(sql, (err, results) => {
                if (err) {
                    console.error(err.message);
                    return res.status(500).send(`Error al consultar la tabla: ${tabla}`);
                    }
                    if (results.length === 0) {
                        return res.status(404).send(`El usuario con nombre ${nombre} no existe`);
                        }
                        return res.status(200).json({
                            results
                            })
                            })

        }
}


const create = (req, res) => {

    const { user, imagen, nombre, email, password, rol } = req.body;

    const password2 = bcrypt.hashSync(password, 10);
 

    const sql = (`INSERT INTO ${tabla} (user, imagen, nombre, email, password, rol) VALUES ("${user}", "${imagen}", "${nombre}", "${email}", "${password2}", "${rol}")`)
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.status(500).send(`Error creando registro en tabla: ${tabla}`);
            }
            res.json(results)
            });
        }

    const update = (req, res)=>{

    }    

    const deleted = (req,res) =>{

    }
    
module.exports = {
    getOne,
    getAll,
    create,
    update,
    deleted
}
