-- Nexo: script DDL MySQL 8 do modelo de persistência (29 tabelas)
-- Gerado a partir do Documento 04 - Modelagem de persistência. Testado em MySQL 8.0.

CREATE DATABASE IF NOT EXISTS nexo CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE nexo;

-- Perfil de Acesso: perfil predefinido que agrupa permissões.
CREATE TABLE perfil_acesso (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(20) NOT NULL,
  CONSTRAINT pk_perfil_acesso PRIMARY KEY (id),
  CONSTRAINT uq_perfil_acesso_nome UNIQUE (nome),
  CONSTRAINT ck_perfil_acesso_nome CHECK (nome IN ('administrador', 'atendente', 'psicologo', 'paciente'))
) ENGINE=InnoDB;

-- Usuário: identidade de acesso à plataforma.
CREATE TABLE usuario (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  situacao VARCHAR(25) NOT NULL DEFAULT 'pendente_de_ativacao',
  id_perfil_acesso INT NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (id),
  CONSTRAINT uq_usuario_email UNIQUE (email),
  CONSTRAINT ck_usuario_situacao CHECK (situacao IN ('pendente_de_ativacao', 'ativa', 'bloqueada', 'inativa')),
  CONSTRAINT fk_usuario_id_perfil_acesso FOREIGN KEY (id_perfil_acesso) REFERENCES perfil_acesso (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Permissão: autorização de uma operação sobre um recurso.
CREATE TABLE permissao (
  id INT NOT NULL AUTO_INCREMENT,
  recurso VARCHAR(80) NOT NULL,
  operacao VARCHAR(30) NOT NULL,
  configuravel BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT pk_permissao PRIMARY KEY (id),
  CONSTRAINT uq_permissao_recurso_operacao UNIQUE (recurso, operacao)
) ENGINE=InnoDB;

-- tabela associativa: tabela associativa entre perfis e permissões.
CREATE TABLE perfil_permissao (
  id_perfil_acesso INT NOT NULL,
  id_permissao INT NOT NULL,
  CONSTRAINT pk_perfil_permissao PRIMARY KEY (id_perfil_acesso, id_permissao),
  CONSTRAINT fk_perfil_permissao_id_perfil_acesso FOREIGN KEY (id_perfil_acesso) REFERENCES perfil_acesso (id) ON DELETE CASCADE,
  CONSTRAINT fk_perfil_permissao_id_permissao FOREIGN KEY (id_permissao) REFERENCES permissao (id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Paciente: pessoa atendida; pode existir sem conta de acesso (RN-033).
CREATE TABLE paciente (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  data_nascimento DATE NOT NULL,
  documento VARCHAR(20) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(150) NULL,
  id_usuario INT NULL,
  CONSTRAINT pk_paciente PRIMARY KEY (id),
  CONSTRAINT uq_paciente_documento UNIQUE (documento),
  CONSTRAINT uq_paciente_id_usuario UNIQUE (id_usuario),
  CONSTRAINT fk_paciente_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Psicólogo: profissional que realiza os atendimentos.
CREATE TABLE psicologo (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  registro_profissional VARCHAR(20) NOT NULL,
  apresentacao VARCHAR(1000) NOT NULL,
  aceita_novos_pacientes BOOLEAN NOT NULL DEFAULT TRUE,
  situacao VARCHAR(10) NOT NULL DEFAULT 'ativo',
  id_usuario INT NOT NULL,
  CONSTRAINT pk_psicologo PRIMARY KEY (id),
  CONSTRAINT uq_psicologo_registro_profissional UNIQUE (registro_profissional),
  CONSTRAINT uq_psicologo_id_usuario UNIQUE (id_usuario),
  CONSTRAINT ck_psicologo_situacao CHECK (situacao IN ('ativo', 'inativo')),
  CONSTRAINT fk_psicologo_id_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Área de Atuação: catálogo fixo de áreas da Psicologia (RN-023).
CREATE TABLE area_atuacao (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(80) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  CONSTRAINT pk_area_atuacao PRIMARY KEY (id),
  CONSTRAINT uq_area_atuacao_nome UNIQUE (nome)
) ENGINE=InnoDB;

-- tabela associativa: tabela associativa entre psicólogos e áreas de atuação.
CREATE TABLE psicologo_area_atuacao (
  id_psicologo INT NOT NULL,
  id_area_atuacao INT NOT NULL,
  CONSTRAINT pk_psicologo_area_atuacao PRIMARY KEY (id_psicologo, id_area_atuacao),
  CONSTRAINT fk_psicologo_area_atuacao_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE CASCADE,
  CONSTRAINT fk_psicologo_area_atuacao_id_area_atuacao FOREIGN KEY (id_area_atuacao) REFERENCES area_atuacao (id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Vínculo de Responsabilidade: papel de responsável de um usuário sobre um paciente; não é perfil de acesso (RN-034).
CREATE TABLE vinculo_responsabilidade (
  id INT NOT NULL AUTO_INCREMENT,
  situacao VARCHAR(25) NOT NULL DEFAULT 'pendente_de_confirmacao',
  data_inicio DATE NOT NULL,
  data_encerramento DATE NULL,
  id_usuario_responsavel INT NOT NULL,
  id_paciente_dependente INT NOT NULL,
  CONSTRAINT pk_vinculo_responsabilidade PRIMARY KEY (id),
  CONSTRAINT ck_vinculo_responsabilidade_situacao CHECK (situacao IN ('pendente_de_confirmacao', 'ativo', 'encerrado')),
  CONSTRAINT ck_vinculo_datas CHECK (data_encerramento IS NULL OR data_encerramento >= data_inicio),
  CONSTRAINT fk_vinculo_responsabilidade_id_usuario_responsavel FOREIGN KEY (id_usuario_responsavel) REFERENCES usuario (id) ON DELETE RESTRICT,
  CONSTRAINT fk_vinculo_responsabilidade_id_paciente_dependente FOREIGN KEY (id_paciente_dependente) REFERENCES paciente (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- tabela associativa: tabela associativa entre vínculos e permissões concedidas.
CREATE TABLE vinculo_permissao (
  id_vinculo_responsabilidade INT NOT NULL,
  id_permissao INT NOT NULL,
  CONSTRAINT pk_vinculo_permissao PRIMARY KEY (id_vinculo_responsabilidade, id_permissao),
  CONSTRAINT fk_vinculo_permissao_id_vinculo_responsabilidade FOREIGN KEY (id_vinculo_responsabilidade) REFERENCES vinculo_responsabilidade (id) ON DELETE CASCADE,
  CONSTRAINT fk_vinculo_permissao_id_permissao FOREIGN KEY (id_permissao) REFERENCES permissao (id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Disponibilidade: intervalo semanal em que o psicólogo atende (RN-017, RN-045).
CREATE TABLE disponibilidade (
  id INT NOT NULL AUTO_INCREMENT,
  dia_da_semana TINYINT NOT NULL,
  hora_inicial TIME NOT NULL,
  hora_final TIME NOT NULL,
  vigencia_inicial DATE NOT NULL,
  vigencia_final DATE NULL,
  id_psicologo INT NOT NULL,
  CONSTRAINT pk_disponibilidade PRIMARY KEY (id),
  CONSTRAINT ck_disponibilidade_dia_da_semana CHECK (dia_da_semana BETWEEN 1 AND 7),
  CONSTRAINT ck_disponibilidade_horas CHECK (hora_final > hora_inicial),
  CONSTRAINT ck_disponibilidade_vigencia CHECK (vigencia_final IS NULL OR vigencia_final >= vigencia_inicial),
  CONSTRAINT fk_disponibilidade_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Bloqueio de Agenda: período em que a agenda fica indisponível (RN-024).
CREATE TABLE bloqueio_agenda (
  id INT NOT NULL AUTO_INCREMENT,
  inicio DATETIME NOT NULL,
  fim DATETIME NOT NULL,
  motivo VARCHAR(255) NULL,
  id_psicologo INT NOT NULL,
  CONSTRAINT pk_bloqueio_agenda PRIMARY KEY (id),
  CONSTRAINT ck_bloqueio_periodo CHECK (fim > inicio),
  CONSTRAINT fk_bloqueio_agenda_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Recorrência: acordo de atendimentos periódicos; as ocorrências são geradas aos poucos (RN-049).
CREATE TABLE recorrencia (
  id INT NOT NULL AUTO_INCREMENT,
  periodicidade VARCHAR(10) NOT NULL,
  dia_da_semana TINYINT NOT NULL,
  horario_reservado TIME NOT NULL,
  vigencia_inicio DATE NOT NULL,
  vigencia_fim DATE NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'proposta',
  id_paciente INT NOT NULL,
  id_psicologo INT NOT NULL,
  CONSTRAINT pk_recorrencia PRIMARY KEY (id),
  CONSTRAINT ck_recorrencia_periodicidade CHECK (periodicidade IN ('semanal', 'quinzenal')),
  CONSTRAINT ck_recorrencia_dia_da_semana CHECK (dia_da_semana BETWEEN 1 AND 7),
  CONSTRAINT ck_recorrencia_situacao CHECK (situacao IN ('proposta', 'ativa', 'recusada', 'encerrada')),
  CONSTRAINT ck_recorrencia_vigencia CHECK (vigencia_fim IS NULL OR vigencia_fim >= vigencia_inicio),
  CONSTRAINT fk_recorrencia_id_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id) ON DELETE RESTRICT,
  CONSTRAINT fk_recorrencia_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Agendamento: consulta marcada entre paciente e psicólogo.
CREATE TABLE agendamento (
  id INT NOT NULL AUTO_INCREMENT,
  inicio DATETIME NOT NULL,
  fim DATETIME NOT NULL,
  situacao VARCHAR(20) NOT NULL DEFAULT 'agendada',
  confirmado_em DATETIME NULL,
  motivo_cancelamento VARCHAR(255) NULL,
  id_psicologo INT NOT NULL,
  id_paciente INT NOT NULL,
  id_recorrencia INT NULL,
  id_agendamento_novo INT NULL,
  CONSTRAINT pk_agendamento PRIMARY KEY (id),
  CONSTRAINT uq_agendamento_id_agendamento_novo UNIQUE (id_agendamento_novo),
  CONSTRAINT ck_agendamento_situacao CHECK (situacao IN ('agendada', 'confirmada', 'realizada', 'cancelada', 'nao_compareceu', 'reagendada')),
  CONSTRAINT ck_agendamento_periodo CHECK (fim > inicio),
  CONSTRAINT fk_agendamento_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE RESTRICT,
  CONSTRAINT fk_agendamento_id_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id) ON DELETE RESTRICT,
  CONSTRAINT fk_agendamento_id_recorrencia FOREIGN KEY (id_recorrencia) REFERENCES recorrencia (id) ON DELETE RESTRICT,
  CONSTRAINT fk_agendamento_id_agendamento_novo FOREIGN KEY (id_agendamento_novo) REFERENCES agendamento (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Atendimento: consulta realizada; pode existir sem agendamento (RN-080).
CREATE TABLE atendimento (
  id INT NOT NULL AUTO_INCREMENT,
  data_hora DATETIME NOT NULL,
  situacao VARCHAR(20) NOT NULL,
  id_paciente INT NOT NULL,
  id_psicologo INT NOT NULL,
  id_agendamento INT NULL,
  CONSTRAINT pk_atendimento PRIMARY KEY (id),
  CONSTRAINT uq_atendimento_id_agendamento UNIQUE (id_agendamento),
  CONSTRAINT ck_atendimento_situacao CHECK (situacao IN ('realizado', 'nao_compareceu')),
  CONSTRAINT fk_atendimento_id_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id) ON DELETE RESTRICT,
  CONSTRAINT fk_atendimento_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE RESTRICT,
  CONSTRAINT fk_atendimento_id_agendamento FOREIGN KEY (id_agendamento) REFERENCES agendamento (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Evolução Clínica: registro profissional do acompanhamento, restrito ao autor (RN-027).
CREATE TABLE evolucao_clinica (
  id INT NOT NULL AUTO_INCREMENT,
  data_registro DATETIME NOT NULL,
  alterada BOOLEAN NOT NULL DEFAULT FALSE,
  id_paciente INT NOT NULL,
  id_psicologo_autor INT NOT NULL,
  id_atendimento INT NULL,
  CONSTRAINT pk_evolucao_clinica PRIMARY KEY (id),
  CONSTRAINT fk_evolucao_clinica_id_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id) ON DELETE RESTRICT,
  CONSTRAINT fk_evolucao_clinica_id_psicologo_autor FOREIGN KEY (id_psicologo_autor) REFERENCES psicologo (id) ON DELETE RESTRICT,
  CONSTRAINT fk_evolucao_clinica_id_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Versão da Evolução: conteúdo da evolução em cada revisão; nunca é apagada (RN-028).
CREATE TABLE versao_evolucao (
  id INT NOT NULL AUTO_INCREMENT,
  numero INT NOT NULL,
  conteudo TEXT NOT NULL,
  data_hora DATETIME NOT NULL,
  id_evolucao_clinica INT NOT NULL,
  CONSTRAINT pk_versao_evolucao PRIMARY KEY (id),
  CONSTRAINT uq_versao_numero UNIQUE (id_evolucao_clinica, numero),
  CONSTRAINT ck_versao_evolucao_numero CHECK (numero >= 1),
  CONSTRAINT fk_versao_evolucao_id_evolucao_clinica FOREIGN KEY (id_evolucao_clinica) REFERENCES evolucao_clinica (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Cobrança, Cobrança Avulsa e Mensalidade: obrigação financeira; a hierarquia de Cobrança fica em tabela única (seção 4.3).
CREATE TABLE cobranca (
  id INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(12) NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  vencimento DATE NOT NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'pendente',
  data_consulta DATE NULL,
  competencia CHAR(7) NULL,
  id_paciente INT NOT NULL,
  id_agendamento INT NULL,
  id_atendimento INT NULL,
  id_recorrencia INT NULL,
  CONSTRAINT pk_cobranca PRIMARY KEY (id),
  CONSTRAINT uq_cobranca_id_agendamento UNIQUE (id_agendamento),
  CONSTRAINT uq_cobranca_id_atendimento UNIQUE (id_atendimento),
  CONSTRAINT uq_mensalidade_competencia UNIQUE (id_recorrencia, competencia),
  CONSTRAINT ck_cobranca_tipo CHECK (tipo IN ('avulsa', 'mensalidade')),
  CONSTRAINT ck_cobranca_valor CHECK (valor > 0),
  CONSTRAINT ck_cobranca_situacao CHECK (situacao IN ('pendente', 'paga', 'cancelada')),
  CONSTRAINT ck_cobranca_avulsa CHECK (tipo <> 'avulsa' OR (data_consulta IS NOT NULL AND competencia IS NULL AND id_recorrencia IS NULL AND ((id_agendamento IS NULL) <> (id_atendimento IS NULL)))),
  CONSTRAINT ck_cobranca_mensalidade CHECK (tipo <> 'mensalidade' OR (competencia IS NOT NULL AND id_recorrencia IS NOT NULL AND data_consulta IS NULL AND id_agendamento IS NULL AND id_atendimento IS NULL)),
  CONSTRAINT ck_cobranca_competencia CHECK (competencia IS NULL OR competencia REGEXP '^[0-9]{4}-(0[1-9]|1[0-2])$'),
  CONSTRAINT fk_cobranca_id_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id) ON DELETE RESTRICT,
  CONSTRAINT fk_cobranca_id_agendamento FOREIGN KEY (id_agendamento) REFERENCES agendamento (id) ON DELETE RESTRICT,
  CONSTRAINT fk_cobranca_id_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimento (id) ON DELETE RESTRICT,
  CONSTRAINT fk_cobranca_id_recorrencia FOREIGN KEY (id_recorrencia) REFERENCES recorrencia (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Tentativa de Pagamento: operação enviada ao Serviço Externo de Pagamentos, confirmada ou não.
CREATE TABLE tentativa_pagamento (
  id INT NOT NULL AUTO_INCREMENT,
  forma_pagamento VARCHAR(20) NOT NULL,
  referencia_externa VARCHAR(100) NOT NULL,
  data_hora DATETIME NOT NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'pendente',
  id_cobranca INT NOT NULL,
  CONSTRAINT pk_tentativa_pagamento PRIMARY KEY (id),
  CONSTRAINT uq_tentativa_pagamento_referencia_externa UNIQUE (referencia_externa),
  CONSTRAINT uq_tentativa_cobranca UNIQUE (id, id_cobranca),
  CONSTRAINT ck_tentativa_pagamento_forma_pagamento CHECK (forma_pagamento IN ('pix', 'cartao_de_credito')),
  CONSTRAINT ck_tentativa_pagamento_situacao CHECK (situacao IN ('pendente', 'confirmada', 'recusada', 'expirada')),
  CONSTRAINT fk_tentativa_pagamento_id_cobranca FOREIGN KEY (id_cobranca) REFERENCES cobranca (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Pagamento: confirmação que quita a cobrança (RN-075).
CREATE TABLE pagamento (
  id INT NOT NULL AUTO_INCREMENT,
  valor_confirmado DECIMAL(10,2) NOT NULL,
  forma_pagamento VARCHAR(20) NOT NULL,
  data_confirmacao DATETIME NOT NULL,
  referencia_transacao VARCHAR(100) NOT NULL,
  id_tentativa_pagamento INT NOT NULL,
  id_cobranca INT NOT NULL,
  CONSTRAINT pk_pagamento PRIMARY KEY (id),
  CONSTRAINT uq_pagamento_referencia_transacao UNIQUE (referencia_transacao),
  CONSTRAINT uq_pagamento_id_tentativa_pagamento UNIQUE (id_tentativa_pagamento),
  CONSTRAINT uq_pagamento_id_cobranca UNIQUE (id_cobranca),
  CONSTRAINT ck_pagamento_valor_confirmado CHECK (valor_confirmado > 0),
  CONSTRAINT ck_pagamento_forma_pagamento CHECK (forma_pagamento IN ('pix', 'cartao_de_credito')),
  CONSTRAINT fk_pagamento_id_cobranca FOREIGN KEY (id_cobranca) REFERENCES cobranca (id) ON DELETE RESTRICT,
  CONSTRAINT fk_pagamento_tentativa_cobranca FOREIGN KEY (id_tentativa_pagamento, id_cobranca) REFERENCES tentativa_pagamento (id, id_cobranca) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Lista de Espera: fila de interessados em vagas de um psicólogo (RN-061).
CREATE TABLE lista_espera (
  id INT NOT NULL AUTO_INCREMENT,
  id_psicologo INT NOT NULL,
  CONSTRAINT pk_lista_espera PRIMARY KEY (id),
  CONSTRAINT uq_lista_espera_id_psicologo UNIQUE (id_psicologo),
  CONSTRAINT fk_lista_espera_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Inscrição na Lista de Espera: participação de um paciente na lista.
CREATE TABLE inscricao_lista_espera (
  id INT NOT NULL AUTO_INCREMENT,
  preferencias VARCHAR(255) NOT NULL,
  data_inclusao DATETIME NOT NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'aguardando',
  id_lista_espera INT NOT NULL,
  id_paciente INT NOT NULL,
  paciente_aguardando INT GENERATED ALWAYS AS (CASE WHEN situacao = 'aguardando' THEN id_paciente END) VIRTUAL,
  CONSTRAINT pk_inscricao_lista_espera PRIMARY KEY (id),
  CONSTRAINT uq_inscricao_ativa UNIQUE (id_lista_espera, paciente_aguardando),
  CONSTRAINT ck_inscricao_lista_espera_situacao CHECK (situacao IN ('aguardando', 'encerrada')),
  CONSTRAINT fk_inscricao_lista_espera_id_lista_espera FOREIGN KEY (id_lista_espera) REFERENCES lista_espera (id) ON DELETE RESTRICT,
  CONSTRAINT fk_inscricao_lista_espera_id_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Oferta de Encaixe: vaga liberada oferecida a uma inscrição, com prazo de resposta (RN-065).
CREATE TABLE oferta_encaixe (
  id INT NOT NULL AUTO_INCREMENT,
  inicio DATETIME NOT NULL,
  fim DATETIME NOT NULL,
  prazo_resposta DATETIME NOT NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'pendente',
  id_inscricao INT NOT NULL,
  id_agendamento_gerado INT NULL,
  CONSTRAINT pk_oferta_encaixe PRIMARY KEY (id),
  CONSTRAINT uq_oferta_encaixe_id_agendamento_gerado UNIQUE (id_agendamento_gerado),
  CONSTRAINT ck_oferta_encaixe_situacao CHECK (situacao IN ('pendente', 'aceita', 'recusada', 'expirada')),
  CONSTRAINT ck_oferta_periodo CHECK (fim > inicio),
  CONSTRAINT ck_oferta_agendamento CHECK (id_agendamento_gerado IS NULL OR situacao = 'aceita'),
  CONSTRAINT fk_oferta_encaixe_id_inscricao FOREIGN KEY (id_inscricao) REFERENCES inscricao_lista_espera (id) ON DELETE RESTRICT,
  CONSTRAINT fk_oferta_encaixe_id_agendamento_gerado FOREIGN KEY (id_agendamento_gerado) REFERENCES agendamento (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Documento: documento emitido ou enviado; separado da evolução clínica (RN-029).
CREATE TABLE documento (
  id INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(50) NOT NULL,
  referencia_conteudo VARCHAR(255) NOT NULL,
  data_emissao DATETIME NOT NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'emitido',
  id_paciente INT NOT NULL,
  id_psicologo INT NULL,
  CONSTRAINT pk_documento PRIMARY KEY (id),
  CONSTRAINT ck_documento_situacao CHECK (situacao IN ('emitido', 'cancelado')),
  CONSTRAINT fk_documento_id_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id) ON DELETE RESTRICT,
  CONSTRAINT fk_documento_id_psicologo FOREIGN KEY (id_psicologo) REFERENCES psicologo (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Destinatário de Compartilhamento: pessoa ou profissional externo autorizado a receber documentos.
CREATE TABLE destinatario_compartilhamento (
  id INT NOT NULL AUTO_INCREMENT,
  identificacao VARCHAR(150) NOT NULL,
  dados_verificacao VARCHAR(255) NOT NULL,
  CONSTRAINT pk_destinatario_compartilhamento PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Compartilhamento de Documento: liberação autorizada de um documento a um destinatário (RN-070).
CREATE TABLE compartilhamento_documento (
  id INT NOT NULL AUTO_INCREMENT,
  finalidade VARCHAR(255) NOT NULL,
  fundamento_autorizacao VARCHAR(255) NOT NULL,
  validade DATETIME NOT NULL,
  situacao VARCHAR(10) NOT NULL DEFAULT 'ativo',
  id_documento INT NOT NULL,
  id_destinatario INT NOT NULL,
  CONSTRAINT pk_compartilhamento_documento PRIMARY KEY (id),
  CONSTRAINT ck_compartilhamento_documento_situacao CHECK (situacao IN ('ativo', 'expirado', 'revogado', 'encerrado')),
  CONSTRAINT fk_compartilhamento_documento_id_documento FOREIGN KEY (id_documento) REFERENCES documento (id) ON DELETE RESTRICT,
  CONSTRAINT fk_compartilhamento_documento_id_destinatario FOREIGN KEY (id_destinatario) REFERENCES destinatario_compartilhamento (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Registro de Acesso ao Documento: histórico de acessos e tentativas (RN-072).
CREATE TABLE registro_acesso_documento (
  id INT NOT NULL AUTO_INCREMENT,
  data_hora DATETIME NOT NULL,
  resultado VARCHAR(10) NOT NULL,
  identificacao_acesso VARCHAR(150) NULL,
  id_compartilhamento INT NOT NULL,
  CONSTRAINT pk_registro_acesso_documento PRIMARY KEY (id),
  CONSTRAINT ck_registro_acesso_documento_resultado CHECK (resultado IN ('permitido', 'negado')),
  CONSTRAINT fk_registro_acesso_documento_id_compartilhamento FOREIGN KEY (id_compartilhamento) REFERENCES compartilhamento_documento (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Notificação: aviso enviado pelo Serviço Externo de Notificação, sem conteúdo clínico (RN-074).
CREATE TABLE notificacao (
  id INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(50) NOT NULL,
  conteudo_permitido VARCHAR(500) NOT NULL,
  data_hora DATETIME NOT NULL,
  situacao_envio VARCHAR(10) NOT NULL DEFAULT 'pendente',
  id_usuario_destinatario INT NULL,
  id_destinatario_compartilhamento INT NULL,
  id_oferta_encaixe INT NULL,
  id_compartilhamento INT NULL,
  CONSTRAINT pk_notificacao PRIMARY KEY (id),
  CONSTRAINT ck_notificacao_situacao_envio CHECK (situacao_envio IN ('pendente', 'enviada', 'falhou')),
  CONSTRAINT ck_notificacao_destinatario CHECK ((id_usuario_destinatario IS NULL) <> (id_destinatario_compartilhamento IS NULL)),
  CONSTRAINT fk_notificacao_id_usuario_destinatario FOREIGN KEY (id_usuario_destinatario) REFERENCES usuario (id) ON DELETE RESTRICT,
  CONSTRAINT fk_notificacao_id_destinatario_compartilhamento FOREIGN KEY (id_destinatario_compartilhamento) REFERENCES destinatario_compartilhamento (id) ON DELETE RESTRICT,
  CONSTRAINT fk_notificacao_id_oferta_encaixe FOREIGN KEY (id_oferta_encaixe) REFERENCES oferta_encaixe (id) ON DELETE RESTRICT,
  CONSTRAINT fk_notificacao_id_compartilhamento FOREIGN KEY (id_compartilhamento) REFERENCES compartilhamento_documento (id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Registro de Auditoria: histórico somente leitura das operações relevantes (RN-015, RNF-004).
CREATE TABLE registro_auditoria (
  id INT NOT NULL AUTO_INCREMENT,
  acao VARCHAR(100) NOT NULL,
  data_hora DATETIME NOT NULL,
  recurso_afetado VARCHAR(150) NOT NULL,
  resultado VARCHAR(30) NOT NULL,
  id_usuario_autor INT NULL,
  CONSTRAINT pk_registro_auditoria PRIMARY KEY (id),
  CONSTRAINT fk_registro_auditoria_id_usuario_autor FOREIGN KEY (id_usuario_autor) REFERENCES usuario (id) ON DELETE RESTRICT
) ENGINE=InnoDB;
