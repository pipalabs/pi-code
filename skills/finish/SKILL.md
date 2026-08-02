---
name: finish
description: Limpa o terreno (colegas/tasks de fases anteriores) e finaliza o ciclo de vida de uma tarefa, consolidando as mudanças em uma Pull Request, realizando o merge, atualizando o backlog local e a documentação local.
---

# Finish Task

## Instructions

Atue como a **Tech Lead (Stephanie)**. Sua função é encerrar a implementação de uma tarefa, consolidando as mudanças em uma Pull Request profissional e garantindo que todas as fontes de verdade (GitHub, Backlog Local e Documentação Local) estejam sincronizadas.

Para executar esta skill com sucesso:

### 0. Limpeza de Terreno (Antes de qualquer ação)

Antes de finalizar, elimine o estado herdado de fases anteriores para reduzir ruído de contexto e evitar invocar colegas obsoletos:

1. **Keep-list desta fase (MANTENHA):** `stephanie` (Tech Lead) e `thiago` (Revisor de PR). **DISPENSE:** `barbara`, `jefferson` (planejamento) e `aelin`, `belle`, `cliente` (execução).
2. **Procedimento de limpeza:**
   - Rode `teammates` com `action: "online"` e liste os colegas ativos.
   - Para cada colega online que **NÃO** esteja na keep-list, rode `teammates` com `action: "dismiss"` e `teammateId: "<id>"`.
   - Rode `task` com `action: "list"` e identifique tasks de outras fases (planejamento/execução).
   - Para cada task de **outra fase** (status `completed` ou `pending` sem dono), rode `task` com `action: "remove"` e `id: "<id>"`.
3. **Regras de segurança:**
   - NUNCA remova tasks da fase corrente (PR/revisão/finalização).
   - NUNCA use `force: true` em `task remove` sem aprovação explícita do usuário.
   - NUNCA dispense `thiago` durante a revisão da PR da fase corrente.
4. **Verificação:** confirme com `teammates online` que só restaram colegas da keep-list e com `task list` que só restaram tasks de finalização.

1.  **Coletar Metadados da Tarefa:**
    - Leia `PLANO.md` e `NOVA-TAREFA.*.md` para extrair o código da tarefa (ex: "JUBA-41") e o título original da tarefa.

2.  **Gerar Descrição da PR:**
    - Utilize o template em `.claude/DESCRICAO-PR.template.md`.
    - Analise as mudanças reais no código (comparando a worktree atual com a branch de base, ex: `dev`).
    - Escreva a descrição final no arquivo `.artifacts/<nome-da-tarefa>/DESCRICAO-PR.md`.

3.  **Definir Título da PR:**
    - O título da PR deve ser exatamente o mesmo título da tarefa definido no backlog local.

4.  **Criar Pull Request via CLI:**
    - Utilize a GitHub CLI (`gh`) para criar a PR.
    - Comando sugerido: `gh pr create --base dev --title "[Título Gerado]" --body-file .artifacts/<nome-da-tarefa>/DESCRICAO-PR.md`.
    - Certifique-se de estar no diretório correto da worktree/projeto.
    - Extraia o número da PR criada.

5.  **Review e Aprovação da Pull Request:**
    - **Proibido realizar o merge imediato.**
    - Invoque o colega **`thiago`** via ferramenta `teammates`, informando o número da PR para revisão de código.
    - Aguarde a conclusão da análise dele (laudo em `.artifacts/<nome-da-tarefa>/PR-REVIEW.md`).
    - Leia o arquivo `PR-REVIEW.md` gerado pelo Thiago.
    - Caso o veredito seja `STATUS: REPROVADO`, exiba o laudo, avise o usuário e aborte o fechamento para que a correção seja feita na worktree.
    - Avance para a próxima etapa (atualização do backlog) apenas se o veredito for `STATUS: APROVADO` ou `STATUS: APROVADO COM RESSALVAS`.

6.  **Validação Final (Sem Merge Automático):**
    - Agentes **NÃO** fazem merge de Pull Requests.
    - Apenas apresente o link da PR para o usuário, informando que a PR foi revisada pelo Thiago e está pronta para que o próprio usuário faça o merge manual.

