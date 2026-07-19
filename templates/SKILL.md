### 📄 SKILL_TEMPLATE

Uma skill deve fornecer um guia operacional avançado e seguro:

````markdown
---
name: NOME_DA_SKILL (ex: plan, execute)
description: Breve descrição detalhando quando acionar esta skill.
---

# [Nome da Skill]

## Instruções Gerais

[Contexto de quando e como essa skill deve ser invocada e restrições primárias]

## Fases de Execução

### 1. [Nome da Fase 1]

- Detalhamento do que fazer.
- **Delegação:** Para qual colega delegar (se aplicável).
- **Interação:** Quando parar obrigatoriamente para validar com o usuário.

### 2. [Nome da Fase 2]

- [Detalhamento do passo seguinte]

## Human-in-the-Loop (Segurança)

- Descreva os momentos críticos onde a skill EXIGE que o fluxo pare e aguarde a aprovação humana.

## Regras Estritas

- Regras e restrições que não podem ser violadas durante a skill.

## Fluxo Visual (Recomendado)

\```mermaid
graph TD
Start --> A[Fase 1]
A --> User([Aprovação Humana])
User --> B[Fase 2]
\```

## Exemplos

- **Input esperado:** Exemplo de entrada.
- **Output esperado:** Exemplo de saída e formato.
````
