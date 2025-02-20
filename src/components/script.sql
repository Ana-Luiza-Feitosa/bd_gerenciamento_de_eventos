CREATE DATABASE gerencia-eventos;
USE gerencia-eventos;

CREATE TABLE Evento(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL, 
Edicao int NOT NULL, 
Descricao varchar(500),
 Data_Inicio date NOT NULL,
 Data_Termino date NOT NULL);

CREATE TABLE Local_Evento(
Evento_ID int,
Local_ID int,
PRIMARY KEY (Evento_ID, Local_ID),
FOREIGN KEY (Evento_ID) REFERENCES Evento(ID));

CREATE TABLE Sessao(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL,
Descricao varchar(500),
Data date NOT NULL,
Hora_Inicio time NOT NULL,
Hora_Termino time NOT NULL,
Evento_ID int NOT NULL,
Tipo_ID int NOT NULL,
Topico_ID int NOT NULL,
FOREIGN KEY (Evento_ID) REFERENCES Evento(ID),
FOREIGN KEY (Tipo_ID) REFERENCES Tipo(ID),
FOREIGN KEY (Topico_ID) REFERENCES Topico(ID));

CREATE TABLE Tipo(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL,
Tipo varchar(50),
Plataforma varchar(50),
Link_Acesso varchar(50),
Codigo_Acesso varchar(50));

CREATE TABLE Local_Presencial(
Tipo_ID int,
Local_ID int,
PRIMARY KEY (Tipo_ID, Local_ID),
FOREIGN KEY (Tipo_ID) REFERENCES Tipo(ID));

CREATE TABLE Topico(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL,
Descricao varchar(500));

CREATE TABLE Participante(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL,
Idade int,
Email varchar(100) UNIQUE NOT NULL,
Instituicao varchar(100));

CREATE TABLE Participante_Evento(
Participante_ID int,
Evento_ID int,
PRIMARY KEY (Participante_ID, Evento_ID),
FOREIGN KEY (Participante_ID) REFERENCES Participante(ID),
FOREIGN KEY (Evento_ID) REFERENCES Evento(ID));

CREATE TABLE Palestrante(
Participante_ID int PRIMARY KEY,
Formacao varchar(100),
Atuacao varchar(100),
FOREIGN KEY (Participante_ID) REFERENCES Participante(ID));

CREATE TABLE Palestrante_Sessao(
Participante_ID int,
Sessao_ID int,
PRIMARY KEY (Participante_ID, Sessao_ID),
FOREIGN KEY (Participante_ID) REFERENCES Palestrante(Participante_ID),
FOREIGN KEY (Sessao_ID) REFERENCES Sessao(ID));

CREATE TABLE Ouvinte(
Tipo varchar(100),
Participante_ID int PRIMARY KEY,
FOREIGN KEY (Participante_ID) REFERENCES Participante(ID));

CREATE TABLE Moderador(
Atuacao varchar(100),
Participante_ID int PRIMARY KEY,
FOREIGN KEY (Participante_ID) REFERENCES Participante(ID));

CREATE TABLE Inscricao(
ID int PRIMARY KEY AUTO_INCREMENT,
Data date NOT NULL,
Horario time NOT NULL,
Participante_ID int NOT NULL,
Organizador_ID int NOT NULL,
Status_Inscricao_ID int NOT NULL,
FOREIGN KEY (Participante_ID) REFERENCES Participante(ID),
FOREIGN KEY (Organizador_ID) REFERENCES Organizador(ID),
FOREIGN KEY (Status_Inscricao_ID) REFERENCES Status_Inscricao(ID));

CREATE TABLE Status_Inscricao(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL,
Descricao varchar(500));

CREATE TABLE Certificado(
ID int PRIMARY KEY AUTO_INCREMENT,
Data_Emissao date NOT NULL,
Participante_ID int NOT NULL,
FOREIGN KEY (Participante_ID) REFERENCES Participante(ID));

CREATE TABLE Local(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL,
Endereco varchar(200),
Cidade varchar(100),
Estado varchar(100),
Capacidade int,
Descricao varchar(500));


CREATE TABLE Apoiador(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(100) NOT NULL,
Descricao varchar(500));


CREATE TABLE Apoiador_Evento(
Apoiador_ID int,	
Evento_ID int,
PRIMARY KEY (Apoiador_ID, Evento_ID),
FOREIGN KEY (Apoiador_ID) REFERENCES Apoiador(ID),
FOREIGN KEY (Evento_ID) REFERENCES Evento(ID));

CREATE TABLE Patrocinador(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(150) NOT NULL,
Tipo varchar(100));

