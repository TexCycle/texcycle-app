# TexCycle Frontend

TexCycle é um aplicativo desenvolvido em **Flutter** com o objetivo de conectar doadores e coletores de materiais têxteis.  
O projeto foi estruturado para manter escalabilidade, reutilização de componentes e facilidade de manutenção.

---

## 📂 Estrutura de Pastas

```
lib/
├── core/
│   ├── config/
│   │   ├── app_colors.dart       # Paleta de cores
│   │   ├── theme.dart            # Tema global do app
│   │   ├── router.dart           # Definições de rotas (go_router)
│   │   └── user_session.dart     # Sessão do usuário (role: coletador/doador)
│
├── features/
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   │   ├── sign_in_page.dart
│   │   │   │   └── sign_up_page.dart
│   │   │   └── widgets/          # Widgets específicos de autenticação
│   │
│   ├── map/
│   │   └── presentation/
│   │       └── pages/
│   │           └── map_page.dart
│   │
│   ├── chat/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── chat_list_page.dart
│   │       │   └── chat_page.dart
│   │       └── widgets/          # Componentes de chat
│   │
│   ├── account/
│   │   └── presentation/
│   │       └── pages/
│   │           └── account_page.dart
│   │
│   ├── donor/
│   │   └── presentation/
│   │       └── pages/
│   │           └── donor_info_page.dart
│   │
│   ├── collector/
│   │   └── presentation/
│   │       └── pages/
│   │           └── collector_page.dart
│   │
│   └── services/
│       └── presentation/
│           └── pages/
│               └── services_page.dart
│
└── shared/
    └── widgets/
        ├── app_bottom_nav.dart   # BottomNavigationBar reutilizável
        └── app_search_header.dart# Header reutilizável
```

---

## ✨ Funcionalidades

- **Autenticação**: Cadastro e login de usuários (doador ou coletador).
- **Mapa**: Visualização interativa (OpenStreetMap) com pins e localização do usuário.
- **Doações**: Cadastro de materiais têxteis (tipo, quantidade, peso, endereço).
- **Coletas**: Lista de doações disponíveis para coletores e histórico de coletas realizadas.
- **Chat**: Conversa entre doadores e coletores.
- **Minha Conta**: Visualização dos dados de perfil e logout.
- **Navegação Reutilizável**: `AppBottomNavBar` configurada dinamicamente conforme o role do usuário.
- **Header Reutilizável**: `AppSearchHeader` usado em múltiplas telas.

---

## 🚀 Tecnologias

- [Flutter](https://flutter.dev/)  
- [Dart](https://dart.dev/)  
- [go_router](https://pub.dev/packages/go_router) - Navegação  
- [flutter_map](https://pub.dev/packages/flutter_map) - Integração com mapas  
- [geolocator](https://pub.dev/packages/geolocator) - Localização do usuário  

---

## ▶️ Executando o Projeto

1. Clone este repositório:
   ```bash
   git clone https://github.com/TexCycle/texcycle-app.git
   cd texcycle-frontend
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Execute o app:
   ```bash
   flutter run
   ```

---

## 🧩 Rotas Principais

- `/signin` → Tela de login  
- `/signup` → Tela de cadastro  
- `/map` → Tela do mapa  
- `/donor-info` → Cadastro de doação  
- `/collector` → Página de coletas (com histórico e ativas)  
- `/chat-list` → Lista de chats  
- `/chat/:id` → Conversa individual  
- `/my-account` → Perfil do usuário  

---

## 👥 Papéis

- **Doador**: cadastra materiais têxteis para coleta.  
- **Coletador**: visualiza e aceita coletas disponíveis, além de acompanhar seu histórico.  

---

## 📌 Próximos Passos

- Integração com backend (API REST ou Firebase).  
- Autenticação real de usuários.  
- Persistência de dados de doações e coletas.  
- Notificações push para novas mensagens e coletas.  

---

## 📄 Licença

Este projeto é apenas para fins educacionais e de prototipação.  
