# pi-code

O `pi-code` é um pacote de distribuição focado em **Engenharia de Software**, **Clean Code** e **Desenvolvimento Ágil**. Ele injeta a inteligência e o rigor técnico de engenharia no [Pipa Core](https://github.com/aelinrezende/pipa), transformando a sua orquestradora genérica em um time de desenvolvimento completo.

Este pacote não é focado em desenhar produtos no papel (para isso, use o `pi-discovery`), mas sim em **escrever código, refatorar sistemas, criar arquiteturas limpas e garantir a qualidade técnica** do software que está sendo construído.

It extends Pi with structured task execution, decentralized teammates, persistent
project planning, knowledge management, permission guards, and context hygiene.

Adicione o pacote nas configurações do seu Pi (`settings.json` ou `package.json`):

```json
"packages": [
  "git:github.com/aelinrezende/pi-code"
]
```

## 🚀 Como Funciona

Ao ser carregado, a arquitetura base da Pipa (Pipa Core) detecta este pacote e configura o ambiente local (`.pi/`) com as regras de domínio exclusivas para a área de Engenharia e traz um Squad de Desenvolvimento maduro e pronto para atuar.

### 👑 A Liderança (Engenheira Chefe)

A Pipa incorpora a persona da **Engenheira Chefe**. Ela dita as regras do jogo: rigor com os Padrões de Código (`CODE-STANDARDS.md`), aplicação de princípios como _Early Return_ (Fail Fast), obrigatoriedade de testes unitários e tipagem estrita (TypeScript sem `any`). A Pipa coordena o fluxo para garantir que a arquitetura se mantenha sólida a cada entrega.

### 🤝 O Squad de Engenharia (Teammates)

Para construir o software, a Engenheira Chefe conta com os seguintes especialistas:

1. **Gerente de Produto:** Levanta o escopo inicial, entende a dor do usuário, resolve ambiguidades e define as regras de negócio antes que uma única linha de código seja escrita.
2. **Planejadora (Tech Lead):** Pega as regras de negócio e elabora o plano técnico de execução (o `PLANO.md`), traduzindo o "o que fazer" no "como fazer".
3. **Revisora de Qualidade:** Analisa o plano da Planejadora de forma adversarial e levanta questionamentos não previstos e cenários de borda (_edge cases_). A Planejadora refina o plano em rodadas até a Revisora de Qualidade emitir o veredito **APROVADO** — só então o plano segue para o código.
4. **Staff (Engenheira Executora):** A desenvolvedora principal. Pega o plano técnico e codifica a solução de forma robusta, incremental e validada por testes.
5. **Desenvolvedora:** Uma dev mais tática, perfeita para atacar bugs rápidos e micro-tarefas isoladas onde não faz sentido rodar toda a burocracia de planejamento.
6. **Revisora de Código:** Analisa os _diffs_ de código nas Pull Requests (via GitHub CLI) apontando melhorias.
7. **Homologadora (UAT):** Testa o que foi codado com o olhar e a jornada do usuário final, garantindo que o software realmente resolve o problema proposto.
8. **Comunicadora:** Escreve mensagens de novidade/update para o cliente final do projeto (pessoas leigas em tecnologia) — curtas, casuais, estilo WhatsApp, sem jargão técnico, sempre investigando a entrega real (diff/PR).

## 🛠️ Utilização Prática

1. Inicie a sessão passando a demanda (novo _feature_ ou refatoração) para a Pipa.
2. A Engenheira Chefe pode acionar a **Gerente de Produto** se precisar fechar o escopo de negócio e a **Planejadora** para documentar a solução técnica no `PLANO.md`.
3. A **Revisora de Qualidade** revisa o plano de forma adversarial em rodadas — a Planejadora ajusta e reenvia a cada **REPROVADO** até a aprovação final — evitando bugs no futuro.
4. A **Staff** ou a **Desenvolvedora** assumem o terminal para codar de verdade, dependendo do tamanho da mudança.
5. Ao final, a **Revisora de Código** faz o review do código e a **Homologadora** chancela a entrega de valor. Tudo fica rastreado nos _artifacts_.
