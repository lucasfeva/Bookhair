# 📦 Components

Esta pasta contém os componentes reutilizáveis da interface do projeto.

---

## 🔘 Button

O componente `Button` é um botão customizado com três variações visuais: `primary`, `outline` e `ghost`. Ele aceita texto, ícones e permite personalizações futuras com facilidade.

### 🧩 Propriedades

- `text` _(String, obrigatório)_: texto exibido no botão.
- `variant` _(ButtonVariant, opcional)_: define o estilo visual. Padrão: `primary`.
- `onPressed` _(VoidCallback, opcional)_: função executada ao pressionar o botão.
- `icon` _(IconData, opcional)_: exibe um ícone ao lado do texto.

---

### 🎨 Variações disponíveis

- `ButtonVariant.primary`: botão com fundo `slate500` e texto branco.
- `ButtonVariant.outline`: botão com borda `slate500` e fundo transparente.
- `ButtonVariant.ghost`: botão sem borda, com fundo sutil e ícone/texto `slate500`.

---

### 🧪 Exemplo de uso

Use dentro do seu `build` da `HomeScreen`

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
