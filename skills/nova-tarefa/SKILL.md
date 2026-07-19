---
name: nova-tarefa
description: 'Cria arquivo NOVA-TAREFA.<slug>.md usando template NOVAS-TAREFAS com investigação agentica de arquivos, critérios de aceite inferidos por agente/docs e validação final contra @docs. USE sozinha e antes de /skill:task-plan quando: criar nova tarefa com contexto do código, gerar tarefa a partir de docs, preparar escopo agentico.'
---

# Nova Tarefa

Crie interativamente um arquivo `NOVA-TAREFA.md` no diretório `.artifacts/`, usando `./references/templates/NOVA-TAREFA.template.md` como template principal.

Objetivo: receber brief mínimo do dev e delegar ao agente trabalho de baixa inteligência e alto esforço: buscar arquivos, ler docs, inferir critérios, identificar reaproveitamento e validar coerência. O dev continua responsável por intenção, restrições e decisões reais de produto/arquitetura.

O arquivo gerado deve ter escopo pequeno, bem reduzido e executável em uma tarefa curta. Não transforme um pedido simples em iniciativa ampla, épico ou redesign.

## Uso com outras skills

- Invoke `nova-tarefa` sozinha: não combine esta skill com outras skills no mesmo pedido ou fluxo.
- Execute `nova-tarefa` antes de `/skill:task-plan`.
- O arquivo `.artifacts/<nome-da-tarefa>/NOVA-TAREFA.md` gerado por esta skill alimenta etapa posterior `/skill:task-plan`.
- `nova-tarefa` não substitui `/skill:task-plan`: ela reduz coleta braçal; `/skill:task-plan` valida decisões, trade-offs e riscos antes de planejar.
- Se não houver decisão aberta, `/skill:task-plan` pode ser etapa curta de confirmação.
- Não chame `/skill:task-plan` automaticamente. Ao concluir, reporte caminho criado, aponte pontos vagos/incertos apenas no relatório final quando existirem e diga: se estiver tudo ok após revisão, executar `/skill:task-plan` usando arquivo gerado como contexto.

## Workflow

1. Leia `./references/templates/NOVA-TAREFA.template.md` como template principal obrigatório.
   - Se ele não existir, pare e reporte lacuna. Não use outro template sem confirmação do usuário.
2. Não use arquivos `NOVA-TAREFA*.md` existentes como exemplo, template, fonte de tom ou calibração. Use apenas o template principal, docs oficiais e investigação do codebase.
3. Obtenha o brief mínimo antes de investigar. Primeiro, analise o contexto da conversa e qualquer documentação existente informada ou disponível no projeto. Se as informações já estiverem claras e suficientes, **não faça perguntas** e prossiga. Use `ask_user_question` apenas para coletar lacunas estritamente necessárias:
   - `Nome breve da tarefa` (`text`)
   - `Contexto do Negócio e Problema` (`text`)
   - `Estado desejado/objetivo` (`text`)
   - `Limites e Fora do Escopo` (`text`, optional)
   - `Referências externas` (`text`, optional; peça Ticket/Task, Documentação específica e Design no mesmo campo, com rótulos)
   - `Nome do arquivo/slug` (`text`, optional; se vazio, inferir kebab-case do nome breve)
   - Não peça critérios de aceite, requisitos técnicos, regras técnicas ou arquivos locais como campos obrigatórios. Esses itens são responsabilidade inicial do agente.
   - Se usuário informar espontaneamente critérios, requisitos ou arquivos, use como pistas e valide contra docs/codebase.
   - Se o brief sugerir múltiplas frentes, reduza para menor recorte entregável ou pergunte qual recorte priorizar.
   - Se o próprio usuário pedir objetivo amplo, épico, múltiplos módulos, múltiplas ações independentes ou mudança end-to-end, não gere tarefa grande.
