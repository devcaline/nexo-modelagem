-- Nexo: teste das restrições do modelo de persistência (MySQL 8)
-- Execute depois de nexo-ddl-mysql.sql, com:  mysql --force < teste-restricoes.sql
-- A parte 1 deve rodar sem erros. Cada comando da parte 2 DEVE FALHAR: o erro mostra que o banco aplica a regra.

USE nexo;

-- Parte 1: dados válidos -----------------------------------------------------------------
INSERT INTO perfil_acesso (nome) VALUES ('administrador'), ('atendente'), ('psicologo'), ('paciente');
INSERT INTO usuario (nome, email, senha_hash, situacao, id_perfil_acesso) VALUES
  ('Ana Souza', 'ana@nexo.com', '$2b$12$hash', 'ativa', 3),
  ('Mariana Lima', 'mariana@email.com', '$2b$12$hash', 'ativa', 4);
INSERT INTO psicologo (nome, registro_profissional, apresentacao, id_usuario) VALUES ('Ana Souza', '03/12345', 'Psicologia clínica', 1);
INSERT INTO paciente (nome, data_nascimento, documento, telefone, id_usuario) VALUES ('Mariana Lima', '1990-05-01', '11122233344', '71999990000', 2);
INSERT INTO agendamento (inicio, fim, id_psicologo, id_paciente) VALUES ('2026-11-03 10:00', '2026-11-03 10:50', 1, 1);
INSERT INTO atendimento (data_hora, situacao, id_paciente, id_psicologo) VALUES ('2026-11-04 15:00', 'realizado', 1, 1);  -- sem agendamento (RN-080)
INSERT INTO recorrencia (periodicidade, dia_da_semana, horario_reservado, vigencia_inicio, id_paciente, id_psicologo)
  VALUES ('semanal', 3, '10:00', '2026-11-01', 1, 1);
INSERT INTO cobranca (tipo, valor, vencimento, data_consulta, id_paciente, id_agendamento) VALUES ('avulsa', 150.00, '2026-11-03', '2026-11-03', 1, 1);
INSERT INTO cobranca (tipo, valor, vencimento, data_consulta, id_paciente, id_atendimento) VALUES ('avulsa', 150.00, '2026-11-04', '2026-11-04', 1, 1);
INSERT INTO cobranca (tipo, valor, vencimento, competencia, id_paciente, id_recorrencia) VALUES ('mensalidade', 500.00, '2026-11-10', '2026-11', 1, 1);
INSERT INTO tentativa_pagamento (forma_pagamento, referencia_externa, data_hora, id_cobranca) VALUES
  ('pix', 'ext-001', '2026-11-03 11:00', 1), ('pix', 'ext-002', '2026-11-04 16:00', 2);
UPDATE tentativa_pagamento SET situacao = 'confirmada' WHERE id = 1;
INSERT INTO pagamento (valor_confirmado, forma_pagamento, data_confirmacao, referencia_transacao, id_tentativa_pagamento, id_cobranca)
  VALUES (150.00, 'pix', '2026-11-03 11:01', 'tx-001', 1, 1);
UPDATE cobranca SET situacao = 'paga' WHERE id = 1;
INSERT INTO lista_espera (id_psicologo) VALUES (1);
INSERT INTO inscricao_lista_espera (preferencias, data_inclusao, id_lista_espera, id_paciente) VALUES ('manhãs', '2026-11-01 09:00', 1, 1);
UPDATE inscricao_lista_espera SET situacao = 'encerrada' WHERE id = 1;
INSERT INTO inscricao_lista_espera (preferencias, data_inclusao, id_lista_espera, id_paciente) VALUES ('tardes', '2026-11-05 09:00', 1, 1);
INSERT INTO evolucao_clinica (data_registro, id_paciente, id_psicologo_autor, id_atendimento) VALUES ('2026-11-04 16:00', 1, 1, 1);
INSERT INTO versao_evolucao (numero, conteudo, data_hora, id_evolucao_clinica) VALUES
  (1, 'Registro inicial.', '2026-11-04 16:00', 1), (2, 'Revisão.', '2026-11-05 08:00', 1);
