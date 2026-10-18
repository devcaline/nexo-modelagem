# Nexo — Análise Orientada a Objetos

**Nexo** é uma plataforma de gestão de serviços psicológicos para profissionais de diferentes áreas da Psicologia (clínica, organizacional, escolar, hospitalar, jurídica e outras). Ela reúne cadastros, permissões, agenda, atendimentos, financeiro e documentos num só lugar, com controle de acesso, auditoria e respeito à LGPD e ao sigilo profissional.

Este repositório guarda o **Dossiê de Modelagem Orientada a Objetos** do sistema: requisitos, diagramas UML, persistência e rastreabilidade. O objetivo é que outra equipe consiga entender e implementar a plataforma só a partir destes artefatos.

> Trabalho da **Avaliação 3 (AV3)** da disciplina de **Análise Orientada a Objetos** — Ciência da Computação, UNIJORGE.

## Estrutura

```text
nexo-modelagem-av3/
├── docs/                                    # cada documento em PDF (leitura) e .docx (editável)
│   ├── 01-visao-requisitos-e-regras         # visão, escopo, atores, RF, RNF, RN, histórias e critérios de aceite
│   ├── 02-especificacao-casos-de-uso        # UC-001 a UC-056, com diagramas, fluxos e regras
│   └── 03-modelagem-de-dominio-e-orientacao-a-objetos   # conceitos, responsabilidades, classes, objetos, OO e SOLID
└── diagramas/
    ├── contexto/                            # fronteira do sistema e atores externos
    │   └── diagrama-de-contexto.drawio      # arquivo editável
    ├── casos-de-uso/                        # um diagrama por módulo (01 a 11)
    │   └── diagramas-casos-de-uso.drawio    # arquivo editável com os 11 diagramas
    ├── classes/                             # um diagrama de classes por área (01 a 09)
    │   └── diagramas-classes.drawio         # arquivo editável com os 9 diagramas
    └── objetos/                             # instâncias de um cenário (UC-027)
        └── diagrama-objetos.drawio          # arquivo editável
```

Os diagramas ficam exportados em `.png` para leitura rápida. Cada pasta tem um arquivo `.drawio` editável com todos os diagramas daquele tipo, um por página, na mesma ordem das tabelas abaixo.

## Documentos

| Documento | Conteúdo | Editável |
|-----------|----------|:--------:|
| [Visão, requisitos e regras](docs/01-visao-requisitos-e-regras.pdf) | Documento de visão, situação-problema, objetivos, escopo e fronteiras, premissas, stakeholders e atores, glossário, inovação proposta, **76 requisitos funcionais (RF)**, **17 não funcionais (RNF)**, **80 regras de negócio (RN)**, histórias de usuário e critérios de aceite | [.docx](docs/01-visao-requisitos-e-regras.docx) |
| [Especificação dos casos de uso](docs/02-especificacao-casos-de-uso.pdf) | Padrões de identificação, diagramas por módulo e especificação textual de **56 casos de uso** (UC-001 a UC-056) | [.docx](docs/02-especificacao-casos-de-uso.docx) |
| [Modelagem de domínio e orientação a objetos](docs/03-modelagem-de-dominio-e-orientacao-a-objetos.pdf) | **28 conceitos do domínio** com origem nos casos de uso, quadro de responsabilidades e colaborações das classes, explicação dos diagramas de classes e de objetos, aplicação dos princípios de OO (abstração, encapsulamento, coesão, acoplamento, herança, polimorfismo e composição) e dos princípios **SOLID** | [.docx](docs/03-modelagem-de-dominio-e-orientacao-a-objetos.docx) |

## Módulos

Os 56 casos de uso estão divididos em 11 módulos. Cada um tem um diagrama próprio. Os casos de uso automáticos UC-050, UC-051, UC-053 e UC-054 são executados pelo ator **Agendador**, um processo da plataforma que roda em horários definidos. O UC-052 (Registrar resultado do pagamento) é iniciado pelo **Serviço Externo de Pagamentos**.

