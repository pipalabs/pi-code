---
title: Contrato de API - [Nome da Funcionalidade]
module: [Identificador do Módulo]
tags: [api, contrato, tecnico]
last_updated: [Data]
type: api
---

# Contrato de API: [Nome da Funcionalidade]

## [Nome do Endpoint]

### Definição

- **Verbo HTTP**: `[GET|POST|PUT|DELETE|PATCH]`
- **URL**: `/api/[rota]`
- **Descrição**: [O que este endpoint faz]

### Requisição (Request)

#### Cabeçalhos (Headers)

- `Authorization`: Bearer [token]

#### Parâmetros de URL / Query String

| Parâmetro | Tipo   | Obrigatório | Descrição   |
| :-------- | :----- | :---------- | :---------- |
| [nome]    | [tipo] | [sim/não]   | [descrição] |

#### Corpo da Requisição (Body)

```json
{
  "campo": "valor"
}
```

### Resposta (Response)

#### Sucesso (2xx)

**Código**: `[Ex: 200 OK / 201 Created]`

```json
{
  "id": "uuid",
  "status": "sucesso"
}
```

#### Erros Comuns (4xx/5xx)

| Código | Mensagem/Erro | Motivo   |
| :----- | :------------ | :------- |
| 400    | `BAD_REQUEST` | [Motivo] |
| 404    | `NOT_FOUND`   | [Motivo] |
