import express from 'express';
import cors from 'cors';
import pool from './src/banco_de_dados.js';

const app = express();
app.use(cors());
app.use(express.json());

//Caminho para executar SQL
app.post('/sql', async (req, res) => {
    try {
        const { query, params } = req.body;
        const [result] = await pool.execute(query, params || []);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(3001, () => console.log('Servidor rodando na porta 3001'));
