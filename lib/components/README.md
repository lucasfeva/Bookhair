# 📦 Components

Esta pasta contém os componentes reutilizáveis da interface do bookhair. Aqui voce encontra as propriedades disponiveis, variações caso possua e exemplos de uso.

---

## 🔘 Button

O componente `Button` é um botão customizado com três variações visuais: `primary`, `outline` e `ghost`. Ele aceita texto, ícones e permite personalizações futuras com facilidade.

### Propriedades

- `text` _(String, obrigatório)_: texto exibido no botão.
- `variant` _(ButtonVariant, opcional)_: define o estilo visual. Padrão: `primary`.
- `onPressed` _(VoidCallback, opcional)_: função executada ao pressionar o botão.
- `icon` _(IconData, opcional)_: exibe um ícone ao lado do texto.

---

### Variações disponíveis

- `ButtonVariant.primary`: botão com fundo `slate500` e texto branco.
- `ButtonVariant.outline`: botão com borda `slate500` e fundo transparente.
- `ButtonVariant.ghost`: botão sem borda, com fundo sutil e ícone/texto `slate500`.

---

### Exemplo de uso

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'Primario',
              variant: ButtonVariant.primary,
              onPressed: () {},
            ),
            SizedBox(height: 12),
            Button(
              text: 'Outline',
              variant: ButtonVariant.outline,
              onPressed: () {},
            ),
            SizedBox(height: 12),
            Button(
              text: '',
              variant: ButtonVariant.ghost,
              icon: Icons.message_outlined,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
```

---

## 🏷️ CustomInput

Campo de entrada reutilizável com variações para formulários e busca.

### Propriedades

- `label` _(String)_: rótulo acima do campo.
- `hintText` _(String)_: texto placeholder.
- `icon` _(IconData)_: ícone à esquerda.
- `actionIcon` _(IconData?)_: ícone opcional à direita (ex: mapa, mostrar senha).
- `type` _(InputType)_: `text`, `password`, `search`.
- `onActionPressed` _(VoidCallback?)_: função para o `actionIcon`.
- `controller` _(TextEditingController?)_: para controle externo do input.

### Estilos por tipo

- `search`: fundo `gray800`, sem borda, textos `gray400`.
- `text/password`: fundo transparente, borda `gray200`.

### Exemplos de uso

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInput(
              hintText: 'Pesquisar',
              icon: Icons.search,
              actionIcon: Icons.map,
              type: InputType.search,
              onActionPressed: () {
                print('Abrir mapa');
              },
            ),
            SizedBox(height: 12),
            CustomInput(
              label: 'Usuário',
              hintText: 'E-mail',
              icon: Icons.mail_outline,
            ),
            SizedBox(height: 12),
            CustomInput(
              label: 'Senha',
              hintText: 'Senha',
              icon: Icons.vpn_key_outlined,
              type: InputType.password,
            ),
          ],
        ),
      ),
    );
  }
```

---

## 💈 BarbershopCard

Cartão individual de barbearia com:

- Imagem com borda arredondada (12) e espaçamento (6)
- Nome da barbearia (bold, tamanho 16)
- Endereço com máximo de 2 linhas
- Nota exibida no canto superior da imagem
- Botão "Reservar" de largura total com `variant: outline`

### Propriedades

- `name`: nome da barbearia
- `address`: endereço exibido
- `imageUrl`: URL da imagem de capa
- `rating`: nota de avaliação
- `onReserve`: callback ao clicar em reservar

---

## 🧭 BarbershopCarousel

Lista horizontal de barbearias renderizadas com `BarbershopCard`.

### Propriedades

- `barbershops`: lista de objetos contendo `name`, `address`, `imageUrl`, `rating`

### Exemplo de uso

```dart
BarbershopCarousel(
  barbershops: [
    Barbershop(
      name: 'Vintage Barber',
      address: 'Av. São Sebastião, 357...',
      imageUrl: 'https://...',
      rating: 4.8,
    ),
  ],
)
```

---

## 📅 AppointmentCard

O `AppointmentCard` é um componente visual que exibe as informações de um agendamento com uma barbearia. Ele pode ser utilizado em duas variações:

- **Na Home**: exibe os botões "Cancelar" e "Mensagem" se o status for `"Confirmado"`.
- **Na tela de Agendamentos**: exibe apenas o status visual (ex: `"Concluído"`), sem botões.

---

### Propriedades

- `dateTime`: data e hora do agendamento (`DateTime`)
- `status`: texto que representa o status do agendamento (`"Confirmado"`, `"Concluído"`, `"Cancelado"`)
- `barbershopName`: nome da barbearia
- `address`: endereço do local
- `services`: descrição dos serviços realizados
- `imageUrl`: URL da imagem da barbearia
- `showActions` (opcional): se `true`, exibe os botões "Cancelar" e "Mensagem" (normalmente usado apenas se `status == "Confirmado"`)
- `onCancel` (opcional): função executada ao clicar no botão "Cancelar"
- `onMessage` (opcional): função executada ao clicar no botão "Mensagem"

---

### Estilos por status

- **Confirmado**: texto azul com fundo azul claro (10% de opacidade)
- **Concluído**: texto verde com fundo verde claro (10% de opacidade)
- **Cancelado**: texto vermelho com fundo vermelho claro (10% de opacidade)

---

### Exemplo de uso (com status visual)

```dart
AppointmentCard(
  dateTime: DateTime(2025, 2, 22, 10, 0),
  status: 'Concluído',
  barbershopName: 'Barbearia exemplo',
  address: '105 Av. 10a, Centro Rio Claro - SP',
  services: 'Corte de cabelo + Barba',
  imageUrl: 'https://link-da-imagem.jpg',
)
```

### Exemplo de uso (com botões de ação)

```dart
AppointmentCard(
  dateTime: DateTime(2025, 4, 03, 18, 30),
  status: 'Confirmado',
  barbershopName: 'Barbearia exemplo',
  address: '105 Av. 10a, Centro Rio Claro - SP',
  services: 'Corte de cabelo + Barba',
  imageUrl: 'https://link-da-imagem.jpg',
  showActions: true,
  onCancel: () => print('Cancelar agendamento'),
  onMessage: () => print('Abrir chat'),
)
```

### Observações

- A data e horário são exibidos no formato `22 Fev 2025 • 10:00`.
- Quando a imagem falhar ao carregar, um ícone padrão é mostrado com fundo cinza.
- Os botões de ação aparecem apenas se `showActions` for `true`.
