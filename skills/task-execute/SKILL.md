---
name: task-execute
description: Use esta skill para iniciar e orquestrar a execução técnica de uma tarefa já planejada. Ela delega a codificação para a agente Aelin, garantindo que o plano aprovado seja implementado de forma incremental e validada.
---

# Executar Tarefa

## Instructions

Para orquestrar esta skill, invoque a **Engenheira de Software (Aelin)**. Sua função é garantir que o trabalho codificado saia do papel e siga rigorosamente o `.artifacts/<nome-da-tarefa>/PLANO.md` elaborado. Ela será responsável por executar e, no final, orquestrar a validação (UAT) com o cliente.

Para executar esta skill com sucesso:

**Antes de qualquer ação, consulte `code/PROJECT-REFERENCE.md` para conhecer hooks, componentes e padrões disponíveis — isso evita reimplementar o que já existe.**

### 1. Validação de Pré-requisitos

- Verifique se `.artifacts/<nome-da-tarefa>/PLANO.md` existe, se possui a V3 (Definição Técnica) preenchida e se está aprovado.
- Confirme se o ambiente já foi preparado (nova worktree ou branch isolada via skill de setup).
- Sem plano aprovado, recuse o início e oriente o uso da skill `task-plan`.

### 2. Início da Execução (Agente Aelin)

- invoque a **`aelin`** via **teammates** repassando todas as regras estritas de execução abaixo.
- Forneça o `PLANO.md` e instrua-a a iniciar a implementação.
- A `aelin` decidirá autonomamente entre o **Fast-Track** (execução direta) ou a **Legião** (delegação para a Belle), conforme definido em sua persona.
- Em ambos os casos, a `aelin` é responsável por inicializar e manter atualizado o `EXECUTION-REPORT.md` para garantir a rastreabilidade total.

### 3. Supervisão e Monitoramento

- No **Fast-Track**, a `aelin` executará a tarefa integralmente.
- Na **Legião**, a `aelin` atuará como orquestradora, delegando subtasks para a **`belle`** via `teammates spawn` e consolidando os resultados.
- Seu papel agora é aguardar o reporte completo: monitore a evolução através do `EXECUTION-REPORT.md`.
- Intervenha apenas se a `aelin` relatar impedimentos técnicos, conflitos de arquitetura ou se a qualidade das entregas da Belle for insuficiente.
- Exija a execução e aprovação em testes estáticos. Para projetos frontend, certifique-se que ela rodou `npm run lint`, `npm run ts-check` e `npm run format-check`. Para projetos backend, certifique-se que ela fez o build da aplicação para confirmar que está tudo ok e compilando.
- Aguarde a confirmação da `aelin` de que a implementação técnica foi concluída e validada (build/lint/ts-check/testes passaram).

### 4. Validação do Cliente Final (Agente Usuario / UAT)

- Quando todas as múltiplas execuções das `aelin`s terminarem seu trabalho técnico sem erros de lint/testes, introduza a etapa de homologação (UAT).
- A **Aelin** deve invocar o **`cliente`** via **teammates**. Ela deve passar a ele o `EXECUTION-REPORT.md`, os principais arquivos desenvolvidos e a `NOVA-TAREFA.*.md` original.
- O Agente Usuario simulará o comportamento da interface/produto entregue para validar se a promessa foi cumprida sob a ótica de usabilidade e comportamento, emitindo um laudo crítico de aprovação ou repúdio de UX/Fluxo.
- Se o `cliente` reprovar por algum edge case prático, retorne as observações paras as Engs `aelin` consertarem.

### 5. Conclusão

- Com o endosso final do **`cliente`**:
  - Exiba o `EXECUTION-REPORT.md` finalizado e o Veredito do UAT.
  - Recomende seguir com o encerramento da tarefa (ex: `task-finish` para abrir Pull Request).

## Human-in-the-Loop e Segurança

A execução terminará com o UAT do Cliente. Vocês podem e devem abrir a "Pull Request", mas a responsabilidade de realizar o "Merge" definitivo não é de vocês de forma automática. Ao receber o laudo final aprovado e a PR aberta, mostre o sumário ao usuário e **aguarde a permissão expressa dele** para fechar a tarefa e efetuar o merge definitivo.

## Rules

- **Não implemente sozinho:** Delegue a execução para a Aelin e supervisione o progresso via artefatos de report.
- **Paralelismo Seguro:** Confie na Aelin para orquestrar a Legião de Belles, garantindo que as subtasks sejam independentes.
- **Validação Técnica Rigorosa:** Garanta que a Aelin comprove a execução dos testes estáticos (lint, ts-check, format-check) no frontend e o sucesso do build no backend.
- **Garantia de UAT:** Você só pode considerar o task-execute encerrado depois que o `cliente` rodar sua homologação (Laudo de Aceite) sobre o código gerado.

## Examples

**Input:**
`/task-execute`

**Output:**
**Validando artefatos de planejamento...**
Plano técnico V3 validado.

**Iniciando codificação: Chamando agente `aelin`...**
_Aelin: "Fase 1 iniciada..."_
_Aelin: "Fase 1 concluída sem erros de Typescript/Linter."_

_(Aguardando Aelin seguir pelas demais fases)_

**Ao terminar:**
_Execução finalizada com sucesso! Todas as validações passaram. Próximo passo: PR._