CREATE TABLE Patrocinador_Evento(
Patrocinador_ID int,
Evento_ID int,
PRIMARY KEY (Patrocinador_ID, Evento_ID),
FOREIGN KEY (Patrocinador_ID) REFERENCES Patrocinador(ID),
FOREIGN KEY (Evento_ID) REFERENCES Evento(ID));

CREATE TABLE Artigo(
ID int PRIMARY KEY AUTO_INCREMENT,
Titulo varchar(150) NOT NULL,
Descricao varchar(500),
Status_Submissao_ID int NOT NULL,
FOREIGN KEY (Status_Submissao_ID) REFERENCES Status_Submissao(ID));

CREATE TABLE Artigo_Evento(
Evento_ID int,
Artigo_ID int,
PRIMARY KEY (Evento_ID, Artigo_ID),
FOREIGN KEY (Evento_ID) REFERENCES Evento(ID),
FOREIGN KEY (Artigo_ID) REFERENCES Artigo(ID));

CREATE TABLE Pesquisador(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(255) NOT NULL,
Linha_Pesquisa text,Instituicao_ID int NOT NULL,
FOREIGN KEY (Instituicao_ID) REFERENCES Instituicao(ID));

CREATE TABLE Pesquisador_Artigo(
Artigo_ID int,
Pesquisador_ID int,
PRIMARY KEY (Artigo_ID, Pesquisador_ID),
FOREIGN KEY (Artigo_ID) REFERENCES Artigo(ID),
FOREIGN KEY (Pesquisador_ID) REFERENCES Pesquisador(ID));

CREATE TABLE Instituicao(
ID int PRIMARY KEY AUTO_INCREMENT,
Sigla varchar(50) NOT NULL,
Nome varchar(150) NOT NULL,
UF varchar(3),
Pais varchar(100));

CREATE TABLE Instituicao_Pesquisador(
Instituicao_ID int,
Pesquisador_ID int,
PRIMARY KEY (Instituicao_ID, Pesquisador_ID),
FOREIGN KEY (Instituicao_ID) REFERENCES Instituicao(ID),
FOREIGN KEY (Pesquisador_ID) REFERENCES Pesquisador(ID));

CREATE TABLE Organizador(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(150) NOT NULL,
Funcao varchar(100),
Equipe_ID int NOT NULL,
FOREIGN KEY (Equipe_ID) REFERENCES Equipe(ID));

CREATE TABLE Organizador_Evento(
Evento_ID int,Organizador_ID int,
PRIMARY KEY (Evento_ID, Organizador_ID),
FOREIGN KEY (Evento_ID) REFERENCES Evento(ID),
FOREIGN KEY (Organizador_ID) REFERENCES Organizador(ID));

CREATE TABLE Equipe(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(255) NOT NULL,
Descricao varchar(500));

CREATE TABLE Status_Submissao(
ID int PRIMARY KEY AUTO_INCREMENT,
Nome varchar(150) NOT NULL,
Descricao varchar(500));


--INSERINDO DADOS NAS TABELAS
--Evento:
INSERT INTO Evento (Nome, Edicao, Descricao, Data_Inicio, Data_Termino) VALUES
('Congresso de Engenharia', 10, 'Discussões sobre inovações e pesquisas na área de engenharia.', '2025-05-10', '2025-05-12'),
('Seminário de Inteligência Artificial', 4, 'Palestras e workshops sobre avanços em IA e aprendizado de máquina.', '2025-06-20', '2025-06-22'),
('Encontro Nacional de Matemática', 15, 'Evento voltado para pesquisadores e estudantes de matemática.', '2025-07-05', '2025-07-07'),
('Jornada de Pesquisa em Educação', 8, 'Apresentação de trabalhos acadêmicos sobre metodologias de ensino.', '2025-08-15', '2025-08-17'),
('Simpósio de Biotecnologia', 6, 'Debates sobre aplicações da biotecnologia na indústria e na saúde.', '2025-09-10', '2025-09-12'),
('Conferência de Física Teórica', 12, 'Discussão sobre novos modelos e teorias no campo da física.', '2025-10-01', '2025-10-03'),
('Fórum de Ciências Sociais', 9, 'Debates sobre impactos sociais e novas abordagens teóricas.', '2025-11-05', '2025-11-07'),
('Workshop de Computação Quântica', 3, 'Exploração de algoritmos quânticos e suas aplicações.', '2025-12-01', '2025-12-03'),
('Seminário de Literatura Comparada', 7, 'Análises sobre literatura e cultura em diferentes contextos.', '2025-09-20', '2025-09-22'),
('Colóquio de História Contemporânea', 11, 'Discussão sobre eventos históricos e suas repercussões atuais.', '2025-06-10', '2025-06-12'),
('Simpósio de Neurociência e IA', 1, 'Discussões sobre o impacto da inteligência artificial na neurociência e suas aplicações.', '2025-09-15', '2025-09-17'),
('Congresso Internacional de Astrofísica', 3, 'Evento reunindo pesquisadores para explorar avanços recentes na astrofísica e cosmologia.', '2025-11-05','2025-11-08');