| # | Módulo | Imagem | Arquivo editável |
|:-:|--------|:------:|:----------------:|
| 01 | Acesso e Autenticação | [ver](diagramas/casos-de-uso/01-acesso-e-autenticacao.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=TTQjXH0QLTnTZkFuTSbk#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 02 | Administração e Permissões | [ver](diagramas/casos-de-uso/02-administracao-e-permissoes.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=jioY7CT-6xVF0ysiqzDF#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 03 | Pacientes e Responsáveis | [ver](diagramas/casos-de-uso/03-pacientes-e-responsaveis.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=INRhjBrrQ6mlNPOlhrBA#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 04 | Psicólogos e Disponibilidade | [ver](diagramas/casos-de-uso/04-psicologos-e-disponibilidade.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=Ee0_wjZGZucqGsAhjyQ-#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 05 | Agenda e Agendamentos | [ver](diagramas/casos-de-uso/05-agenda-e-agendamentos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=ErttRgM506p2Fu00RCfi#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 06 | Atendimento e Evolução Clínica | [ver](diagramas/casos-de-uso/06-atendimento-e-evolucao-clinica.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=AC23WXYMVOHcswpK5mRS#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 07 | Recorrência de Atendimentos | [ver](diagramas/casos-de-uso/07-recorrencia-de-atendimentos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=j8ZUGrdPdTnJEIPtGFZn#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 08 | Financeiro e Pagamentos | [ver](diagramas/casos-de-uso/08-financeiro-e-pagamentos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=7p_f6k52_ZvSWfSv3xck#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 09 | Lista de Espera e Encaixes | [ver](diagramas/casos-de-uso/09-lista-de-espera-e-encaixes.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=WWKL9XNSHv-sA6mnodhM#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 10 | Compartilhamento de Documentos | [ver](diagramas/casos-de-uso/10-compartilhamento-de-documentos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=msohQ2KOXuRciw_aY0eF#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |
| 11 | Notificações | [ver](diagramas/casos-de-uso/11-notificacoes.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio&page-id=uc-notificacoes#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>) |

## Diagramas de classes

O modelo de domínio está dividido em 9 áreas. Em cada diagrama, os atributos são privados (`-`) e as operações públicas (`+`). As classes em cinza estão detalhadas em outra área, e cada diagrama traz as suas enumerações («enumeration») de situação e tipo. O modelo usa herança (Cobrança abstrata, com Cobrança Avulsa e Mensalidade) e composição (Tentativa de Pagamento, Inscrição na Lista de Espera, Registro de Acesso e Versão da Evolução).

| # | Área | Classes principais | Imagem | Arquivo editável |
|:-:|------|--------------------|:------:|:----------------:|
| 01 | Acesso e Permissões | Usuário, Perfil de Acesso, Permissão | [ver](diagramas/classes/01-acesso-e-permissoes.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-1#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 02 | Pessoas e Vínculos | Paciente, Psicólogo, Vínculo de Responsabilidade, Área de Atuação | [ver](diagramas/classes/02-pessoas-e-vinculos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-2#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 03 | Agenda e Agendamentos | Disponibilidade, Bloqueio de Agenda, Agendamento | [ver](diagramas/classes/03-agenda-e-agendamentos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-3#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 04 | Atendimento e Evolução Clínica | Atendimento, Evolução Clínica, Versão da Evolução | [ver](diagramas/classes/04-atendimento-e-evolucao-clinica.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-4#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 05 | Recorrência | Recorrência | [ver](diagramas/classes/05-recorrencia.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-5#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 06 | Cobranças e Pagamentos | Cobrança *(abstrata)*, Cobrança Avulsa, Mensalidade, Tentativa de Pagamento, Pagamento | [ver](diagramas/classes/06-cobrancas-e-pagamentos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-6#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 07 | Lista de Espera e Encaixes | Lista de Espera, Inscrição na Lista de Espera, Oferta de Encaixe | [ver](diagramas/classes/07-lista-de-espera-e-encaixes.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-7#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 08 | Documentos e Compartilhamentos | Documento, Compartilhamento, Destinatário, Registro de Acesso | [ver](diagramas/classes/08-documentos-e-compartilhamentos.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-8#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |
| 09 | Comunicação e Auditoria | Notificação, Registro de Auditoria | [ver](diagramas/classes/09-comunicacao-e-auditoria.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio&page-id=area-9#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>) |

## Diagrama de objetos

Mostra as instâncias e os vínculos no instante em que uma consulta é agendada, no cenário do **UC-027 — Agendar consulta**: a paciente Mariana marca uma consulta com a psicóloga Ana, dentro de um horário de disponibilidade cadastrado por ela.

| Cenário | Objetos | Imagem | Arquivo editável |
|---------|---------|:------:|:----------------:|
| UC-027 — Agendar consulta | `ana:Psicólogo`, `mariana:Paciente`, `consulta001:Agendamento`, `disponibilidade001:Disponibilidade` | [ver](diagramas/objetos/uc027-agendar-consulta.png) | [abrir](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagrama-objetos.drawio#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fobjetos%2Fdiagrama-objetos.drawio>) |

## Arquivos editáveis dos diagramas

Os arquivos-fonte dos diagramas podem ser abertos no navegador, sem instalar nada e sem precisar de conta:

**[🔗 Abrir o diagrama de contexto no draw.io (somente visualização)](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagrama-de-contexto.drawio#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcontexto%2Fdiagrama-de-contexto.drawio>)** · [ver imagem](diagramas/contexto/diagrama-de-contexto.png)

**[🔗 Abrir os 11 diagramas de casos de uso no draw.io (somente visualização)](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-casos-de-uso.drawio#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fcasos-de-uso%2Fdiagramas-casos-de-uso.drawio>)**

**[🔗 Abrir os 9 diagramas de classes no draw.io (somente visualização)](<https://viewer.diagrams.net/?lightbox=1&highlight=0000ff&layers=1&nav=1&title=diagramas-classes.drawio#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fdevcaline%2Fnexo-modelagem-av3%2Fmain%2Fdiagramas%2Fclasses%2Fdiagramas-classes.drawio>)**

As páginas ficam na barra inferior e seguem a ordem das tabelas acima. Os arquivos também podem ser baixados:

- [`diagramas/contexto/diagrama-de-contexto.drawio`](diagramas/contexto/diagrama-de-contexto.drawio)
- [`diagramas/casos-de-uso/diagramas-casos-de-uso.drawio`](diagramas/casos-de-uso/diagramas-casos-de-uso.drawio)
- [`diagramas/classes/diagramas-classes.drawio`](diagramas/classes/diagramas-classes.drawio)
- [`diagramas/objetos/diagrama-objetos.drawio`](diagramas/objetos/diagrama-objetos.drawio)

## Andamento dos artefatos

| Artefato | Situação |
|----------|:--------:|
| Diagrama de contexto | ✅ |
| Diagramas de casos de uso | ✅ |
| Especificação dos casos de uso | ✅ |
| Documento de visão, glossário e mapa de stakeholders | ✅ |
| Requisitos funcionais, não funcionais e regras de negócio | ✅ |
| Histórias de usuário e critérios de aceite | ✅ |
| Conceitos do domínio e responsabilidades das classes | ✅ |
| Diagrama de classes de domínio | ✅ |
| Diagrama de objetos | ✅ |
| Princípios de OO e SOLID | ✅ |
| Diagramas de sequência (3 casos críticos) | ⏳ |
| Diagrama de comunicação | ⏳ |
| Diagrama de atividades | ⏳ |
| Máquina de estados | ⏳ |
| Diagramas de pacotes, componentes e implantação | ⏳ |
| Modelo de persistência (DER) e dicionário de dados | ⏳ |
| Matriz de rastreabilidade | ⏳ |
| Plano de qualidade (ISO/IEC 25010) | ⏳ |

## Padrões do repositório

- Nomes de arquivos em minúsculas, sem acento e com hífen.
- Diagramas numerados na mesma ordem dos módulos do documento.
- Casos de uso identificados como `UC-001`; requisitos como `RF-001`, `RNF-001`; regras como `RN-001`. O mesmo código aparece no documento, nos diagramas e na matriz de rastreabilidade.
- Cada alteração relevante vira um commit com mensagem descritiva, para manter o histórico de versões.

## Ferramentas

- [draw.io](https://www.drawio.com/) — diagramas UML
- Microsoft Word — documentação
