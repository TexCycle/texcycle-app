# TexCycle Frontend

Frontend do projeto **TexCycle**, desenvolvido em **Flutter**, responsável pela interface de doadores e coletores no ciclo têxtil.  
O app possui telas de autenticação, cadastro, mapa interativo, chats, gerenciamento de conta e funcionalidades específicas para cada tipo de usuário (**doador** e **coletador**).

---

## 📂 Estrutura do Projeto

```
lib/
├── core/
│   ├── config/
│   │   ├── app_colors.dart        # Definição da paleta de cores
│   │   ├── theme.dart             # Tema global do aplicativo
│   │   ├── user_session.dart      # Sessão do usuário (ex: role coletador/doador)
│   │
│   └── routing/
│       └── app_router.dart        # Definição das rotas com GoRouter
│
├── features/
│   ├── account/
│   │   └── presentation/
│   │       └── account_page.dart  # Tela de "Minha Conta"
│   │
│   ├── auth/                      # (login e cadastro futuramente)
│   │
│   ├── chat/
│   │   └── presentation/
│   │       ├── chat_list_page.dart # Lista de conversas
│   │       └── chat_page.dart      # Tela de chat individual
│   │
│   ├── collector/
│   │   └── presentation/
│   │       └── collector_page.dart # Tela de coletas disponíveis/histórico
│   │
│   ├── donor/
│   │   └── presentation/
│   │       └── donor_info_page.dart # Cadastro de doações (materiais têxteis)
│   │
│   └── map/
│       └── presentation/
│           └── map_page.dart      # Tela principal com mapa interativo
│
├── shared/
│   └── widgets/
│       ├── app_bottom_nav.dart    # Bottom navigation bar reutilizável
│       ├── app_button.dart        # Botão customizado
│       └── search_header.dart     # Header de busca reutilizável
│
├── app.dart                       # Inicialização principal
└── main.dart                      # Entry point do Flutter
```

---

## 🚀 Tecnologias Utilizadas

- **Flutter** (Framework principal)
- **GoRouter** (Gerenciamento de rotas)
- **Flutter Map + OpenStreetMap** (Mapa interativo sem necessidade de API Key)
- **Geolocator** (Geolocalização do usuário)
- **Arquitetura Modular** (Divisão clara entre `core`, `features` e `shared`)

---

## 📱 Funcionalidades Atuais

- Cadastro de usuários (**doador** e **coletador**)
- Login e redirecionamento para rotas diferentes por tipo de usuário
- Mapa interativo com markers e localização do usuário
- Cadastro de doações de materiais têxteis (tipo, quantidade, peso, endereço)
- Listagem de coletas disponíveis para coletores + histórico de coletas
- Chat individual + lista de chats
- Página de conta com dados do usuário
- Navegação inferior reutilizável (**BottomNav**)

---

## ▶️ Como Rodar o Projeto

1. Clone este repositório:
   ```bash
   git clone https://github.com/TexCycle/texcycle-app.git
   cd texcycle-frontend
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Rode o app:
   ```bash
   flutter run
   ```

---

## 🔮 Próximos Passos

- Integração com backend (API REST/GraphQL)
- Autenticação real (login/cadastro persistente)
- Integração com Firebase ou outro sistema de notificações
- Melhorias no sistema de chat (tempo real)

---

## 👥 Autores

Projeto desenvolvido por **Eduardo Farias Camargo** e colaboradores.  