--Local_Evento:
INSERT INTO Local_Evento (Evento_ID, Local_ID) VALUES
(1, 6), 
(2, 3), 
(3, 4), 
(4, 8),  
(5, 9),  
(6, 7),  
(7, 5), 
(8, 2), 
(9, 10), 
(10, 1);

--Sessao:
INSERT INTO Sessao (Nome, Descricao, Data, Hora_Inicio, Hora_Termino, Evento_ID, Tipo_ID, Topico_ID) VALUES
('Abertura do Congresso de Engenharia', 'Sessão inaugural com apresentação do evento e palestra magna.', '2025-05-10', '09:00:00', '10:30:00', 1, 1, 2),
('Mesa Redonda: IA e Ética', 'Discussão sobre os desafios e impactos éticos do uso de inteligência artificial.', '2025-06-20', '14:00:00', '16:00:00', 2, 2, 1),
('Workshop de Programação Avançada', 'Oficina prática sobre algoritmos e otimização de código.', '2025-07-05', '10:00:00', '12:30:00', 3, 3, 8),
('Palestra: Biotecnologia na Medicina', 'Exploração dos avanços recentes da biotecnologia aplicada à saúde.', '2025-09-10', '15:00:00', '16:30:00', 5, 5, 3),
('Painel de Discussão: Computação Quântica', 'Debate sobre o futuro da computação quântica e suas aplicações.', '2025-12-01', '11:00:00', '12:30:00', 8, 7, 5),
('Mini Curso: História e Cultura Digital', 'Análise sobre a preservação digital e o impacto da tecnologia na história.', '2025-09-20', '09:30:00', '11:30:00', 9, 8, 4),
('Seminário sobre Mudanças Climáticas', 'Discussão acadêmica sobre os efeitos das mudanças climáticas globais.', '2025-06-10', '13:00:00', '15:00:00', 10, 10, 10),
('Webinar: Big Data e Análise de Dados', 'Uso de grandes volumes de dados para decisões estratégicas.', '2025-11-05', '17:00:00', '18:30:00', 7, 9, 8),
('Sessão Especial: Literatura e Sociedade', 'Reflexões sobre como a literatura influencia transformações sociais.', '2025-09-20', '16:00:00', '17:30:00', 9, 10, 9),
('Palestra: Exploração Espacial e Astronomia', 'Discussão sobre os avanços na exploração espacial.', '2025-10-01', '10:00:00', '11:30:00', 6, 1, 7);

--Tipo:
INSERT INTO Tipo (Nome, Tipo, Plataforma, Link_Acesso, Código_Acesso) VALUES
('Palestra Magna', 'Presencial', NULL, NULL, NULL),
('Mesa Redonda sobre IA', 'Presencial', NULL, NULL, NULL),
('Workshop de Programação', 'Online', 'Zoom', 'https://zoom.us/j/123456789', 'ABC123'),
('Seminário de Engenharia', 'Presencial', NULL, NULL, NULL),
('Painel de Discussão em Biotecnologia', 'Online', 'Google Meet', 'https://meet.google.com/xyz-1234', 'XYZ789'),
('Apresentação de Trabalhos', 'Presencial', NULL, NULL, NULL),
('Webinar sobre Física Quântica', 'Online', 'Microsoft Teams', 'https://teams.microsoft.com/l/meetup-join/987654321', 'QUANTUM2025'),
('Mini Curso de História', 'Presencial', NULL, NULL, NULL),
('Sessão de Perguntas e Respostas', 'Online', 'YouTube Live', 'https://youtube.com/live/abcd1234', NULL),
('Mesa Redonda sobre Educação', 'Presencial', NULL, NULL, NULL);

--Local_Presencial:
INSERT INTO Local_Presencial (Tipo_ID, Local_ID) VALUES
(1, 6),
(2, 3),
(3, 4),
(5, 7),
(6, 2),
(8, 9),
(9, 1),
(4, 5),
(10, 6),
(7, 8);

