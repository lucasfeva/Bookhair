# BookHair 💈📱

O **BookHair** é um aplicativo mobile desenvolvido em Flutter com o objetivo de facilitar o agendamento de serviços em barbearias. Utilizando o UI Kit [GetWidget](https://pub.dev/packages/getwidget), o app entrega uma experiência visual moderna, intuitiva e responsiva tanto para clientes quanto para barbearias.

---

## 📲 Visão Geral

O BookHair conecta clientes a barbearias cadastradas, permitindo:

- Agendamento de serviços de forma rápida e prática;
- Visualização dos serviços oferecidos;
- Acompanhamento dos agendamentos;
- Gestão eficiente por parte das barbearias.

---

## 🎯 Objetivos

- Facilitar o agendamento de serviços de beleza;
- Proporcionar uma interface simples e objetiva para os usuários;
- Ajudar as barbearias na organização de sua agenda e equipe.

---

## 👥 Público-Alvo

- **Clientes**: interessados em agendar serviços como corte de cabelo, barba etc.
- **Barbearias**: estabelecimentos que buscam uma solução digital para organizar sua rotina e atender melhor seus clientes.

---

## 🔑 Funcionalidades

### Para Clientes:
- Cadastro e login;
- Busca por barbearias via nome, localização ou serviço;
- Visualização de serviços, profissionais e avaliações;
- Agendamento com seleção de profissional e horário;
- Histórico de agendamentos: futuros, concluídos e cancelados;
- Mapa interativo com barbearias próximas.

### Para Barbearias:
- Cadastro do estabelecimento, equipe e serviços;
- Gerenciamento da agenda e dos profissionais;
- Tela de administração completa;
- Dashboard com estatísticas mensais e exportação de relatórios (PDF/CSV).

---

## 🚧 MVP (Produto Mínimo Viável)

A versão inicial do BookHair contará com:

- Cadastro e login;
- Cadastro de barbearias e serviços;
- Agendamento básico com seleção de horário;
- Lista de agendamentos;
- Busca de barbearias.

---

## 🛠️ Tecnologias

- Flutter
- Dart
- GetWidget (UI Kit)
- Google Maps API (para busca geográfica - futuro)
- Firebase (autenticação e banco de dados - futuro)

---

## 🚀 Como iniciar o projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/bookhair.git
   cd bookhair
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
2. Execute o app:
   ```bash
   flutter run
   ```
## 📁 Estrutura do Projeto
   ```bash
   lib/
   ├── main.dart
   ├── data/
   ├── screens/
   │   └── home_screen.dart
   ├── components/
   │   └── custom_button.dart
   ```
