# PayApp

Controle financeiro pessoal: cadastre suas despesas e receitas recorrentes,
agrupe-as por categoria e feche cada mês como um "pagamento" — um livro-caixa
mensal que soma o que entrou e o que saiu, e mostra o saldo em relação ao
salário configurado. Um dashboard traz a visão geral do mês (saldo, total
pago, despesas por categoria, histórico dos últimos 6 meses).

## Domínio

- **Configuração** — o salário do usuário, base para o cálculo de saldo.
- **Categoria** — agrupa despesas e receitas (ex.: "Casa", "Saúde").
- **Despesa** / **Receita** — itens recorrentes ou pontuais, vinculados a uma categoria.
- **Pagamento** — o fechamento de um mês: agrega várias despesas e receitas
  (via `expense_payments`/`revenue_payments`) e registra a data em que cada
  item foi efetivamente pago/recebido.

Cada usuário só enxerga os próprios dados (autenticação via Devise).

## Stack

- **Ruby 4.0** / **Rails 8.1**, banco **PostgreSQL**.
- **Hotwire** (Turbo + Stimulus) no lugar de jQuery/Turbolinks — navegação
  SPA-like e interatividade sem escrever JS a mais.
- **Tailwind CSS v4** (via `tailwindcss-rails`, CLI standalone, sem Node) para
  o design system da aplicação, com dark mode.
- **Chart.js** para os gráficos do dashboard.
- **Importmap** para gerenciar JS via ESM, sem bundler/Node.
- **Devise** para autenticação.
- **Docker Compose** para o ambiente de desenvolvimento.

## Rodando o projeto

Todo o desenvolvimento acontece dentro do Docker Compose (o Ruby instalado
localmente não precisa bater com a versão do projeto):

```bash
docker compose up -d
```

O `entrypoint.sh` cria o banco e roda as migrations automaticamente. A
aplicação sobe em [http://localhost:3000](http://localhost:3000).

### Comandos úteis

```bash
# Console Rails
docker compose exec web bin/rails console

# Rodar a suíte de testes
docker compose exec -e RAILS_ENV=test -e DATABASE_URL=postgresql://postgres:password@db/payapp_test web bin/rails test

# Zeitwerk (autoload) check
docker compose exec web bin/rails zeitwerk:check

# Rebuild do CSS (Tailwind)
docker compose exec web bin/rails tailwindcss:build
```

Em desenvolvimento, o Tailwind é recompilado automaticamente por
`bin/rails tailwindcss:watch` (ver `Procfile.dev`, usado por `bin/dev` fora do
Docker).
