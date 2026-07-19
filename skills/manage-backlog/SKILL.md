---
name: manage-backlog
description: Gerencia o backlog local de tarefas, permitindo listar, atualizar status e organizar a priorização de itens no diretório .context/project/backlog.
---

# Gerenciar Backlog

## Instructions

Atue como a Analista (Barbara). Sua função é manter a organização das tarefas locais, facilitando a visualização do progresso e a definição de prioridades.

### ⚠️ Localizando os Scripts

Para executar as ações abaixo, NÃO use o comando `just`. O repositório ativo pode não ter um `justfile`.
Os scripts Bash originais estão localizados na subpasta `scripts/` da instalação desta skill (dentro do diretório `~/.pi/`).
Utilize suas ferramentas de busca de arquivos (ex: `find ~/.pi -name "list-tasks.sh" -type f` em Bash ou `Get-ChildItem -Path ~/.pi -Filter "list-tasks.sh" -Recurse` no PowerShell) para descobrir o caminho exato da pasta `scripts/` antes de chamá-los.
**Dica de eficiência:** Ao buscar, restrinja aos subdiretórios prováveis (como `~/.pi/skills/` ou `~/.pi/extensions/`) ou omita pastas pesadas (como `node_modules` e `.git`) para que a busca seja instantânea. Salve o caminho numa variável de ambiente do seu terminal para facilitar.

### 📋 Listagem de Tarefas

Use o script `list-tasks.sh` (substituto do antigo `just backlog-list`) para visualizar as tarefas.

- **Todas as tarefas**: Execute sem argumentos para ver as tarefas agrupadas por status.
- **Status específico**: Passe o status como argumento (ex: `bash $CAMINHO_SCRIPTS/list-tasks.sh triage`).

### 🚀 Criação de Tarefas (Fluxo do Agente)

A criação de tarefas é um processo guiado pelo agente para garantir a qualidade dos requisitos, utilizando templates oficiais e um processo de refinamento iterativo.

### 1. Coleta Inicial e Rascunho (Obrigatório Interativo):

> Para iniciar a criação, o agente **deve obrigatoriamente** utilizar a ferramenta `ask_user_question`. É proibido assumir valores ou solicitar a definição inicial via chat simples.

Esquema da pergunta:

```ts
ask_user_question({
  questions: [
    {
      question: string,            // full question text, ends with "?"
      header: string,              // chip label, max 16 chars
      options: [
        {
          label: string,           // 1-5 words, max 60 chars
          description: string,     // explains the choice / its trade-off
          preview?: string,        // optional markdown shown next to options
        },
        // … 2-4 options total
        // If 3 options, fourth will be automatically "Other" with free text input
      ],
      multiSelect?: boolean,       // default false
    },
    // … 1-4 questions total
  ]
})
```

- **Passo 1**: Definir **Tipo** (Epic, Story, Task ou Bugfix), **Título** e **Módulo/Caminho**.

```ts
ask_user_question({
  question: 'Qual o tipo da tarefa? (Epic, Story, Task ou Bugfix)',
  header: 'Tipo',
  options: [
    { label: 'Epic', description: 'Grande iniciativa que pode conter várias histórias.' },
    {
      label: 'Story',
      description: 'Funcionalidade ou requisito específico, geralmente parte de um épico.'
    },
    {
      label: 'Task',
      description: 'Tarefa técnica ou de implementação, geralmente parte de uma história.'
    },
    { label: 'Bugfix', description: 'Correção de um problema identificado.' }
  ]
});
```

### 1.2. Se o tipo for Task ou Story, solicitar o item Pai.

- Se Task: O agente deve buscar as 3 histórias mais recentes do backlog local e apresentá-las como opções para facilitar a seleção.

```bash
bash $CAMINHO_SCRIPTS/list-tasks.sh sort=last_updated:desc limit=3 type=story
```

```ts
ask_user_question({
  question: 'Qual a Story pai desta Task? (ex: JUBA-123)',
  header: 'Story Pai',
  options: [
    // Buscar e listar as 3 histórias mais recentes do backlog local para seleção
  ]
});
```

- Se Story: O agente deve buscar os épicos mais recentes do backlog local e apresentá-los como opções para facilitar a seleção.

```bash
bash $CAMINHO_SCRIPTS/list-tasks.sh sort=last_updated:desc limit=3 type=epic
```

```ts
ask_user_question({
  question: 'Qual a Epic pai desta Story? (ex: JUBA-45)',
  header: 'Epic Pai',
  options: [
    // Buscar e listar os épicos mais recentes do backlog local para seleção
  ]
});
```

### 1.3. Título da tarefa:

- Se for Story ou Task, sugerir 3 opções com base nos parantes próximos (épico para histórias, história para tarefas) utilizando o template de título: "Verbo no infinitivo da ação referente à funcionalidade + substantivo da funcionalidade" (ex: "Implementar Login", "Criar Endpoint de Listagem de Usuários").

