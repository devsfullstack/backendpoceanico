/// insertData.js
const db = require('../app/db');
const bcrypt = require('bcrypt');

const nombre = 'Juan';
const apellido = 'Pérez';
const usuario = 'juan_perez';
const contraseña = 'mi_contraseña_segura'; 
const email = 'juan.perez@gmail.com';
const cargo = 'Empleado';
const rol = 'empleado';

const insertarUsuario = () => {
   

    // Asegúrate de esperar la resolución de la promesa de hash de contraseña
    const hashedPassword = bcrypt.hash(contraseña, 10);

        const sql = (`INSERT INTO usuarios (nombre, apellido, usuario, contraseña, email, cargo, rol) VALUES ("${nombre}", "${apellido}", "${usuario}", "${hashedPassword}", "${email}", "${cargo}", "${rol}")`)

        db.query(sql, (err, results) => {
            if (err) {
                console.error(err);
                return;
                }
                console.log(results);
                }
        )

};

insertarUsuario();