INSERT INTO notificacao (tipo, conteudo_permitido, data_hora, id_usuario_destinatario) VALUES ('agendamento', 'Consulta marcada para 03/11 às 10h.', '2026-11-01 10:00', 2);
SELECT 'Parte 1 concluída: dados válidos aceitos' AS resultado;

-- Parte 2: cada comando DEVE FALHAR ----------------------------------------------------------
-- cobrança avulsa ligada a agendamento e a atendimento ao mesmo tempo ({xor}, RN-054)
INSERT INTO cobranca (tipo, valor, vencimento, data_consulta, id_paciente, id_agendamento, id_atendimento) VALUES ('avulsa', 100, '2026-11-01', '2026-11-01', 1, 1, 1);
-- cobrança avulsa sem consulta de origem
INSERT INTO cobranca (tipo, valor, vencimento, data_consulta, id_paciente) VALUES ('avulsa', 100, '2026-11-01', '2026-11-01', 1);
-- segunda mensalidade da mesma recorrência no mesmo mês
INSERT INTO cobranca (tipo, valor, vencimento, competencia, id_paciente, id_recorrencia) VALUES ('mensalidade', 500, '2026-11-10', '2026-11', 1, 1);
-- competência em formato inválido
INSERT INTO cobranca (tipo, valor, vencimento, competencia, id_paciente, id_recorrencia) VALUES ('mensalidade', 500, '2026-12-10', '2026-13', 1, 1);
-- valor zero
INSERT INTO cobranca (tipo, valor, vencimento, competencia, id_paciente, id_recorrencia) VALUES ('mensalidade', 0, '2026-12-10', '2026-12', 1, 1);
-- pagamento apontando para cobrança diferente da tentativa
INSERT INTO pagamento (valor_confirmado, forma_pagamento, data_confirmacao, referencia_transacao, id_tentativa_pagamento, id_cobranca) VALUES (150, 'pix', NOW(), 'tx-002', 2, 3);
-- segundo pagamento da mesma cobrança
INSERT INTO pagamento (valor_confirmado, forma_pagamento, data_confirmacao, referencia_transacao, id_tentativa_pagamento, id_cobranca) VALUES (150, 'pix', NOW(), 'tx-003', 1, 1);
-- segunda inscrição aguardando do mesmo paciente na mesma lista (RN-062)
INSERT INTO inscricao_lista_espera (preferencias, data_inclusao, id_lista_espera, id_paciente) VALUES ('qualquer', NOW(), 1, 1);
-- segunda lista de espera do mesmo psicólogo
INSERT INTO lista_espera (id_psicologo) VALUES (1);
-- notificação sem destinatário ({xor})
INSERT INTO notificacao (tipo, conteudo_permitido, data_hora) VALUES ('aviso', 'texto', NOW());
-- situação fora do domínio
INSERT INTO usuario (nome, email, senha_hash, situacao, id_perfil_acesso) VALUES ('X', 'x@nexo.com', 'h', 'ativo', 4);
-- número de versão repetido na mesma evolução (RN-028)
INSERT INTO versao_evolucao (numero, conteudo, data_hora, id_evolucao_clinica) VALUES (2, 'outra', NOW(), 1);
-- oferta pendente com agendamento gerado (RN-067)
INSERT INTO oferta_encaixe (inicio, fim, prazo_resposta, id_inscricao, id_agendamento_gerado) VALUES ('2026-11-05 10:00', '2026-11-05 10:50', '2026-11-04 10:00', 2, 1);
-- exclusão física de paciente com histórico (RESTRICT)
DELETE FROM paciente WHERE id = 1;
-- e-mail repetido
INSERT INTO usuario (nome, email, senha_hash, id_perfil_acesso) VALUES ('Outra Ana', 'ana@nexo.com', 'h', 3);
SELECT 'Parte 2 concluída: confira que cada comando acima retornou erro' AS resultado;