--Topico:
INSERT INTO Topico (Nome, Descricao) VALUES
('Inteligência Artificial e Ética', 'Discussão sobre os impactos éticos do uso da inteligência artificial na sociedade.'),
('Avanços na Engenharia Sustentável', 'Novas abordagens para construção e desenvolvimento sustentável na engenharia.'),
('Biotecnologia na Medicina', 'Aplicações da biotecnologia no diagnóstico e tratamento de doenças.'),
('História e Cultura Digital', 'Análise do impacto da era digital na preservação da história e cultura.'),
('Computação Quântica', 'Exploração dos fundamentos da computação quântica e suas aplicações futuras.'),
('Metodologias Ativas na Educação', 'Estratégias inovadoras para engajamento de alunos no ensino superior.'),
('Astronomia e Exploração Espacial', 'Descobertas recentes e o futuro da exploração espacial.'),
('Big Data e Análise de Dados', 'Uso de grandes volumes de dados para tomada de decisões e previsões.'),
('Literatura e Sociedade', 'Como a literatura reflete e influencia transformações sociais ao longo do tempo.'),
('Impactos das Mudanças Climáticas', 'Discussão sobre os efeitos do aquecimento global e políticas ambientais.');

--Participante:
INSERT INTO Participante (Nome, Idade, Email, Instituicao) VALUES
('João Silva', 28, 'joao.silva@example.com', 'Universidade de São Paulo'),
('Maria Oliveira', 35, 'maria.oliveira@example.com', 'Universidade Federal do Rio de Janeiro'),
('Carlos Pereira', 22, 'carlos.pereira@example.com', 'Universidade Estadual de Campinas'),
('Ana Costa', 30, 'ana.costa@example.com', 'Universidade Federal de Minas Gerais'),
('Paulo Santos', 27, 'paulo.santos@example.com', 'Universidade de Brasília'),
('Fernanda Almeida', 40, 'fernanda.almeida@example.com', 'Universidade Federal da Bahia'),
('Lucas Martins', 24, 'lucas.martins@example.com', 'Universidade Estadual Paulista'),
('Beatriz Souza', 31, 'beatriz.souza@example.com', 'Universidade de Pernambuco'),
('Ricardo Lima', 26, 'ricardo.lima@example.com', 'Universidade Federal de Santa Catarina'),
('Patrícia Rocha', 29, 'patricia.rocha@example.com', 'Universidade de Fortaleza'),
('Juliana Ferreira', 25, 'juliana.ferreira@example.com', 'Universidade Federal de São Carlos'),
('Ricardo Costa', 32, 'ricardo.costa@example.com', 'Universidade Estadual de Londrina'),
('Mariana Lima', 29, 'mariana.lima@example.com', 'Universidade de Campinas'),
('Felipe Pereira', 27, 'felipe.pereira@example.com', 'Universidade do Estado de Minas Gerais'),
('Lucas Almeida', 34, 'lucas.almeida@example.com', 'Universidade Federal de Pernambuco'),
('Gabriela Souza', 23, 'gabriela.souza@example.com', 'Universidade de Fortaleza'),
('Rafael Santos', 31, 'rafael.santos@example.com', 'Universidade Estadual do Paraná'),
('Beatriz Oliveira', 28, 'beatriz.oliveira@example.com', 'Universidade de São Paulo'),
('Eduardo Martins', 26, 'eduardo.martins@example.com', 'Universidade Federal de Goiás'),
('Carla Rocha', 30, 'carla.rocha@example.com', 'Universidade de Brasília'),
('Henrique Dias', 33, 'henrique.dias@example.com', 'Universidade Federal de Minas Gerais'),
('Marcos Silva', 24, 'marcos.silva@example.com', 'Universidade Estadual de São Paulo'),
('Patricia Gomes', 28, 'patricia.gomes@example.com', 'Universidade de Pernambuco'),
('André Costa', 35, 'andre.costa@example.com', 'Universidade Estadual de Campinas'),
('Cláudia Alves', 22, 'claudia.alves@example.com', 'Universidade Federal do Espírito Santo'),
('Fabiana Costa', 30, 'fabiana.costa@example.com', 'Universidade de Rio de Janeiro'),
('Vitor Hugo', 26, 'vitor.hugo@example.com', 'Universidade Federal da Bahia'),
('Tatiane Martins', 32, 'tatiane.martins@example.com', 'Universidade do Vale do Rio dos Sinos'),
('Eduardo Souza', 29, 'eduardo.souza@example.com', 'Universidade de Fortaleza');

--Participante_Evento:
INSERT INTO Participante_Evento (Participante_ID, Evento_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10),
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 5),
(26, 6),
(27, 7),
(28, 8),
(29, 9),
(30, 10);