4. Faça busca de arquivos pelo agente, não pelo usuário:
   - Use busca/leitura direta do codebase ou subagent de exploração quando escopo for amplo.
   - Identifique arquivos locais relevantes, código similar, componentes, serviços, hooks, módulos, testes, docs e padrões existentes.
   - Não peça ao usuário lista de arquivos locais. Se usuário informar caminhos espontaneamente, trate como pistas, mas ainda valide por investigação.
   - Registre evidência suficiente para justificar cada arquivo listado em `Arquivos Locais`.
5. Derive regras, requisitos técnicos e reaproveitamento pelo agente:
   - Use docs e código existente para inferir padrões inegociáveis, tipagem, lint, arquitetura, bibliotecas, fluxo de dados e performance.
   - Para preencher seção 4, priorize conhecimento acumulado do projeto:
     1. `CODE-STANDARDS.md`, quando existir.
     2. `ARCHITECTURE.md`, quando existir.
     3. `PROJECT-REFERENCE.md`, quando existir.
     4. Evidência do código investigado.
     5. Brief do usuário.
   - Use na seção 4 somente memórias e regras aplicáveis à tarefa: regras de negócio não óbvias, decisões técnicas persistentes, padrões de design/UX, restrições de cliente e correções de comportamento recorrentes.
   - Não faça dump de memórias. Condense em lembretes acionáveis para impedir desvios do agente executor.
   - Não crie nem edite `CODE-STANDARDS.md` nesta skill, salvo pedido explícito do usuário.
   - Preencha seção 6 com componentes, utilitários, serviços, hooks, padrões ou módulos confirmados por investigação.
   - Código pode provar que algo existe ou é possível; não prova que deve virar comportamento de produto.
   - Não transforme campos técnicos, componentes ou dados encontrados no código em ações/regras de usuário sem evidência em docs, comportamento existente ou confirmação do usuário.
   - Não invente arquitetura nova quando padrão existente resolve.
   - Marque premissas quando inferência não tiver fonte forte.
6. Derive critérios de aceite pelo agente e/ou com base em `@docs/`:
   - Leia docs relevantes em `docs/` antes de finalizar critérios.
   - Use `INDEX.md` para consultar índice de produto e índice técnico.
   - Siga links relevantes ao domínio da tarefa; não leia todos docs cegamente quando o índice apontar documento específico.
   - Leia `CODE-STANDARDS.md` quando existir e houver regra persistente aplicável.
   - Se houver documentação específica em `product/` relacionada ao domínio da tarefa, use-a como fonte primária.
   - Docs de produto e brief do usuário são fonte primária para comportamento esperado.
   - Critérios de aceite só podem ser derivados de: brief do usuário, docs de produto, comportamento existente comprovado ou decisão explícita do usuário.
   - Critérios devem manter visão de usuário/produto, sem citar código, paths, componentes ou funções.
   - Critérios devem ser específicos, observáveis e testáveis: cada item deve indicar comportamento verificável, estado esperado, regra de bloqueio, feedback, permissão ou resultado mensurável.
   - Cada critério deve apontar qual parte do objetivo ele comprova. Evite frases genéricas como `ações funcionais`, `funcionar corretamente`, `experiência clara`, `sem regressão` ou `feedback adequado` sem detalhar o comportamento esperado.
   - Quando houver ações, fluxos ou estados, liste critérios por ação/estado relevante: caminho feliz, erro, indisponibilidade, permissão, vazio/loading e persistência/atualização de dados.
   - Transforme critérios de aceite em checkboxes Markdown (`- [ ] ...`).
   - Se objetivo depende de escolher quais ações, estados ou regras existem e docs não definem, pare antes de gerar arquivo e pergunte ao usuário.
   - Se não houver informação suficiente para escrever critérios específicos e testáveis, pare antes de gerar arquivo e pergunte ao usuário para criar os critérios junto. Use `ask_user_question` com perguntas focadas no comportamento esperado, não peça uma lista pronta.
   - Se docs não cobrirem comportamento esperado, o agente só pode inferir critérios a partir do brief, padrões de produto e comportamento existente comprovado.
   - O arquivo gerado deve ser assertivo: não inclua incertezas, dúvidas, premissas fracas ou decisões abertas como conteúdo de requisito.
   - Incertezas que bloqueiam escopo, critério ou regra devem ser perguntadas antes de gerar o arquivo.
   - Incertezas não bloqueantes devem ficar apenas no relatório final em `Pontos para revisar`, nunca dentro do arquivo gerado.
