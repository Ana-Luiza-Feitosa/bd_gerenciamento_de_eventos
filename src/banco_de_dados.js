import mysql from 'mysql2/promise';

const pool = mysql.createPool({
  host: 'gerencia-eventos.cp4i800689fg.sa-east-1.rds.amazonaws.com',
  user: 'admin',
  password: 'fgBSssBe0KGw5gCiy1rt',
  database: 'gerencia_eventos'
});

export default pool;