--Palestrante:
INSERT INTO Palestrante (Participante_ID, Formacao, Atuacao) VALUES
(1, 'Engenharia Civil', 'Professor Universitário e Consultor em Infraestrutura'),
(2, 'Ciência da Computação', 'Pesquisadora em Inteligência Artificial e Robótica'),
(3, 'Matemática', 'Professor e Coordenador de Pesquisa em Matemática Pura'),
(4, 'Educação e Psicologia', 'Consultora em Metodologias Ativas no Ensino Superior'),
(5, 'Biotecnologia', 'Pesquisador e Diretor de Inovação em Biotecnologia Médica'),
(6, 'Física', 'Professor Universitário e Pesquisador em Física Quântica'),
(7, 'Ciências Sociais', 'Pesquisador e Especialista em Políticas Públicas'),
(8, 'Computação Quântica', 'Professor e Pesquisador em Computação Quântica Aplicada'),
(9, 'Literatura', 'Professor e Crítico Literário com foco em Literatura Comparada'),
(10, 'História', 'Professor e Especialista em História Contemporânea');

--Palestrante_Sessao:
INSERT INTO Palestrante_Sessao (Participante_ID, Sessao_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--Ouvinte:
INSERT INTO Ouvinte (Tipo, Participante_ID) VALUES
('Ouvinte', 11),
('Ouvinte', 12),
('Ouvinte', 13),
('Ouvinte', 14),
('Ouvinte', 15),
('Ouvinte', 16),
('Ouvinte', 17),
('Ouvinte', 18),
('Ouvinte', 19),
('Ouvinte', 20);

--Moderador:
INSERT INTO Moderador (Atuacao, Participante_ID) VALUES
('Moderador de Sessão: Inovação em Engenharia', 21),
('Moderador de Mesa Redonda: Inteligência Artificial e Sociedade', 22),
('Moderador de Workshop: Avanços em Matemática Aplicada', 23),
('Moderador de Painel: Educação e Tecnologia', 24),
('Moderador de Debate: Biotecnologia no Combate a Doenças', 25),
('Moderador de Fórum: Física Quântica e suas Implicações', 26),
('Moderador de Sessão Técnica: Estudos em Ciências Sociais', 27),
('Moderador de Palestra: Computação Quântica e suas Fronteiras', 28),
('Moderador de Mesa Redonda: Literatura e História Contemporânea', 29),
('Moderador de Seminário: Desafios no Ensino de História', 30);

--Inscricao:
INSERT INTO Inscricao (Data, Horario, Participante_ID, Organizador_ID, Status_Inscricao_ID) VALUES
('2025-02-18', '09:00:00', 1, NULL, 2),
('2025-02-18', '09:30:00', 2, NULL, 1),
('2025-02-18', '10:00:00', 3, NULL, 3),
('2025-02-18', '10:30:00', 4, NULL, 4),
('2025-02-18', '11:00:00', 5, NULL, 5),
('2025-02-18', '11:30:00', 6, NULL, 2),
('2025-02-18', '12:00:00', 7, NULL, 3),
('2025-02-18', '12:30:00', 8, NULL, 1),
('2025-02-18', '13:00:00', 9, NULL, 4),
('2025-02-18', '13:30:00', 10, NULL, 5),
('2025-02-18', '14:00:00', 11, NULL, 2),
('2025-02-18', '14:30:00', 12, NULL, 1),
('2025-02-18', '15:00:00', 13, NULL, 3),
('2025-02-18', '15:30:00', 14, NULL, 4),
('2025-02-18', '16:00:00', 15, NULL, 5),
('2025-02-18', '16:30:00', 16, NULL, 2), 
('2025-02-18', '17:00:00', 17, NULL, 3), 
('2025-02-18', '17:30:00', 18, NULL, 1),
('2025-02-18', '18:00:00', 19, NULL, 4),
('2025-02-18', '18:30:00', 20, NULL, 5),
('2025-02-18', '19:00:00', 21, NULL, 2), 
('2025-02-18', '19:30:00', 22, NULL, 1),
('2025-02-18', '20:00:00', 23, NULL, 3),
('2025-02-18', '20:30:00', 24, NULL, 4),
('2025-02-18', '21:00:00', 25, NULL, 5),
('2025-02-18', '21:30:00', 26, NULL, 2),
('2025-02-18', '22:00:00', 27, NULL, 3),
('2025-02-18', '22:30:00', 28, NULL, 1),
('2025-02-18', '23:00:00', 29, NULL, 4),
('2025-02-18', '23:30:00', 30, NULL, 5),
('2025-02-18', '09:00:00', NULL, 1, 2),
('2025-02-18', '09:30:00', NULL, 2, 1),
('2025-02-18', '10:00:00', NULL, 3, 3), 
('2025-02-18', '10:30:00', NULL, 4, 4),
('2025-02-18', '11:00:00', NULL, 5, 5), 
('2025-02-18', '11:30:00', NULL, 6, 2),
('2025-02-18', '12:00:00', NULL, 7, 3),
('2025-02-18', '12:30:00', NULL, 8, 1),
('2025-02-18', '13:00:00', NULL, 9, 4),
('2025-02-18', '13:30:00', NULL, 10, 5);

--Status_Inscricao:
INSERT INTO Status_Inscricao (Nome, Descricao) VALUES
('Inscrito', 'O participante completou a inscrição no evento e está aguardando confirmação de pagamento ou aprovação.'),
('Confirmado', 'O participante teve sua inscrição confirmada e está oficialmente registrado no evento.'),
('Pendente', 'A inscrição do participante está pendente de aprovação ou confirmação adicional.'),
('Cancelado', 'A inscrição foi cancelada pelo participante ou pelos organizadores do evento.'),
('Aprovado', 'A inscrição foi aprovada e o participante pode participar do evento sem restrições.'),
('Aguardando Pagamento', 'A inscrição foi realizada, mas o pagamento ainda não foi efetuado.'),
('Pagamento Confirmado', 'O pagamento da inscrição foi confirmado e o participante está registrado no evento.'),
('Não Compareceu', 'O participante estava inscrito, mas não compareceu ao evento.'),
('Rejeitado', 'A inscrição foi rejeitada pelos organizadores do evento por algum motivo.'),
('Em Análise', 'A inscrição do participante está sendo analisada pelos organizadores antes de ser confirmada.');

--Local:
INSERT INTO Local (Nome, Endereco, Cidade, Estado, Capacidade, Descricao) VALUES
('Auditório Central', 'Av. Principal, 123', 'São Paulo', 'SP', 500, 'Auditório principal da universidade, equipado com projetores e sistema de som.'),
('Sala de Conferências A', 'Rua das Ciências, 45', 'Rio de Janeiro', 'RJ', 200, 'Sala para conferências e palestras acadêmicas.'),
('Laboratório de Tecnologia', 'Av. Inovação, 567', 'Belo Horizonte', 'MG', 100, 'Espaço dedicado a pesquisas em tecnologia e inovação.'),
('Biblioteca Acadêmica', 'Rua do Conhecimento, 789', 'Curitiba', 'PR', 300, 'Biblioteca com acervo especializado e espaço para estudos.'),
('Centro de Convenções Universitário', 'Av. Universitária, 101', 'Brasília', 'DF', 1000, 'Grande centro para congressos e eventos científicos.'),
('Anfiteatro de Engenharia', 'Rua da Engenharia, 222', 'Porto Alegre', 'RS', 400, 'Espaço voltado para eventos acadêmicos da área de engenharia.'),
('Auditório da Faculdade de Medicina', 'Av. Saúde, 333', 'Recife', 'PE', 600, 'Auditório equipado para conferências médicas e simpósios.'),
('Sala Multiuso', 'Rua Interdisciplinar, 444', 'Salvador', 'BA', 150, 'Sala flexível para workshops e reuniões acadêmicas.'),
('Laboratório de Biotecnologia', 'Av. Pesquisa, 555', 'Florianópolis', 'SC', 80, 'Laboratório especializado em pesquisas biotecnológicas.'),
('Pavilhão de Exposições Acadêmicas', 'Rua da Ciência, 666', 'Fortaleza', 'CE', 700, 'Espaço amplo para exposições de projetos e feiras científicas.');

--Apoiador:
INSERT INTO Apoiador (Nome, Descricao) VALUES
('Tech Innovators', 'Empresa especializada em inovações tecnológicas, apoiando eventos relacionados a ciência e tecnologia.'),
('EducaTech', 'Organização focada em promover a educação digital e o uso de tecnologias em ambientes escolares e acadêmicos.'),
('BioLife Labs', 'Laboratório de pesquisa biotecnológica, apoiando eventos voltados para a biotecnologia e saúde.'),
('GreenFuture', 'Organização ambiental que apoia eventos focados em sustentabilidade e inovação ecológica.'),
('Data Solutions', 'Consultoria especializada em big data e inteligência artificial, apoiando eventos de tecnologia e inovação.'),
('HealthTech Co.', 'Startup que desenvolve soluções tecnológicas para o setor de saúde, patrocinando eventos da área médica e científica.'),
('Cultura Digital', 'Plataforma de apoio à disseminação de conteúdos culturais digitais, patrocinando eventos sobre cultura e tecnologia.'),
('Sustainable Energy', 'Empresa que investe em soluções de energia sustentável e apoia eventos sobre energias renováveis e tecnologias limpas.'),
('Smart Cities', 'Iniciativa que apoia eventos voltados para o desenvolvimento de cidades inteligentes e soluções urbanas inovadoras.'),
('Future Scholars', 'Fundação que apoia eventos acadêmicos e educacionais, com foco no incentivo à pesquisa e desenvolvimento de jovens talentos.');

--Apoiador_Evento:
INSERT INTO Apoiador_Evento (Apoiador_ID, Evento_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--Patrocinador:
INSERT INTO Patrocinador (Nome, Tipo) VALUES
('TechGlobal Ventures', 'Tecnologia'),
('EducaMaster', 'Educação'),
('CleanEnergy Innovations', 'Sustentabilidade'),
('HealthCare Pro', 'Saúde'),
('NextGen Solutions', 'Tecnologia'),
('LearningPartners', 'Educação'),
('PlanetCare', 'Sustentabilidade'),
('WellnessCo', 'Saúde'),
('SmartTech Enterprises', 'Tecnologia'),
('VisionaryEdTech', 'Educação');

--Patrocinador_Evento:
INSERT INTO Patrocinado_Evento (Patrocinador_ID, Evento_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--Artigo:
INSERT INTO Artigo (Titulo, Descricao, Status_Submissao_ID) VALUES
('Avanços em Engenharia de Materiais para Sustentabilidade', 'Análise das inovações no campo da engenharia de materiais visando a sustentabilidade ambiental.', 1),
('Inteligência Artificial e o Futuro da Automação', 'Exploração das aplicações da IA em processos de automação e suas implicações econômicas e sociais.', 2),
('Matemática Aplicada no Estudo de Sistemas Complexos', 'Estudo de como a matemática pode ser aplicada para resolver problemas de sistemas complexos em várias áreas.', 3),
('Transformação Digital na Educação: O Impacto das Tecnologias', 'Análise sobre como as tecnologias digitais estão moldando o ensino e aprendizagem no século XXI.', 4),
('Biotecnologia e Suas Contribuições na Medicina Moderna', 'Discussão sobre os avanços em biotecnologia que têm revolucionado a medicina e os tratamentos de doenças.', 5),
('A Física Quântica e Seus Efeitos no Mundo Contemporâneo', 'Exploração das descobertas recentes na física quântica e suas implicações no nosso entendimento do universo.', 6),
('Ciências Sociais e o Impacto das Redes Sociais na Sociedade', 'Estudo sobre como as redes sociais estão moldando comportamentos e interações sociais no mundo moderno.', 7),
('Computação Quântica: O Futuro da Tecnologia Computacional', 'Exploração do papel da computação quântica na evolução das tecnologias computacionais e suas aplicações futuras.', 8),
('A Influência da Literatura Clássica no Pensamento Contemporâneo', 'Análise sobre como a literatura clássica moldou as ideias e ideologias do pensamento moderno.', 9),
('História das Grandes Civilizações: Lições para o Futuro', 'Estudo das principais civilizações da história e o impacto de seus legados nas sociedades atuais.', 10);

--Artigo_Evento:
INSERT INTO Artigo_Evento (Evento_ID, Artigo_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--Pesquisador:
INSERT INTO Pesquisador (Nome, Linha_Pesquisa, Instituicao_ID) VALUES
('Alexandre Souza', 'Engenharia de Sistemas e Automação Industrial', 1),
('Fernanda Costa', 'Inteligência Artificial e Aprendizado de Máquina', 2),
('Ricardo Oliveira', 'Teoria da Computação e Algoritmos Avançados', 3),
('Juliana Martins', 'Educação Digital e Desenvolvimento de Currículo', 4),
('Carlos Henrique', 'Biotecnologia e Engenharia Genética', 5),
('Ana Carolina', 'Física Quântica e Materiais Avançados', 6),
('José Ribeiro', 'Ciências Sociais e Dinâmicas de Grupos', 7),
('Mariana Silva', 'Computação Quântica e Algoritmos Quânticos', 8),
('Paulo Lima', 'Literatura Brasileira e Estudos Pós-Coloniais', 9),
('Roberta Almeida', 'História Contemporânea e Movimentos Sociais', 10);

--Pesquisador_Artigo:
INSERT INTO Pesquisador_Artigo (Artigo_ID, Pesquisador_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--Instituicao:
INSERT INTO Instituicao (Sigla, Nome, UF, Pais) VALUES
('USP', 'Universidade de São Paulo', 'SP', 'Brasil'),
('UFRJ', 'Universidade Federal do Rio de Janeiro', 'RJ', 'Brasil'),
('UNICAMP', 'Universidade Estadual de Campinas', 'SP', 'Brasil'),
('UFMG', 'Universidade Federal de Minas Gerais', 'MG', 'Brasil'),
('UNB', 'Universidade de Brasília', 'DF', 'Brasil'),
('UFBA', 'Universidade Federal da Bahia', 'BA', 'Brasil'),
('UNESP', 'Universidade Estadual Paulista', 'SP', 'Brasil'),
('UFPE', 'Universidade Federal de Pernambuco', 'PE', 'Brasil'),
('UFSC', 'Universidade Federal de Santa Catarina', 'SC', 'Brasil'),
('UFC', 'Universidade Federal do Ceará', 'CE', 'Brasil');

--Instituicao_Pesquisador:
INSERT INTO Instituicao_Pesquisador (Instituicao_ID, Pesquisador_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

--Organizador:
INSERT INTO Organizador (Nome, Funcao, Equipe_ID) VALUES
('Carlos Almeida', 'Coordenador de Logística', 1),
('Fernanda Silva', 'Gerente de Comunicação', 2),
('João Costa', 'Técnico de Suporte', 3),
('Patrícia Souza', 'Atendente de Inscrição', 5),
('Lucas Pereira', 'Supervisor de Cerimonial', 6),
('Ana Maria Oliveira', 'Coordenadora de Palestras', 7),
('Ricardo Lima', 'Gestor de Patrocínios', 8),
('Beatriz Rocha', 'Responsável de Segurança', 9),
('Juliana Martins', 'Coordenadora de Voluntários', 10),
('Eduardo Souza', 'Assistente Administrativo', 4);

--Organizador_Evento:
INSERT INTO Organizador_Evento (Evento_ID, Organizador_ID) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);

--Equipe:
INSERT INTO Equipe (Nome, Descricao) VALUES
('Equipe de Logística', 'Responsável pela organização do espaço do evento, controle de fluxo de participantes e distribuição de materiais.'),
('Equipe de Comunicação', 'Responsável pela divulgação do evento, gestão de redes sociais e comunicação com os participantes.'),
('Equipe de Apoio Técnico', 'Responsável pelo suporte técnico durante o evento, incluindo a instalação de equipamentos e resolução de problemas de tecnologia.'),
('Equipe de Atendimento ao Público', 'Responsável por atender os participantes, tirar dúvidas e fornecer informações sobre o evento.'),
('Equipe de Inscrição', 'Responsável pelo controle de inscrições, conferência de documentos e emissão de crachás para os participantes.'),
('Equipe de Cerimonial', 'Responsável pelo protocolo do evento, recepção dos palestrantes e participantes VIPs, e organização da cerimônia de abertura e encerramento.'),
('Equipe de Palestras', 'Responsável pela organização das palestras, incluindo a coordenação dos palestrantes, elaboração de cronograma e controle de horários.'),
('Equipe de Patrocínios', 'Responsável pela captação de patrocinadores, negociação de apoios financeiros e materiais para o evento.'),
('Equipe de Segurança', 'Responsável pela segurança geral do evento, controle de entradas e saídas e apoio durante situações de emergência.'),
('Equipe de Voluntários', 'Responsável pelo recrutamento, treinamento e organização dos voluntários para apoiar nas diversas áreas do evento.');

--Certificado
INSERT INTO Certificado (Data_Emissao, Participante_ID) VALUES
('2025-05-16', 1),
('2025-06-24', 2),
('2025-07-10', 3),
('2025-08-21', 4),
('2025-09-15', 5),
('2025-10-08', 6),
('2025-11-12', 7),
('2025-12-07', 8),
('2025-09-26', 9),
('2025-06-19', 10),
('2025-05-16', 11),
('2025-06-24', 12),
('2025-07-10', 13),
('2025-08-21', 14),
('2025-09-15', 15),
('2025-10-08', 16),
('2025-11-12', 17),
('2025-12-07', 18),
('2025-09-26', 19),
('2025-06-19', 20),
('2025-05-16', 21),
('2025-06-24', 22),
('2025-07-10', 23),
('2025-08-21', 24),
('2025-09-15', 25),
('2025-10-08', 26),
('2025-11-12', 27),
('2025-12-07', 28),
('2025-09-26', 29),
('2025-06-19', 30);

--Status_Submissao:
INSERT INTO Status_Submissao (Nome, Descricao) VALUES
('Submetido', 'O artigo foi enviado e está aguardando revisão.'),
('Em Revisão', 'O artigo está sendo analisado pelos revisores.'),
('Aceito', 'O artigo foi aprovado para apresentação e publicação.'),
('Rejeitado', 'O artigo foi rejeitado e não será aceito para o evento.'),
('Revisão Necessária', 'O artigo foi enviado para uma segunda revisão após ajustes solicitados.'),
('Aguardando Resposta do Autor', 'O artigo está aguardando uma resposta ou ajuste do autor.'),
('Aprovado Condicionalmente', 'O artigo foi aprovado, mas depende de ajustes antes da publicação final.'),
('Em Espera', 'O artigo está na fila aguardando revisão devido ao número elevado de submissões.'),
('Cancelado', 'A submissão do artigo foi cancelada por decisão do autor ou da organização do evento.'),
('Submissão Concluída', 'A submissão do artigo foi finalizada, mas ainda não passou pela revisão.');
