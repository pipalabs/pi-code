---
name: client-update-message
description: 'Gera mensagem de update/novidades para o cliente final do projeto (pessoas leigas em tecnologia). USE quando: gerar ou redigir mensagem de update para cliente, comunicar entrega de feature ao cliente, escrever "client update" ou "mensagem pro cliente". Produz texto curto, casual, estilo WhatsApp, sem jargão técnico.'
---

# Client Update Message

## Instructions

Para orquestrar esta skill, invoque o **Danilo** (Comunicação com o Cliente) via **teammates**. Ele investiga a entrega real (diff/PR/git log), calibra o tom com `references/EXAMPLE.md` e redige a mensagem casual, curta e sem jargão técnico. Você atua como despachante e interface com o usuário.

**Regra de ouro:** a mensagem precisa parecer que veio de uma pessoa próxima e confiável — nunca de um time de engenharia. Nada de tom formal e profissional.

### 1. Identificar a Entrega

- Identifique o alvo do update: código da tarefa, branch ou número da PR (argumento da skill ou pergunte ao usuário).
- Repasse ao Danilo o alvo identificado e, se existirem, os artefatos em `.artifacts/<nome-da-tarefa>/` (`NOVA-TAREFA`, `EXECUTION-REPORT`, `UAT-REPORT`, `PR-REVIEW`).

### 2. Delegar ao Danilo

- Invoque o **`danilo`** via **teammates** (`{"action": "spawn", "name": "danilo", "goal": "Redigir mensagem de update para o cliente sobre <tarefa/PR>"}`).
- O Danilo executa o fluxo completo: investigar a entrega real, ler `references/EXAMPLE.md` para calibrar o tom, seguir o template `references/TEMPLATE.md` e validar o checklist.
- Intervenha apenas se ele não encontrar entrega confirmada no diff/PR — nesse caso não há update a dar: informe o usuário.

### 3. Entregar ao Usuário

- Exiba a mensagem pronta no chat, estilo WhatsApp, para o usuário repassar ao cliente.
- Se o usuário quiser histórico, registre (append) em `.artifacts/<nome-da-tarefa>/CLIENT-UPDATE.md`.

## Human-in-the-Loop (Segurança)

- A mensagem é uma **proposta**: o usuário revisa e decide o que enviar. Nunca envie a ninguém por conta própria.
- Proibido prometer o que não está confirmado no diff/PR. Sem "em breve", sem "agora também dá pra..." se não foi entregue.

## Rules

- Proibido jargão técnico: backend, deploy, bugfix, API, sprint, release, refactor, banco de dados, servidor.
- Proibido prometer coisa não entregue.
- Cada item listado deve ter o impacto prático explicado.
- Tom casual, próximo, com emoji moderado (máx ~2 por mensagem). Nada de formal/profissional.
- Curta e escaneável para WhatsApp: lê em menos de 30 segundos.
- Encerrar com canal de contato ("se notarem algo estranho, me chamem aqui no grupo").
- Ignorar mudanças internas que o cliente não percebe (backend, API, refactor, infra).

## Gotchas

- O exemplo de tom está em `references/EXAMPLE.md` — o Danilo DEVE lê-lo antes de redigir (calibração de tom).
- Não confunda com o colega `cliente` (faz UAT, é o destinatário). Quem escreve a comunicação é o `danilo`.

## Examples

**Input:**
`/client-update-message <PR-123>`

**Output:**
**Invocando o comunicador `danilo`...**

```markdown
Oi gente! 👋 Passando aqui para avisar que subi uma atualização nova no app! 🚀

Agora dá pra excluir um item direto pela listagem. É só clicar no ícone de excluir que aparece ao lado de cada item — uma confirmação aparece antes pra evitar cliques sem querer.

## O impacto prático

Nada de gambiarra pra remover o que não é mais usado: a lista fica mais limpa, só com o que realmente importa.

Se notarem algo estranho ou tiverem alguma dúvida, é só me chamar aqui no grupo! ✨
```

Pronto para repassar ao cliente no grupo.
