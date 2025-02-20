import React, { useState, useEffect } from 'react';
import './style.css'; // Importando o CSS puro

const CrudInterface = () => {
  const [selectedTable, setSelectedTable] = useState('');
  const [formData, setFormData] = useState({});
  const [editMode, setEditMode] = useState(false);
  const [selectedId, setSelectedId] = useState(null);
  const [data, setData] = useState([]);
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');

  const tables = {
    Evento: ['ID', 'Nome', 'Edicao', 'Descricao', 'Data_Inicio', 'Data_Termino'],
    Participante: ['ID', 'Nome', 'Idade', 'Email', 'Instituicao'],
  };

  const executarSQL = async (query, params = []) => {
    try {
      console.log("🔍 Enviando SQL:", query, params);

      const response = await fetch('http://localhost:3001/sql', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query, params }),
      });

      const result = await response.json();
      console.log("✅ Resposta do servidor:", result);
      return result;
    } catch (err) {
      setError(`Erro ao executar SQL: ${err.message}`);
      return [];
    }
  };

  const loadTableData = async () => {
    if (!selectedTable) return;
    const result = await executarSQL(`SELECT * FROM ${selectedTable}`);
    setData(result);
  };

  useEffect(() => {
    if (selectedTable) loadTableData();
  }, [selectedTable]);

  const handleCreate = async () => {
    const fields = Object.keys(formData).join(', ');
    const placeholders = Object.keys(formData).map(() => '?').join(', ');
    const values = Object.values(formData);

    console.log(`🟢 Inserindo: INSERT INTO ${selectedTable} (${fields}) VALUES (${placeholders})`, values);

    await executarSQL(`INSERT INTO ${selectedTable} (${fields}) VALUES (${placeholders})`, values);
    setMessage("Registro criado com sucesso!");
    setFormData({});
    loadTableData();
  };

  const handleUpdate = async () => {
    if (!selectedId) {
      setError("Erro: Nenhum ID selecionado para atualização.");
      return;
    }

    const updates = Object.keys(formData).map(field => `${field} = ?`).join(', ');
    const values = [...Object.values(formData), selectedId];

    console.log(`🔄 Atualizando: UPDATE ${selectedTable} SET ${updates} WHERE ID = ?`, values);

    await executarSQL(`UPDATE ${selectedTable} SET ${updates} WHERE ID = ?`, values);
    setMessage("Registro atualizado com sucesso!");
    setEditMode(false);
    setFormData({});
    setSelectedId(null);
    loadTableData();
  };

  const handleDelete = async (id) => {
    if (!id) {
      setError('Erro: ID inválido para exclusão.');
      console.error("🛑 ID inválido recebido para exclusão:", id);
      return;
    }

    console.log(`🚀 Tentando excluir o registro com ID: ${id}`);

    await executarSQL(`DELETE FROM ${selectedTable} WHERE ID = ?`, [id]);
    setMessage("Registro excluído com sucesso!");
    loadTableData();
  };

  const handleEdit = (item) => {
    setEditMode(true);
    setSelectedId(item.ID || item.id);
    setFormData(item);
  };

  return (
    <div className="container">
      {error && <div className="error-message">{error}</div>}
      {message && <div className="success-message">{message}</div>}

      <div className="dropdown">
        <select value={selectedTable} onChange={(e) => setSelectedTable(e.target.value)}>
          <option value="">Selecione uma tabela</option>
          {Object.keys(tables).map((table) => (
            <option key={table} value={table}>{table}</option>
          ))}
        </select>
      </div>

      {selectedTable && (
        <div className="form-container">
          <h2>{editMode ? `Editar ${selectedTable}` : `Novo ${selectedTable}`}</h2>
          <div className="form-grid">
            {tables[selectedTable].map((field) => (
              field !== 'ID' && ( // Não exibir campo ID no formulário
                <input
                  key={field}
                  type="text"
                  placeholder={field}
                  value={formData[field] || ''}
                  onChange={(e) => setFormData({ ...formData, [field]: e.target.value })}
                />
              )
            ))}
          </div>
          {editMode ? (
            <button onClick={handleUpdate} className="btn blue">Atualizar</button>
          ) : (
            <button onClick={handleCreate} className="btn green">Criar</button>
          )}
        </div>
      )}

      {selectedTable && (
        <div className="table-container">
          <table>
            <thead>
              <tr>
                {tables[selectedTable].map((field) => (
                  <th key={field}>{field}</th>
                ))}
                <th>Ações</th>
              </tr>
            </thead>
            <tbody>
              {data.map((item) => {
                console.log("Item recebido para renderizar:", item);
                return (
                  <tr key={item.ID || item.id}>
                    {tables[selectedTable].map((field) => (
                      <td key={field}>{item[field]}</td>
                    ))}
                    <td>
                      <button onClick={() => handleEdit(item)} className="btn yellow">Editar</button>
                      <button onClick={() => handleDelete(item.ID || item.id)} className="btn red">Excluir</button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default CrudInterface;
