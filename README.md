# Jogo de Tiro ao Alvo

> Jogo de tiro ao alvo com placar — integração entre Godot, FastAPI e PostgreSQL.

---

## Sobre o Projeto

Projeto de estudo focado em integração entre um jogo e um banco de dados em tempo real.

O jogador entra com seu nome, joga uma rodada de cliques no alvo e sua pontuação é enviada automaticamente para uma API, que a armazena em um banco de dados PostgreSQL. Um leaderboard exibe os melhores jogadores.

---

## Stack

| Camada | Tecnologia |
|--------|-----------|
| Jogo | [Godot](https://godotengine.org/) |
| API | [FastAPI](https://fastapi.tiangolo.com/) (Python) |
| Banco de dados | [PostgreSQL](https://www.postgresql.org/) |
| Infraestrutura | [Docker](https://www.docker.com/) + Docker Compose |
| Interface visual do BD | [pgAdmin 4](https://www.pgadmin.org/) |

---

# NÃO ESQUEÇA DE CONFIGURAR O .env ANTES DE RODAR

Para isso, foi incluido um arquivo exemplo na root chamado ".env.example"

## Endpoints

| Método | Rota | Descrição |
|--------|------|-----------|
| `POST` | `/scores` | Salva pontuação do jogador |
| `GET` | `/scores/top` | Retorna o top 100 |

---

## Estrutura do Projeto

```
ProjetoJogoHTTP/
├── jogoAPI/
│   ├── main.py
│   ├── database.py
│   └── requirements.txt
├── projetoJogo/
│   ├── project.godot
│   └── ...
├── README.md
├── .env
└── docker-compose.yml
```

---

## Conclusão

Este foi apenas um pequeno projeto que eu queria realizar com um pouco do meu tempo livre, foi muito divertido pesquisando sobre diferentes formas que eu podia fazer com diferentes APIs REST. No começo queria fazer com o Spring Boot, mas acabei fazendo com o FastAPI do Python por ser mais facil e rapido. Eu gosto bastante da parte de desenvolver jogos, afinal sou apaixonado por jogos, e reconheço que para desenvolver um jogo é necessario trabalhar muito em racicionío. Esse jogo em específico não ficou muito bem trabalhado por ter sido um projeto curto e rápido, porém ja estou trabalhando para expandir um pouco mais além o projeto. 