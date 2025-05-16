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