```ts
ask_user_question({
  question: "Qual o título da tarefa? (Use verbo no infinitivo + substantivo, ex: 'Implementar Login')",
  header: 'Título',
  options: [
    // Sugerir 3 opções baseadas nos parantes próximos utilizando o template de título
  ]
});
```

- Se for Epic, solicitar título de forma livre, mas sugerir que siga a convenção de nomenclatura para manter a consistência.

### 1.4 Domínio

- Solicitar o domínio/escopo da tarefa (`API`, `UI` ou `Integration`).

```ts
ask_user_question({
  question: 'Qual o domínio/escopo da tarefa?',
  header: 'Domínio',
  multiSelect: true, // Permitir múltiplas seleções, pois uma tarefa pode envolver mais de um domínio
  options: [
    { label: 'API', description: 'Tarefas relacionadas à camada de backend e lógica de negócios.' },
    {
      label: 'UI',
      description: 'Tarefas relacionadas à interface do usuário, design e experiência do usuário.'
    },
    {
      label: 'Integration',
      description: 'Tarefas relacionadas à integração entre sistemas, APIs externas ou serviços de terceiros.'
    }
  ]
});
```

### 1.5. Caminho

- Solicitar o caminho onde a tarefa se encaixa (ex: `auth/login`), para organizar a estrutura de diretórios do backlog.

#### 1.5.1. Se for Epic

- Sugira 3 opções de caminhos baseado no título da tarefa, seguindo o padrão de iniciar com o nome do módulo/entidade (ex: `usuarios-gerenciamento/`).

```ts
ask_user_question({
  question: 'Qual o caminho para este Epic? (ex: auth/login)',
  header: 'Caminho',
  options: [
    // Sugerir 2 opções de caminhos baseado no título da tarefa
    // Ex.: usuarios-gerenciamento
  ]
});
```

#### 1.5.2. Se for Task ou Story

- O caminho deve ser o diretório pai selecionado + número sequencial e título em Sentence case (ex: `01 - Listagem/01 - Convidar usuário`).

---

Após as respostas, o agente cria um arquivo de rascunho temporário em `/tmp/juba-backlog-draft.md` baseado no template correspondente em `@.pi/templates/backlog/`.

---

### 2. Refinamento Iterativo (Conversacional)

- Esta é a única fase onde a interação pode ser livre via chat. O agente apresenta o rascunho ao usuário e solicita as informações específicas de cada tipo (Objetivos, User Stories, etc.).
- O agente atualiza o arquivo em `/tmp` via `edit` ou `write` até que o usuário aprove explicitamente o conteúdo final.

### 3. Execução (Commit)

- Após a aprovação final, o agente executa o script `create-task.sh` passando todos os parâmetros coletados.

### 4. Identificação

- O código da tarefa é gerado automaticamente via contador interno.

### 🎯 Seleção de Tarefas

Para localizar rapidamente o código de uma tarefa sem precisar listá-las todas:

- Use o script `select-task.sh` para abrir um buscador fuzzy (`fzf`) e selecionar a tarefa visualmente.

### 🛠️ Atualização de Tarefas

A atualização é dividida entre metadados (frontmatter) e conteúdo (corpo).

#### Metadados (YAML)

Use `bash $CAMINHO_SCRIPTS/update-task-frontmatter.sh <codigo> <campo> <valor>` para modificar:

- **Status**: (ex: `triage` -> `in_progress` -> `done`).
- **Título**: Ajustar o nome da tarefa.
- **Prioridade/Outros**: Qualquer campo presente no frontmatter.
- **Data de Atualização**: O campo `last_updated` é atualizado automaticamente sempre que o frontmatter ou o corpo da tarefa são alterados.

#### Conteúdo (Markdown)

Use `bash $CAMINHO_SCRIPTS/update-task-body.sh <codigo> <acao> <valor> [substituicao]` para modificar a documentação da tarefa:

- `append`: Adiciona texto ao final do arquivo.
- `replace`: Substitui a primeira ocorrência de um texto por outro.
- `set`: Sobrescreve todo o corpo do arquivo.

### 📈 Gestão e Sincronização

- **Análise de Progresso**: Ao listar as tarefas, identifique gargalos (ex: excesso de itens em "triage").
- **Sincronização**: Garanta que qualquer mudança no backlog local esteja refletida na documentação de progresso do projeto, se aplicável.

## Examples

**Listagem Filtrada:**
`bash $CAMINHO_SCRIPTS/list-tasks.sh triage`

**Criação via Fluxo:**

1. Agente pergunta via `ask_user_question` -> Usuário responde.
2. Agente executa: `bash $CAMINHO_SCRIPTS/create-task.sh "Story" "Implementar Login" "auth/login" "Descrição..." "- Critério 1\n- Critério 2"`

**Atualização de Status:**
`bash $CAMINHO_SCRIPTS/update-task-frontmatter.sh JUBA-45 status in_progress`

**Adicionando Nota ao Corpo:**
`bash $CAMINHO_SCRIPTS/update-task-body.sh JUBA-45 append '\n\n## Notas\nRequer revisão da API.'`
