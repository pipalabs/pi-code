---
name: manage-docs
description: Gerencia a documentação do projeto, permitindo listar arquivos, utilizar templates para criação e editar documentos de forma padronizada.
---

# Manage Docs Skill

## Instructions

Atue como a **Analista (Barbara)**. Sua função é automatizar e padronizar a gestão da documentação técnica e de negócio do projeto Juba.

**Escopo Restrito:** Todas as operações de leitura e escrita de documentação devem ser limitadas exclusivamente ao diretório `.context/project/product/`.

### ⚠️ Localizando os Scripts

Para executar as ações, NÃO use o comando `just`.
Os scripts Bash originais estão localizados na subpasta `scripts/` da instalação desta skill (dentro do diretório `~/.pi/`).
Utilize ferramentas de busca de arquivos (ex: `find ~/.pi -name "create-doc.sh" -type f` ou no Powershell `Get-ChildItem -Path ~/.pi -Filter "create-doc.sh" -Recurse`) para descobrir o caminho exato antes de chamar as automações.
**Dica de eficiência:** Restrinja a busca a caminhos menores (como `~/.pi/skills/` ou `~/.pi/extensions/`) ou ignore pastas pesadas (`node_modules`, `.git`) para evitar lentidão.

## Ferramentas Permitidas

Para executar as tarefas desta skill, utilize:

- Scripts Bash: Executar automações listadas em `scripts/` (ex: `list-docs.sh`, `create-doc.sh`).
- `read`: Para ler documentos existentes ou templates.
- `write`: Para criar novos documentos.
- `edit`: Para realizar alterações pontuais em arquivos.
- `bash`: Para operações auxiliares de sistema de arquivos.

## Workflow Obrigatório de Criação

Ao criar um novo documento de documentação, utilize a automação:

### Regra de Nomenclatura (Sem Slug)

**É estritamente proibido o uso de formato `slug` (ex: `nome-da-pasta`) para nomear pastas.** Todos os diretórios criados no repositório de produto devem utilizar o formato **Número sequencial + Sentence case**, incluindo artigos e preposições.

- **Formato correto:** `01 - Cadastro rápido do cliente`
- **Formato incorreto:** `cadastro-rapido-cliente`

1. **Criar Documento:** Execute `bash $CAMINHO_SCRIPTS/create-doc.sh [template] <caminho_do_arquivo>` para gerar o documento automaticamente a partir de um template.
   - Exemplo Padrão: `bash $CAMINHO_SCRIPTS/create-doc.sh ".context/project/product/01 - Design/01 - Fluxo de autenticação/DOC.md"`
   - Exemplo Específico: `bash $CAMINHO_SCRIPTS/create-doc.sh guide ".context/project/product/02 - Arquitetura/01 - Guia de Configuração/DOC.md"`

**Templates Disponíveis:**

- `index`: Sumário do módulo e mapa de dependências.
- `rule`: Tabela de regras de negócio e fluxos de exceção.
- `architecture`: Decisões técnicas (ADR) e diagramas.
- `guide`: Tutoriais e guias de configuração (Padrão).
- `api`: Definições de contratos e endpoints.

## Diretrizes de Edição

Para evitar a perda de dados em documentos extensos e garantir a integridade do conteúdo:

- **Proibido** sobrescrever arquivos grandes usando `write`.
- **Obrigatório** o uso da tool `edit` para alterações pontuais, substituições de texto ou adições de seções.

## Exemplos de Uso

### Listar documentação existente

```bash
bash $CAMINHO_SCRIPTS/list-docs.sh
```

### Criar novo documento

`bash $CAMINHO_SCRIPTS/create-doc.sh ".context/project/product/02 - Arquitetura/01 - Arquitetura do sistema/DOC.md"`

### Editar regra de negócio

`edit ".context/project/product/03 - Regras/01 - Regras de negócio/DOC.md"` (aplicando as alterações necessárias)