7. Mantenha escopo pequeno e proporcional:
   - O objetivo deve descrever um recorte único e entregável, não uma iniciativa ampla.
   - Critérios de aceite devem cobrir somente o MVP do objetivo escolhido.
   - Evite multiplicar ações, estados, integrações ou fluxos além do que o brief pede.
   - Não crie `NOVA-TAREFA` com objetivo que dependa de múltiplas entregas independentes para ser aceito.
   - Se o usuário pedir escopo grande, pare antes de gerar o arquivo: proponha 2-5 recortes menores, recomende o primeiro recorte e pergunte qual priorizar.
   - Se investigação revelar escopo grande, divida mentalmente e gere apenas a menor tarefa útil; registre demais ideias fora do recorte como fora do escopo no arquivo quando forem objetivas, ou como pontos para revisar no relatório final quando dependerem de decisão.
   - Se não for possível reduzir com segurança, pergunte ao usuário qual recorte priorizar.
8. Pergunte ao usuário somente quando houver decisão real:
   - Mudança ou criação de regra de negócio.
   - Quebra de compatibilidade ou alteração de comportamento existente.
   - Escolha entre abordagens com trade-off relevante de UX, arquitetura, prazo ou risco.
   - Conflito entre pedido, docs e código.
   - Escopo novo não explicitado no brief.
   - A coleta de brief segue esta regra: não faça perguntas se as informações puderem ser deduzidas do contexto ou de documentos disponíveis.
   - Não use perguntas para transferir busca, leitura, listagem de arquivos ou redação de critérios ao usuário.
9. Gere markdown preservando 7 seções do template:
   - `## 1. Contexto do Negócio e Problema`
   - `## 2. Estado Desejado / Objetivo`
   - `## 3. Limites e Fora do Escopo`
   - `## 4. Regras e Lembretes (Anti-Teimosia da IA)`
   - `## 5. Critérios de Aceite`
   - `## 6. Requisitos Técnicos e Reaproveitamento`
   - `## 7. Arquivos de Entrada e Referências`
   - Seção 1 deve conter apenas contexto de negócio, produto e problema. Não inclua código, paths, componentes, funções ou referências técnicas.
   - Código e referências técnicas devem ir em seções 6 ou 7.
10. Preserve integralmente instrução estrita MCP da seção 7 do template, incluindo título `🛑 **INSTRUÇÃO ESTRITA PARA O AGENTE:**`.

- Não acione MCP ao ler ou criar tarefa.
- Links externos são apenas referências para uso posterior no momento indicado pela instrução.

11. Defina destino como `.artifacts/<nome-da-tarefa>/NOVA-TAREFA.md`.

- Se slug estiver vazio, inferir kebab-case de `Nome breve da tarefa`.
- Se slug for vazio ou genérico demais, use `.artifacts/<nome-da-tarefa/NOVA-TAREFA.md` somente quando usuário pedir explicitamente.
- Se arquivo de destino já existir, pergunte antes de sobrescrever.

12. Ao final, bata conteúdo gerado com docs em `product/`:

- Releia arquivo salvo.
- Releia docs relevantes em `product/` usados ou descobertos.
- Verifique alinhamento de termos de domínio, arquitetura, restrições, regras persistentes e padrões de produto.
- Ajuste arquivo se houver divergência objetiva.
- Se docs não tiverem informação suficiente para validar algum ponto, não coloque incerteza dentro do arquivo; reporte em `Pontos para revisar` no resumo final.

