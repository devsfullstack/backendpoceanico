const db = require('../app/db')
//const bcrypt = require('bcrypt')

const tabla = 'clientes'
const getAll = (req, res, tabla) => {
    const sql = ("SELECT * FROM clientes")
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.status(500).send('Error en consulta de tabla clientes');
            }
            res.json(results)
            });
            };


const getOne = (req, res) => {

        const id = req.params.id;
        const sql = ("SELECT * FROM clientes WHERE id = ?")
        db.query(sql, {id}, (err, results) => {
            if (err) {
                console.error(err.message);
                return res.status(500).send('Error buscando usuario');
                }
                return res.status(200).json({
                    results})
                    });
                    };

const create = (req, res) => {
    const { name, email, password } = req.body;
    const sql = ("INSERT INTO users SET ?")
    db.query(sql, { name, email, password }, (err, results) => {
        if (err) {
            console.error(err.message);
            return res.status(500).send('Error creando usuario');
            }
            res.json(results)
            });
        }

module.exports = {
    getOne,
    getAll,
    create

    }