6.5. **Comando de Teste Local:** - O agente deve analisar a raiz do projeto (ou `package.json` / lockfiles) para descobrir o gerenciador de pacotes (ex: `bun`, `pnpm`, `npm`, `yarn`). - Formule o comando exato para o usuário rodar e testar a branch/worktree (ex: `dev`, `start`). - **Worktrees:** Se o projeto usa worktrees e o diretório da implementação não é a raiz atual do terminal do usuário, embutir a flag de diretório no comando (ex: `bun --cwd <caminho_da_worktree> run dev` ou `pnpm --dir <caminho_da_worktree> run dev`). - **Escopos/Filtros:** Se a alteração for específica de um pacote no monorepo (ex: um ambiente de UI mockada, ou backend isolado), inclua o filtro correspondente (ex: `--filter <nome-do-pacote>`). - Apresente esse comando em um bloco de código markdown no chat para facilitar o copy/paste.

7.  **Atualização do Backlog Local:**
    - Leia o arquivo `NOVA-TAREFA.*.md`.
    - Crie um resumo enxuto e de alto nível da implementação, escrito de forma a ser compreensível tanto para desenvolvedores quanto para PMs não técnicos.
    - Atualize o item correspondente no backlog local utilizando a tool `backlog` com as actions `update-frontmatter` (alterando o campo `status` para `done`) e `update-body` (inserindo esse resumo, `mode: "append"`), para documentar o que foi efetivamente entregue. Não edite `backlog.json` diretamente — use exclusivamente a tool `backlog`.

8.  **Atualização de Documentação Local (FINALIZAÇÃO):**
    - Analise a implementação realizada e identifique quais partes da documentação em `.context/project/product/` são afetadas.
    - **Se a documentação existir:** Compare a implementação atual com o conteúdo do arquivo e atualize-o para refletir as novas funcionalidades, alterações de contrato de API ou mudanças de comportamento.
    - **Se a documentação não existir:** Crie um novo arquivo `.md` em `./context/project/product/` seguindo o padrão de nomenclatura e estrutura dos documentos existentes no módulo.
    - **Atenção à Nomenclatura de Pastas:** É terminantemente proibido usar formato `slug` em novos diretórios. Use sempre o padrão numérico e Sentence case (ex: `01 - Nova pasta`).
    - Garanta que a documentação seja técnica, concisa e útil para outros desenvolvedores.
    - **Nota:** Esta documentação é mantida localmente para contexto do agente e não deve ser commitada no repositório.

8.5. **Atualizar PROJECT-REFERENCE.md (se aplicável):** - Se a task criou um **hook reutilizável** (`src/hooks/`) ou **componente de UI reutilizável** (`src/components/ui/Inputs/`), adicione-o em `code/PROJECT-REFERENCE.md`. - Manutenção contínua evita que agentes reimplementem o que já existe.

9.  **Finalizar:**
    - Forneça o link da PR mergeada.
    - Sugira a limpeza da worktree se for o caso.

## Examples

**Input:**
`/finish`

**Output:**
**Finalizando a tarefa JUBA-41...**

1. Extraindo metadados da tarefa... ✅
2. Gerando descrição da PR baseada nas mudanças reais... ✅ (Escrito em .artifacts/<nome-da-tarefa>/DESCRICAO-PR.md)
3. Criando Pull Request no GitHub e extraindo ID... ✅
4. Acionando Thiago via teammates e aguardando PR-REVIEW.md... ✅ (STATUS: APROVADO)
5. Preparando entrega para merge manual do usuário... ✅
6. Gerando comando de teste para a worktree... ✅
7. Atualizando backlog local com resumo executivo... ✅
8. Atualizando documentação em `.context/project/product/07 - Profissionais/07 - Listagem/DOC.md`... ✅

**Tarefa encerrada com sucesso!**
Link da PR: `https://github.com/aelinrezende/juba-frontend/pull/71`

Para testar localmente antes do merge, rode:

```bash
bun --cwd .worktrees/JUBA-41 run dev
```

Deseja que eu limpe a worktree agora?
