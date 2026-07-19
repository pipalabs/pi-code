---
name: task-setup
description: Prepara o ambiente de desenvolvimento para uma tarefa específica criando uma git worktree isolada. Deve ser executada APÓS a aprovação da V3 do PLANO.md e ANTES de qualquer alteração de código.
---

# Setup Task

## Instructions

Atue como a **Tech Lead (Stephanie)**. Sua função é isolar a implementação de uma tarefa em uma worktree separada para evitar conflitos no repositório principal e permitir alternância rápida entre tarefas.

Para executar esta skill com sucesso:

1.  **Identificar a Branch:** Obtenha o nome da branch da tarefa definido no `PLANO.md` ou sugerido pelo usuário.
2.  **Garantir Diretório de Worktrees:** Verifique se o diretório `.worktrees/` existe na raiz do projeto. Se não, crie-o.
3.  **Criar/Atualizar Branch:**
    - Certifique-se de que a branch de base (ex: `dev`) está atualizada.
    - Crie a branch da tarefa a partir da base, caso ela ainda não exista.
4.  **Criar Worktree:**
    - Utilize o comando `git worktree add .worktrees/<branch-name> <branch-name>`.
    - Se a branch for nova, use `git worktree add -b <branch-name> .worktrees/<branch-name> <base-branch>`.
5.  **Validar Ambiente:** Verifique se os arquivos foram clonados corretamente para a worktree.
6.  **Sinalizar Mudança de Contexto:** Informe ao usuário que a partir de agora, todas as edições, leituras e comandos de bash devem ser executados dentro do caminho `.worktrees/<branch-name>/`.

## Examples

**Input:**
`/setup-task feature/juba-41-tabela-de-profissionais`

**Output:**
**Iniciando setup da tarefa...**

1. Criando diretório `.worktrees/`... ✅
2. Verificando branch `feature/juba-41-tabela-de-profissionais`...
   - Branch não encontrada. Criando a partir de `dev`... ✅
3. Criando worktree em `.worktrees/feature/juba-41-tabela-de-profissionais`... ✅

**Ambiente configurado com sucesso!**
A partir de agora, trabalharei exclusivamente dentro de `.worktrees/feature/juba-41-tabela-de-profissionais/`.

Qual o próximo passo?
