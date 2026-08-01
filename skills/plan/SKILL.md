---
name: plan
description: Planeja uma tarefa orquestrando a equipe de agentes (Barbara, Stephanie, Jefferson) na construção do PLANO.md evolutivo (Setup -> V1 -> V2 -> V3) a partir da NOVA-TAREFA.*.md. Inclui etapa de setup de worktree/branch e integra backlog local com contexto do projeto.
---

# Planejar Tarefa

## Instructions

Para orquestrar esta skill, você deve acionar a **Tech Lead (Stephanie)** logo no início e passar a requisição para ela. Ela possui autonomia para conduzir todo o fluxo e invocar os demais especialistas (Barbara e Jefferson) conforme as fases abaixo. Você atuará apenas como o **Despachante e Orquestrador Inicial**.

**Antes de qualquer ação, consulte `code/PROJECT-REFERENCE.md` para conhecer hooks, componentes e padrões disponíveis — isso evita reimplementar o que já existe.**

Nota: se for fornecido um código de tarefa como argumento, busque os dados iniciais usando o comando `just backlog-list --limit 1 code=<código>` e trate a saída como o conteúdo de `NOVA-TAREFA.<nome-da-tarefa>.md` para iniciar o fluxo.

### 0. Setup de Ambiente (Antes de qualquer planejamento)

Antes de iniciar a definição de escopo, prepare o ambiente isolado de desenvolvimento:

1. **Identificar a Branch:** Obtenha o nome da branch da tarefa definido na `NOVA-TAREFA.*.md` ou sugerido pelo usuário.
2. **Garantir Diretório de Worktrees:** Verifique se o diretório `.worktrees/` existe na raiz do projeto. Se não, crie-o.
3. **Criar/Atualizar Branch:**
   - Certifique-se de que a branch de base (ex: `dev`) está atualizada.
   - Crie a branch da tarefa a partir da base, caso ela ainda não exista.
4. **Criar Worktree:**
   - Utilize `git worktree add .worktrees/<branch-name> <branch-name>`.
   - Se a branch for nova, use `git worktree add -b <branch-name> .worktrees/<branch-name> <base-branch>`.
5. **Validar Ambiente:** Verifique se os arquivos foram clonados corretamente para a worktree.
6. **Sinalizar Mudança de Contexto:** Informe ao usuário que a partir de agora, todas as edições, leituras e comandos de bash devem ser executados dentro do caminho `.worktrees/<branch-name>/`.

> O setup é executado automaticamente como fase inicial do plano, eliminando a necessidade de uma skill separada.

### 1. Definição de Escopo (Delegação: Agente Barbara)

A primeira etapa é isolar ambiguidades e extrair todas as regras de negócio de `NOVA-TAREFA.*.md` e do repositório de documentos `.context/project/product/`.

- A **`barbara`** deve ser invocada pela Tech Lead via **teammates** para explorar os requisitos, cruzar com a base de conhecimento e gerar o "Relatório de Execução Segura".
- **Interação:** Se a Barbara encontrar ambiguidades, apresente as dúvidas geradas por ela ao usuário e **aguarde as respostas** antes de avançar.

### 2. Planejamento Arquitetural (Delegação: Agente Stephanie)

Com o escopo da Barbara alinhado, passe o trabalho de engenharia para a Tech Lead.

- A **`stephanie`** tomará posse do Relatório da Barbara e das respostas do usuário para orquestrar as V1/V2.
- O objetivo da Stephanie é redigir o `.artifacts/<nome-da-tarefa>/PLANO.md` e suas opções arquiteturais.
- **Ação V1:** Instrua a Stephanie a apresentar no mínimo 2 opções de solução (V1 - Visão Geral).
- **Interação:** Exiba as propostas para o usuário e pergunte _"Qual opção técnica você deseja seguir?"_, depois **aguarde a decisão**.

### 3. V2, V3 e Auditoria de Riscos (Delegação: Agente Jefferson)

Com a opção escolhida pelo usuário:

