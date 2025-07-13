# MovieBuddy - App Flutter para Filmes com TMDB

## Descrição

MovieBuddy é um aplicativo Flutter para exibir filmes populares, lançamentos e permitir busca utilizando a API do TMDB (The Movie Database).
O app permite ao usuário favoritar filmes e armazená-los localmente no dispositivo usando SQLite via Floor.

---

## Funcionalidades

* Login simulado (qualquer credencial avança para Home)
* Tela Home com 3 seções:

  * Filmes Favoritos (salvos localmente)
  * Filmes em Alta (popularidade TMDB)
  * Lançamentos Recentes (now playing TMDB)
* Tela Search para busca dinâmica de filmes na API TMDB
* Tela Details exibindo detalhes do filme selecionado
* Favoritar/desfavoritar filmes com ícone de coração preenchido/contornado
* Armazenamento local dos favoritos com Floor (SQLite)
* Internacionalização básica (Português e Inglês)
* Arquitetura MVVM com ViewModels, Repository e Provider
* Boas práticas recomendadas para Flutter mobile

---

## Tecnologias e Pacotes Utilizados

* Flutter & Dart
* Provider (gerenciamento de estado)
* HTTP (requisições à API TMDB)
* Floor (SQLite para armazenamento local)
* build\_runner & floor\_generator (geração de código Floor)
* intl e flutter\_localizations (internacionalização)

---

## Como Rodar

1. Clone este repositório:

```bash
git clone https://github.com/seu-usuario/moviebuddy.git
cd moviebuddy
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Configure sua API Key do TMDB:
   No arquivo `main.dart`, substitua `'SUA_API_KEY_AQUI'` pela sua chave obtida em [TMDB API](https://www.themoviedb.org/settings/api).

4. Gere os arquivos do Floor:

```bash
flutter pub run build_runner build
```

5. Rode o app:

```bash
flutter run
```

---

## Estrutura do Projeto

* `/lib`

  * `main.dart` — ponto de entrada do app e injeção dos Providers
  * `/data`

    * `/models` — modelos de dados (ex: Movie)
    * `/services` — integração com API TMDB
    * `/repository` — acesso à API e banco local
  * `/db` — código Floor (entidades, DAO, database)
  * `/viewmodel` — ViewModels para lógica de UI e estado
  * `/ui` — telas: login, home, search, details
  * `/l10n` — arquivos de tradução (intl)

---

## Internacionalização

O app oferece suporte para Português e Inglês.
Todas as strings são traduzidas usando o pacote `intl` e o sistema de localização Flutter.

---

## Próximos Passos / Melhorias

* Implementar tela de favoritos completa com gerenciamento avançado
* Melhorar tratamentos de erro e loading
* Adicionar testes unitários e widget tests
* Adicionar suporte para mais idiomas
* Melhorar a UI com animações e temas customizados
* Cache de imagens e dados para melhor performance
