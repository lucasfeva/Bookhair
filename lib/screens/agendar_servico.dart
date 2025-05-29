import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../components/barber_card_agenda.dart';
import '../components/barber_carousel_agenda.dart';
import '../components/button.dart';

class AgendarServicoScreen extends StatefulWidget {
  @override
  _AgendarServicoScreenState createState() => _AgendarServicoScreenState();
}

class _AgendarServicoScreenState extends State<AgendarServicoScreen> {
  final List<String> barbeiros = ['Qualquer fun.', 'Lucas', 'Buzatto', 'Bruno'];
  int barbeiroSelecionado = 0;

  DateTime mesSelecionado = DateTime(2025, 3);
  DateTime? dataSelecionada;
  final List<int> diasIndisponiveis = [14, 22, 28];

  // Horários base para qualquer barbeiro/dia, serão filtrados conforme seleção
  final List<String> horariosBase = [
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '17:00',
  ];
  List<String> horariosDisponiveis = [];
  String? horarioSelecionado;

  DateTime mesAtual = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime hoje = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR');
    mesSelecionado = mesAtual;

    _atualizarHorariosDisponiveis();
  }

  // Esta função atualiza os horários disponíveis com base no barbeiro e no dia selecionado
  void _atualizarHorariosDisponiveis() {
    if (dataSelecionada == null) {
      setState(() {
        horariosDisponiveis = horariosBase;
        horarioSelecionado = null;
      });
      return;
    }

    final barbeiro = barbeiros[barbeiroSelecionado];
    final data = dataSelecionada!;

    // BANCO DE DADOS AQUI

    List<String> horariosSimulados;

    if (barbeiroSelecionado == 0) {
      horariosSimulados = List.from(horariosBase);
      if (data.day == 15) {
        horariosSimulados.remove('11:00');
      }
    } else if (barbeiroSelecionado == 1) {
      horariosSimulados = horariosBase.where((h) => h != '10:00').toList();
      if (data.weekday == DateTime.saturday) {
        horariosSimulados =
            horariosSimulados.where((h) => h != '17:00').toList();
      }
    } else if (barbeiroSelecionado == 2) {
      horariosSimulados =
          horariosBase
              .where((h) => h == '14:00' || h == '15:00' || h == '17:00')
              .toList();
    } else {
      if (data.day == 20) {
        horariosSimulados = [];
      } else {
        horariosSimulados = List.from(horariosBase);
      }
    }

    setState(() {
      horariosDisponiveis = horariosSimulados;
      if (horarioSelecionado != null &&
          !horariosDisponiveis.contains(horarioSelecionado)) {
        horarioSelecionado = null;
      }
    });
  }

  List<DateTime> _getDiasDisponiveis(DateTime mes) {
    final primeiroDia = DateTime(mes.year, mes.month, 1);
    final ultimoDia = DateTime(mes.year, mes.month + 1, 0);
    return List.generate(
          ultimoDia.day,
          (index) => DateTime(mes.year, mes.month, index + 1),
        )
        .where(
          (dia) => !diasIndisponiveis.contains(dia.day) && !dia.isBefore(hoje),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final diasDisponiveis = _getDiasDisponiveis(mesSelecionado);
    final diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    final nomeMes = DateFormat.MMMM('pt_BR').format(mesSelecionado);

    bool podeVoltar = mesSelecionado.isAfter(mesAtual);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Center(child: Text('Faça sua reserva')),
        actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BarberCarouselAgenda(
              barbeiros: [
                {'nome': 'Qualquer fun...', 'imagem': null},
                {'nome': 'Lucas', 'imagem': 'images/barbeiro1.jpg'},
                {'nome': 'Carlos', 'imagem': 'images/barbeiro2.jpg'},
                {'nome': 'Lucca', 'imagem': 'images/barbeiro3.jpg'},
              ],
              barbeiroSelecionado: barbeiroSelecionado,
              onSelecionar: (index) {
                setState(() {
                  barbeiroSelecionado = index;
                  horarioSelecionado = null;
                  _atualizarHorariosDisponiveis();
                });
              },
            ),

            SizedBox(height: 16),
            Text('Calendário', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.arrow_left),
                  onPressed:
                      podeVoltar
                          ? () {
                            setState(() {
                              mesSelecionado = DateTime(
                                mesSelecionado.year,
                                mesSelecionado.month - 1,
                              );
                              dataSelecionada = null;
                              horarioSelecionado = null;
                              _atualizarHorariosDisponiveis();
                            });
                          }
                          : null,
                  color: podeVoltar ? Colors.black : Colors.grey,
                ),

                Text(
                  nomeMes[0].toUpperCase() + nomeMes.substring(1),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      mesSelecionado = DateTime(
                        mesSelecionado.year,
                        mesSelecionado.month + 1,
                      );
                      dataSelecionada = null;
                      horarioSelecionado = null;
                      _atualizarHorariosDisponiveis();
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  diasDaSemana
                      .map(
                        (dia) => Expanded(
                          child: Center(
                            child: Text(
                              dia,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemCount:
                    DateTime(
                      mesSelecionado.year,
                      mesSelecionado.month + 1,
                      0,
                    ).day,
                itemBuilder: (context, index) {
                  final dia = index + 1;
                  final estaDisponivel =
                      !diasIndisponiveis.contains(dia) &&
                      !DateTime(
                        mesSelecionado.year,
                        mesSelecionado.month,
                        dia,
                      ).isBefore(hoje);
                  final selecionado =
                      dataSelecionada?.day == dia &&
                      dataSelecionada?.month == mesSelecionado.month &&
                      dataSelecionada?.year == mesSelecionado.year;

                  return GestureDetector(
                    onTap:
                        estaDisponivel
                            ? () {
                              final novaData = DateTime(
                                mesSelecionado.year,
                                mesSelecionado.month,
                                dia,
                              );
                              setState(() {
                                dataSelecionada = novaData;
                                horarioSelecionado = null;
                                _atualizarHorariosDisponiveis();
                              });
                            }
                            : null,
                    child: Container(
                      decoration:
                          selecionado
                              ? BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              )
                              : null,
                      alignment: Alignment.center,
                      child: Text(
                        '$dia',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              estaDisponivel
                                  ? (selecionado
                                      ? Colors.white
                                      : Colors.black87)
                                  : Colors.grey[400],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),
            Text('Horários', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children:
                  horariosDisponiveis
                      .map(
                        (hora) => ChoiceChip(
                          label: Text(hora),
                          selected: horarioSelecionado == hora,
                          onSelected:
                              (_) => setState(() {
                                horarioSelecionado = hora;
                              }),
                        ),
                      )
                      .toList(),
            ),

            SizedBox(height: 16),

            if (dataSelecionada != null && horarioSelecionado != null)
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: BarberCardAgenda(
                      nomeServico: 'Cabelo + Barba',
                      preco: 'R\$ 50,00',
                      horario:
                          '$horarioSelecionado - ${_calcularFimHorario(horarioSelecionado!)}',
                      barbeiro: barbeiros[barbeiroSelecionado],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            SizedBox(
              width: double.infinity,
              child: Button(
                text: 'Reservar',
                variant: ButtonVariant.primary,
                onPressed:
                    (dataSelecionada != null && horarioSelecionado != null)
                        ? () {
                          final reserva = {
                            'barbeiro': barbeiros[barbeiroSelecionado],
                            'data': DateFormat(
                              'dd/MM/yyyy',
                            ).format(dataSelecionada!),
                            'horario': horarioSelecionado,
                          };
                          print('Reserva confirmada: \$reserva');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Reserva enviada com sucesso!'),
                            ),
                          );
                        }
                        : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _calcularFimHorario(String inicio) {
    final partes = inicio.split(':');
    final hora = int.parse(partes[0]);
    final minuto = int.parse(partes[1]);
    final fim = TimeOfDay(hour: hora + 1, minute: minuto);
    return fim.format(context);
  }
}