13. Valide por leitura do arquivo salvo que todas seções numeradas de 1 a 7 estão presentes, que instrução MCP foi preservada e que o arquivo não contém incertezas internas.
14. Reporte caminho criado, arquivos/docs usados, recorte escolhido, critérios inferidos e validações executadas.
15. Inclua no relatório final `Pontos para revisar` quando houver incertezas, dúvidas ou decisões não bloqueantes. Se não houver, diga: `Nenhum ponto vago identificado.`
16. Sugira explicitamente próximo passo condicional: `Se estiver tudo ok após revisar os pontos acima, execute /skill:task-plan usando .artifacts/<nome-da-tarefa/NOVA-TAREFA.md como contexto.` Não invoque `/skill:task-plan` automaticamente.

## Regras de formatação

- Mantenha links externos em lista com rótulos do template: `Ticket/Task`, `Documentação específica`, `Design`.
- Preserve prefixo `@` nos caminhos quando existentes.
- `Arquivos Locais` deve conter somente arquivos confirmados por investigação do agente ou caminhos espontâneos do usuário validados por leitura/busca.
- Quando nenhum arquivo local específico for encontrado, escreva `- Não identificado após busca no codebase.` e registre risco no resumo final.
- Quando não houver conteúdo opcional, mantenha seção correspondente com item claro como `- Não informado.` ou `- Nenhum item fora do escopo informado.`.
- Mantenha nomes de código, paths, componentes, funções e arquivos em inglês ou exatamente como existentes.
- Não invente comportamento como requisito; se inferido, deixe rastreável ao brief, docs de produto, comportamento existente ou decisão explícita do usuário.
- Não use detalhe técnico isolado como fonte de comportamento de produto.
- Critérios de aceite genéricos são inválidos. Reescreva até ficarem específicos, testáveis e ligados a partes do objetivo.
- Critérios demais também são inválidos quando indicam escopo inchado. Reduza ao MVP e mova o restante para fora do escopo quando for objetivo, ou para `Pontos para revisar` no relatório final quando depender de decisão.
- Separe claramente fatos encontrados e inferências do agente no processo, mas gere arquivo final assertivo, sem dúvidas internas.

## Critérios de conclusão

- `NOVA-TAREFA.md` foi criado em `.artifacts/<nome-da-tarefa>.
- Arquivo segue `./references/templates/NOVA-TAREFA.template.md`.
- Busca de arquivos foi feita pelo agente e referências locais foram validadas.
- Escopo final é pequeno, reduzido e proporcional ao brief.
- Se pedido original era amplo, arquivo registra o recorte escolhido e itens restantes em fora do escopo.
- Critérios de aceite foram inferidos pelo agente e/ou derivados de `product/`, com itens específicos, observáveis, testáveis, ligados ao objetivo e limitados ao MVP.
- Cada critério de aceite tem origem rastreável: brief, docs de produto, comportamento existente comprovado ou decisão explícita do usuário.
- Requisitos técnicos, reaproveitamento e regras relevantes foram inferidos pelo agente a partir de docs/codebase.
- Seção 4 foi baseada em `CODE-STANDARDS.md` quando relevante/existente, sem copiar memórias irrelevantes.
- O brief foi obtido através de contexto, documentos ou perguntas estritamente necessárias. Decisões reais que bloqueavam escopo/critério/regra foram perguntadas ao usuário antes de gerar o arquivo.
- Conteúdo final foi comparado com docs relevantes em `@product`.
- Arquivo preserva as 7 seções do template e instrução estrita MCP.
- Arquivo final não contém incertezas, dúvidas, premissas fracas ou decisões abertas como requisitos.
- Relatório final informa arquivo criado, arquivos/docs usados, validações executadas e `Pontos para revisar` quando existirem.
- Relatório final sugere próximo passo de forma condicional: se estiver tudo ok após revisão, usar `/skill:task-plan` com arquivo gerado como contexto.
