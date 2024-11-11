const db = require('../app/db')
const bcrypt = require('bcryptjs')

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

        const id = req.body.id;
        const sql = (`SELECT * FROM ${tabla} WHERE id = ${id}`)
        db.query(sql, (err, results) => {
            if (err) {
                console.error(err.message);
                return res.status(500).send(`Error al buscar registro en tabla: ${tabla}`);
                }
                return res.status(200).json({
                    results})
                    });
                    };

const create = (req, res) => {

    const { user, imagen, name, email, password } = req.params;

    const password2 = bcrypt.hashSync('password',10)

    const sql = (`INSERT INTO ${tabla} (user, password, email, name, imagen, rol) VALUES ('?','?','?','?','?')`)
    db.query(sql, { name, email, password2 }, (err, results) => {
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
