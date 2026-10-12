# 🧠 Nexo — Modelagem Orientada a Objetos

**Nexo** é uma plataforma de gestão de serviços psicológicos para profissionais de diferentes áreas da Psicologia (clínica, organizacional, escolar, hospitalar, jurídica e outras). Ela reúne cadastros, permissões, agenda, atendimentos, financeiro e documentos num só lugar, com controle de acesso, auditoria e respeito à LGPD e ao sigilo profissional.

Este repositório guarda o **Dossiê de Modelagem Orientada a Objetos** do sistema: requisitos, diagramas UML, persistência e rastreabilidade. O objetivo é que outra equipe consiga entender e implementar a plataforma só a partir destes artefatos.

> Trabalho da **Avaliação 3 (AV3)** da disciplina de **Modelagem Orientada a Objetos** — Ciência da Computação, UNIJORGE.

## 📂 Estrutura

```text
nexo-modelagem-av3/
├── docs/
│   └── especificacao-casos-de-uso.docx   # UC-001 a UC-049, com fluxos e regras
└── diagramas/
    ├── contexto/                          # fronteira do sistema e atores externos
    └── casos-de-uso/                      # um diagrama por módulo (01 a 10)
```

Cada diagrama fica com a imagem exportada (`.png`) e o arquivo editável (`.drawio`) lado a lado, com o mesmo nome.

## 🧩 Módulos

Os 49 casos de uso estão divididos em 10 módulos. Cada um tem um diagrama próprio:

| # | Módulo | Diagrama |
|:-:|--------|----------|
| 01 | Acesso e Autenticação | [ver](diagramas/casos-de-uso/01-acesso-e-autenticacao.png) |
| 02 | Administração e Permissões | [ver](diagramas/casos-de-uso/02-administracao-e-permissoes.png) |
| 03 | Pacientes e Responsáveis | [ver](diagramas/casos-de-uso/03-pacientes-e-responsaveis.png) |
| 04 | Psicólogos e Disponibilidade | [ver](diagramas/casos-de-uso/04-psicologos-e-disponibilidade.png) |
| 05 | Agenda e Agendamentos | [ver](diagramas/casos-de-uso/05-agenda-e-agendamentos.png) |
| 06 | Atendimento e Evolução Clínica | [ver](diagramas/casos-de-uso/06-atendimento-e-evolucao-clinica.png) |
| 07 | Recorrência de Atendimentos | [ver](diagramas/casos-de-uso/07-recorrencia-de-atendimentos.png) |
| 08 | Financeiro e Pagamentos | [ver](diagramas/casos-de-uso/08-financeiro-e-pagamentos.png) |
| 09 | Lista de Espera e Encaixes | [ver](diagramas/casos-de-uso/09-lista-de-espera-e-encaixes.png) |
| 10 | Compartilhamento de Documentos | [ver](diagramas/casos-de-uso/10-compartilhamento-de-documentos.png) |

## ✅ Andamento dos artefatos

| Artefato | Situação |
|----------|:--------:|
| Diagrama de contexto | ✅ |
| Diagramas de casos de uso | ✅ |
| Especificação dos casos de uso | ✅ |
| Documento de visão, glossário e mapa de stakeholders | ⏳ |
| Requisitos funcionais, não funcionais e regras de negócio | ⏳ |
| Diagrama de classes de domínio | ⏳ |
| Diagrama de objetos | ⏳ |
| Diagramas de sequência (3 casos críticos) | ⏳ |
| Diagrama de comunicação | ⏳ |
| Diagrama de atividades | ⏳ |
| Máquina de estados | ⏳ |
| Diagramas de pacotes, componentes e implantação | ⏳ |
| Modelo de persistência (DER) e dicionário de dados | ⏳ |
| Matriz de rastreabilidade | ⏳ |
| Plano de qualidade (ISO/IEC 25010) | ⏳ |

## 🗂️ Padrões do repositório

- Nomes de arquivos em minúsculas, sem acento e com hífen.
- Diagramas numerados na mesma ordem dos módulos do documento.
- Casos de uso identificados como `UC-001`; requisitos como `RF-001`, `RNF-001`; regras como `RN-001`. O mesmo código aparece no documento, nos diagramas e na matriz de rastreabilidade.
- Cada alteração relevante vira um commit com mensagem descritiva, para manter o histórico de versões.

## 🛠️ Ferramentas

- [draw.io](https://www.drawio.com/) — diagramas UML
- Microsoft Word — documentação