- A **`stephanie`** fechará o passo a passo (V2) e especificações/contratos (V3).
- ANTES de aprovar o passo a passo como definitivo para o desenvolvimento, a **`stephanie`** deve invocar o **`jefferson`** via **teammates** para que este analise criticamente a V2/V3 gerada. Ele procurará por cenários "unhappy path", falhas de arquitetura e edge cases.
- Repasse as pontuações e riscos levantados pelo `jefferson` para que a `stephanie` fortaleça e atualize as seções no `PLANO.md`.

### 4. Apresentação e Aprovação do Plano (Usuário)

Com o `PLANO.md` (V3) auditado pelo Jefferson e refinado pela Stephanie:

1. **Apresente o plano completo ao usuário** — exiba o sumário executivo do `PLANO.md`: objetivo, arquitetura escolhida, fases, contratos e riscos mitigados.
2. **Pare e aguarde aprovação explícita.** Pergunte: _"O plano está aprovado? Posso iniciar a implementação?"_
3. O plano só avança pra execução após o usuário responder **"sim"** ou **"de acordo"** explicitamente.
4. Se o usuário pedir ajustes, retorne pra Stephanie refinar e volte ao passo 1.

### 5. Transição para Execução

Após aprovação explícita do usuário:

- **Encerramento:** Conclua o processo de planejamento técnico (Plan).
- **Aviso:** Informe ao usuário que agora o comando `/execute` deve ser chamado para realizar a codificação real seguindo o plano aprovado.

## Human-in-the-Loop (Segurança)

Apesar da delegação ocorrer autonomamente entre os subagentes, o avanço entre as Fases Críticas EXIGE uma pausa sua (Main Agent). Você deve sempre **apresentar os resultados ao usuário (ex: ESCOPO.md ou PLANO.md) e obter o "De Acordo"** antes de permitir que o fluxo vá de ponta a ponta.

## Fluxo Visual (Loop de Agentes)

```mermaid
graph TD
    Start([Início / NOVA-TAREFA]) --> Setup[0. Setup: Worktree]
    Setup --> Orquestrador[Orquestrador]
    Orquestrador --> Barbara[1. PM: Barbara]
    Barbara -->|Ambiguidades?| User([Usuário])
    User -->|Respostas| Barbara
    Barbara -->|Escopo Definido| Stephanie[2. Tech Lead: Stephanie]
    Stephanie -->|Opções V1| User
    User -->|Escolhe Opção| Stephanie
    Stephanie -->|Cria V2 e V3| Jefferson[3. QA/Riscos: Jefferson]
    Jefferson -->|Levanta Riscos| Stephanie
    Stephanie -.->|Refina Plano| Jefferson
    Jefferson -->|Plano Auditado| User
    User -->|Aprovação Explícita| Aelin[4. Aprovação]
    Aelin -->|De Acordo| Exec[5. Execução: Aelin]
```

## Rules

- **Jamais atropele os agentes**: deixe que a Barbara levante as dúvidas, que a Stephanie faça as propostas e que o Jefferson critique. Você é o orquestrador que chama esses especialistas e serve de interface com o usuário.
- **Não tome decisões sozinho**: toda tomada de decisão estrutural de produto, arquitetura ou resolução de Edge Cases apontados deve passar pelo escopo da equipe e ser aprovada pelo usuário.

## Examples

**Input:**
`/plan JUBA-456`

**Output:**
**Orquestrando contexto de produto com a PM: Invocando agente `barbara`...**

[Relatório da Barbara é exibido, levantando regras de negócio e perguntas X, Y]
_Por favor, pode responder a essas questões da PM para seguirmos com o escopo?_ (Aguarde usuário)

**Após respostas:**
**Escopo alinhado! Invocando Tech Lead `stephanie` para elaborar arquitetura...**
[Apresenta Opção A e Opção B sugeridas pela Stephanie]
_Qual opção de arquitetura você prefere adotar?_ (Aguarde usuário)

**Após usuário escolher:**
**Criando passo a passo (V2) com `stephanie` e requisitando revisão de Qualidade do `jefferson`...**
[Mostra apontamentos do Jefferson aplicados ao plano aprimorado pela Stephanie]
_Plano consolidado com sucesso. Podemos invocar a `aelin` para seguir com a codificação._
