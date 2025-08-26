# ♻️ TexCycle Frontend

TexCycle é um aplicativo mobile desenvolvido em **Flutter** que conecta doadores de materiais têxteis a coletores, de forma simples e sustentável.  
A aplicação segue uma arquitetura **feature-first**, garantindo organização, escalabilidade e facilidade de manutenção.

---

## ✨ Funcionalidades atuais

- **Autenticação**
  - Tela de cadastro (Sign Up) com validação de campos.
  - Tela de login (Sign In) com e-mail/CPF-CNPJ + senha.

- **Navegação**
  - Gerenciada com **go_router**.
  - Footer (`AppBottomNavBar`) reutilizável em todas as páginas principais.

- **Mapa**
  - Exibição de mapa interativo com **flutter_map** (OpenStreetMap).
  - Localização atual do usuário com **geolocator**.
  - Possibilidade de adicionar marcadores ao tocar no mapa.
  - Campo de busca no header.

- **Chat**
  - Tela de chat com header customizado (avatar, nome do contato, menu).
  - Exibição de mensagens estilo bolha (usuário vs contato).
  - Campo de envio de mensagens com input arredondado e botão de microfone.

- **Conta**
  - Tela "Minha Conta" com informações detalhadas do usuário:
    - Tipo de conta (Doador / Coletador)
    - Nome, CPF/CNPJ, E-mail, Telefone, Endereço
  - Botão de editar perfil
  - Botão de logout

---

## 🗂️ Estrutura de pastas

```
lib/
 ├─ core/                # Configurações globais
 │   └─ config/
 │       ├─ app_colors.dart
 │       └─ theme.dart
 │
 ├─ shared/              # Componentes compartilhados
 │   └─ widgets/
 │       └─ app_bottom_nav.dart
 │
 └─ features/
     ├─ auth/
     │   └─ presentation/
     │       └─ pages/
     │           ├─ signup_page.dart
     │           └─ signin_page.dart
     │
     ├─ map/
     │   └─ presentation/
     │       └─ pages/
     │           └─ map_page.dart
     │
     ├─ chat/
     │   └─ presentation/
     │       └─ pages/
     │           └─ chat_page.dart
     │
     └─ account/
         └─ presentation/
             └─ pages/
                 └─ account_page.dart
```

---

## 🛠️ Tecnologias utilizadas

- [Flutter](https://flutter.dev/) 3.x
- [go_router](https://pub.dev/packages/go_router) – navegação
- [flutter_map](https://pub.dev/packages/flutter_map) – mapas com OpenStreetMap
- [geolocator](https://pub.dev/packages/geolocator) – localização do usuário
- [latlong2](https://pub.dev/packages/latlong2) – manipulação de coordenadas

---

## 🚀 Como rodar o projeto

### 1. Clonar o repositório
```bash
git clone https://github.com/TexCycle/texcycle-app.git
cd frontend
```

### 2. Instalar dependências
```bash
flutter pub get
```

### 3. Executar no emulador/dispositivo
```bash
flutter run
```

---

## 🌍 Rotas principais

| Rota         | Página         | Descrição                                  |
|--------------|----------------|---------------------------------------------|
| `/signup`    | SignUpPage     | Cadastro de novo usuário                   |
| `/signin`    | SignInPage     | Login com email/CPF-CNPJ                   |
| `/map`       | MapPage        | Tela inicial com mapa interativo           |
| `/chat`      | ChatPage       | Conversa entre doador e coletador          |
| `/myaccount` | AccountPage    | Detalhes da conta do usuário               |

---

## 📌 Próximos passos

- [ ] Integração com backend (API de autenticação, chat em tempo real, dados de usuários).  
- [ ] Implementar edição de perfil.  
- [ ] Salvar mensagens de chat via backend.  
- [ ] Melhorias de UI/UX.  
- [ ] Testes unitários e widget tests.  

---

## 📄 Licença
Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
