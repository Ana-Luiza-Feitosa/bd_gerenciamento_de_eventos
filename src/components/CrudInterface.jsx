import React, { useState, useEffect } from 'react';

const CrudInterface = () => {
  const [selectedTable, setSelectedTable] = useState('');
  const [formData, setFormData] = useState({});
  const [editMode, setEditMode] = useState(false);
  const [selectedId, setSelectedId] = useState(null);
  const [data, setData] = useState([]);
  const [error, setError] = useState('');

  const tables = {
    Evento: ['Nome', 'Edicao', 'Descricao', 'Data_Inicio', 'Data_Termino'],
    Participante: ['Nome', 'Idade', 'Email', 'Instituicao'],
  };

  const executarSQL = async (query, params = []) => {
    try {
      const response = await fetch('http://localhost:3001/sql', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query, params }),
      });

      return await response.json();
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

    await executarSQL(`INSERT INTO ${selectedTable} (${fields}) VALUES (${placeholders})`, values);
    loadTableData();
  };

  const handleDelete = async (id) => {
    await executarSQL(`DELETE FROM ${selectedTable} WHERE id = ?`, [id]);
    loadTableData();
  };

  const handleEdit = (item) => {
    setEditMode(true);
    setSelectedId(item.id);
    setFormData(item);
  };

  return (
    <div className="p-6 max-w-6xl mx-auto">
      <h1 className="text-3xl font-bold mb-6 text-center text-gray-800">🎉 Gerenciamento de Eventos</h1>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
          {error}
        </div>
      )}

      <div className="flex justify-center mb-6">
        <select
          value={selectedTable}
          onChange={(e) => setSelectedTable(e.target.value)}
          className="p-3 border rounded-lg shadow-md bg-white"
        >
          <option value="">Selecione uma tabela</option>
          {Object.keys(tables).map((table) => (
            <option key={table} value={table}>
              {table}
            </option>
          ))}
        </select>
      </div>

      {selectedTable && (
        <div className="bg-white p-6 rounded-lg shadow-md mb-6">
          <h2 className="text-lg font-semibold mb-4">{editMode ? `Editar ${selectedTable}` : `Novo ${selectedTable}`}</h2>
          <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
            {tables[selectedTable].map((field) => (
              <input
                key={field}
                type="text"
                placeholder={field}
                value={formData[field] || ''}
                onChange={(e) => setFormData({ ...formData, [field]: e.target.value })}
                className="p-2 border rounded-md"
              />
            ))}
          </div>
          <button
            onClick={handleCreate}
            className="mt-4 px-6 py-2 bg-green-500 hover:bg-green-600 text-white rounded-md"
          >
            {editMode ? 'Atualizar' : 'Criar'}
          </button>
        </div>
      )}

      {selectedTable && (
        <div className="overflow-x-auto">
          <table className="w-full border-collapse bg-white shadow-lg rounded-lg">
            <thead className="bg-gray-100">
              <tr>
                <th className="p-3 text-left border-b">ID</th>
                {tables[selectedTable].map((field) => (
                  <th key={field} className="p-3 text-left border-b">{field}</th>
                ))}
                <th className="p-3 text-left border-b">Ações</th>
              </tr>
            </thead>
            <tbody>
              {data.map((item, index) => (
                <tr key={item.id} className={`${index % 2 === 0 ? 'bg-gray-50' : 'bg-white'}`}>
                  <td className="p-3 border-b">{item.id}</td>
                  {tables[selectedTable].map((field) => (
                    <td key={field} className="p-3 border-b">{item[field]}</td>
                  ))}
                  <td className="p-3 border-b">
                    <button
                      onClick={() => handleEdit(item)}
                      className="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded-md mr-2"
                    >
                      Editar
                    </button>
                    <button
                      onClick={() => handleDelete(item.id)}
                      className="px-4 py-2 bg-red-500 hover:bg-red-600 text-white rounded-md"
                    >
                      Excluir
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

export default CrudInterface;
