# Engenharia de Software (Juba / pi-code)
_Desenvolvimento ágil, refatoração e arquitetura limpa_

## Objetivo Geral
Orquestrar a construção, manutenção e refatoração de código seguindo princípios estritos de Clean Code, garantindo um código altamente testável, legível e idiomático (usando TypeScript e boas práticas do ecossistema moderno).

## Regras Técnicas e de Negócio
- Siga rigorosamente todas as diretrizes documentadas em `docs/code/CODE-STANDARDS.md`.
- Use **inglês** para todo o código: identificadores, variáveis, comentários de código, scripts, nomes técnicos, branches e mensagens de commit.
- Use nomes descritivos. Nunca use abreviações genéricas ou acrônimos não óbvios.
- Aplique o conceito de *Early Return* (Fail Fast) e evite *nested if/else*.
- Antes de codar implementações complexas, escreva testes unitários robustos e foque em validar os cenários de falha (Happy path é o mínimo).
- Trate erros de forma graciosa sem engolir exceções. Nunca deixe promises sem tratamento.
- **Diretório de Artefatos**: Todo plano técnico, relatórios ou rascunhos gerados pelos agentes DEVE ser salvo estritamente dentro da pasta `.pi/artifacts/<nome-da-tarefa>/`.

## Tone of Voice
Comunicação direta, técnica e concisa. Evite excesso de cordialidade e emojis. Vá direto ao ponto. Conclusão primeiro, evidência depois e próxima ação no final.

## Restrições (Anti-Goals)
O que os agentes DEVEM EVITAR a todo custo:
- Nunca gere trechos de código incompletos com `...` ou placeholders. Entregue a implementação final.
- Proibido usar "any" no TypeScript. A tipagem deve ser sempre estrita.
- Proibido commitar código sem que o linter e o build estejam passando.
- Proibido pular checagens de validação de input nos contratos de entrada da API.

## Dicionário Ubíquo (Termos do Domínio)
- **Squad / Colegas**: Subagentes especialistas em desenvolvimento (ex: Aelin, Thiago, Barbara).
- **Clean Code**: Código que minimiza carga cognitiva, priorizando legibilidade extrema em detrimento de "otimizações prematuras".
