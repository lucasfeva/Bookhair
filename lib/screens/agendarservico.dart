import 'package:bookhair/models/barber.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/barber_card.dart';
import '../components/barber_carousel.dart';
import '../components/button.dart';

Barber barberFromJson(Map<String, dynamic> json) {
  return Barber(
    name: json['nome'] ?? '',
    role: json['role'],
    imageUrl: json['imageUrl'],
    id: json['id'] != null ? int.parse(json['id'].toString()) : null,
    barbeariaId:
        json['barbearia_id'] != null
            ? int.parse(json['barbearia_id'].toString())
            : null,
  );
}

class AgendarServicoScreen extends StatefulWidget {
  final String token;
  final int serviceId;
  final String serviceName;
  const AgendarServicoScreen({
    Key? key,
    required this.token,
    required this.serviceId,
    required this.serviceName,
  }) : super(key: key);

  @override
  _AgendarServicoScreenState createState() => _AgendarServicoScreenState();
}

class _AgendarServicoScreenState extends State<AgendarServicoScreen> {
  List<Barber> barbeiros = [];
  bool carregando = true;
  Barber? barbeiroSelecionado;
  DateTime mesSelecionado = DateTime.now();
  DateTime? dataSelecionada;
  String? horarioSelecionado;
  List<String> horariosDisponiveis = [];
  String? nomeBarbearia;
  String? nomeServico;
  String? servicoIdSelecionado;
  List<Map<String, dynamic>> servicosDisponiveis = [];
  Map<String, dynamic>? agendamentoRealizado;

  String get token => widget.token;
  int get serviceId => widget.serviceId;
  String get serviceName => widget.serviceName;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR');
    buscarBarbeiros();
  }

  Future<void> buscarBarbeiros() async {
    try {
      final response = await http.get(
        Uri.parse('http://bookhair.calcularnota.com.br/api/v1/profissionais'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List dados = json.decode(response.body);
        setState(() {
          barbeiros = dados.map<Barber>((e) => barberFromJson(e)).toList();
          carregando = false;
        });
      } else {
        setState(() {
          carregando = false;
          barbeiros = [];
        });
      }
    } catch (e) {
      setState(() {
        carregando = false;
        barbeiros = [];
      });
    }
  }

  Future<void> buscarHorariosDisponiveis() async {
    if (dataSelecionada == null || barbeiroSelecionado == null) return;

    final identificador =
        barbeiroSelecionado!.id?.toString() ?? barbeiroSelecionado!.name;
    final String dataFormatada = DateFormat(
      'yyyy-MM-dd',
    ).format(dataSelecionada!);

    final url = Uri.parse(
      'http://bookhair.calcularnota.com.br/api/v1/profissionais/${Uri.encodeComponent(identificador)}/horarios?data=$dataFormatada',
    );

    setState(() {
      horariosDisponiveis = [];
    });

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List &&
            data.isNotEmpty &&
            data.first is Map &&
            data.first.containsKey('data_hora')) {
          setState(() {
            horariosDisponiveis =
                data
                    .map<String>((e) {
                      final dataHora = e['data_hora'].toString();
                      final match = RegExp(
                        r'\b(\d{2}:\d{2})\b',
                      ).firstMatch(dataHora);
                      return match != null ? match.group(0)! : dataHora;
                    })
                    .toSet()
                    .toList();
          });
        } else if (data is List) {
          setState(() {
            horariosDisponiveis = data.map((e) => e.toString()).toList();
          });
        } else if (data is Map && data['horarios'] is List) {
          final horarios = data['horarios'] as List;
          if (horarios.isNotEmpty &&
              horarios.first is Map &&
              horarios.first.containsKey('data_hora')) {
            setState(() {
              horariosDisponiveis =
                  horarios
                      .map<String>((e) {
                        final dataHora = e['data_hora'].toString();
                        final match = RegExp(
                          r'\b(\d{2}:\d{2})\b',
                        ).firstMatch(dataHora);
                        return match != null ? match.group(0)! : dataHora;
                      })
                      .toSet()
                      .toList();
            });
          } else {
            setState(() {
              horariosDisponiveis = horarios.map((e) => e.toString()).toList();
            });
          }
        } else {
          setState(() {
            horariosDisponiveis = [];
          });
        }
      } else {
        setState(() {
          horariosDisponiveis = [];
        });
      }
    } catch (e) {
      setState(() {
        horariosDisponiveis = [];
      });
    }
  }

  Future<void> realizarAgendamento() async {
    if (dataSelecionada == null ||
        barbeiroSelecionado == null ||
        horarioSelecionado == null ||
        barbeiroSelecionado!.id == null ||
        barbeiroSelecionado!.barbeariaId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione todas as informações necessárias')),
      );
      return;
    }

    try {
      // Combinar data e horário
      final dataHora = DateTime.parse(
        '${DateFormat('yyyy-MM-dd').format(dataSelecionada!)} ${horarioSelecionado}:00',
      );

      final response = await http.post(
        Uri.parse('http://bookhair.calcularnota.com.br/api/v1/agendamentos'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'profissional_id': barbeiroSelecionado!.id,
          'servico_id': serviceId,
          'barbearia_id': barbeiroSelecionado!.barbeariaId,
          'data_hora': DateFormat('yyyy-MM-dd HH:mm:ss').format(dataHora),
          'status': 'agendado',
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          agendamentoRealizado = {
            'profissional': barbeiroSelecionado!.name,
            'servico': serviceName,
            'data': DateFormat('dd/MM/yyyy').format(dataSelecionada!),
            'hora': horarioSelecionado,
          };
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Agendamento realizado com sucesso!')),
        );
        print('Redirecionando para /agendamentos');
        Navigator.pushReplacementNamed(context, '/agendamentos');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao realizar agendamento: ${response.body}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar agendamento: $e')),
      );
    }
  }

  Future<void> buscarInfoServico() async {
    if (barbeiroSelecionado == null) return;
    final identificador =
        barbeiroSelecionado!.id?.toString() ?? barbeiroSelecionado!.name;
    final response = await http.get(
      Uri.parse(
        'http://bookhair.calcularnota.com.br/api/v1/profissionais/${Uri.encodeComponent(identificador)}/servicos',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map) {
        setState(() {
          nomeBarbearia = data['nomeBarbearia'];
          nomeServico = data['nomeServico'];
        });
      }
    }
  }

  Future<void> buscarServicosDoBarbeiro() async {
    if (barbeiroSelecionado == null) return;
    final identificador =
        barbeiroSelecionado!.id?.toString() ?? barbeiroSelecionado!.name;
    final response = await http.get(
      Uri.parse(
        'http://bookhair.calcularnota.com.br/api/v1/profissionais/${Uri.encodeComponent(identificador)}/servicos',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        setState(() {
          servicosDisponiveis = List<Map<String, dynamic>>.from(data);
          servicoIdSelecionado = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agendar Serviço')),
      body:
          carregando
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Escolha um barbeiro:'),
                    SizedBox(height: 8),
                    BarberCarousel(
                      barbers: barbeiros,
                      variant: BarberCardVariant.selectable,
                      onSelect: (barber) {
                        setState(() {
                          barbeiroSelecionado = barber;
                          dataSelecionada = null;
                          horarioSelecionado = null;
                          horariosDisponiveis = [];
                          servicoIdSelecionado = null;
                          nomeServico = null;
                          servicosDisponiveis = [];
                        });
                        buscarServicosDoBarbeiro();
                      },
                    ),
                    SizedBox(height: 24),
                    Text('Selecione uma data:'),
                    SizedBox(height: 8),
                    Text(
                      'Calendário',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      child: TableCalendar(
                        locale: 'pt_BR',
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(Duration(days: 30)),
                        focusedDay: dataSelecionada ?? DateTime.now(),
                        selectedDayPredicate:
                            (day) =>
                                dataSelecionada != null &&
                                day.year == dataSelecionada!.year &&
                                day.month == dataSelecionada!.month &&
                                day.day == dataSelecionada!.day,
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            dataSelecionada = selectedDay;
                            horarioSelecionado = null;
                          });
                          buscarHorariosDisponiveis();
                        },
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          todayDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          defaultTextStyle: TextStyle(color: Colors.grey[800]),
                          weekendTextStyle: TextStyle(color: Colors.grey[500]),
                          outsideTextStyle: TextStyle(color: Colors.grey[300]),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.grey[700],
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[700],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                          weekendStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(),
                      ),
                    ),
                    if (dataSelecionada != null) ...[
                      SizedBox(height: 24),
                      Text('Horários disponíveis:'),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            horariosDisponiveis.map((horario) {
                              return ChoiceChip(
                                label: Text(horario),
                                selected: horario == horarioSelecionado,
                                onSelected: (selected) {
                                  setState(() {
                                    horarioSelecionado =
                                        selected ? horario : null;
                                  });
                                },
                              );
                            }).toList(),
                      ),
                    ],
                    if (barbeiroSelecionado != null) ...[
                      // Não exibir mais o BarberCard
                    ],
                    if (serviceName.isNotEmpty) ...[
                      SizedBox(height: 24),
                      Text(
                        'Serviço selecionado: $serviceName',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    if (agendamentoRealizado != null) ...[
                      SizedBox(height: 24),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Agendamento Confirmado!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Profissional: ${agendamentoRealizado!['profissional']}',
                              ),
                              Text(
                                'Serviço: ${agendamentoRealizado!['servico']}',
                              ),
                              Text('Data: ${agendamentoRealizado!['data']}'),
                              Text('Horário: ${agendamentoRealizado!['hora']}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 24),
                    Button(
                      text: 'Agendar',
                      onPressed:
                          barbeiroSelecionado != null &&
                                  dataSelecionada != null &&
                                  horarioSelecionado != null
                              ? realizarAgendamento
                              : null,
                      variant: ButtonVariant.primary,
                    ),
                  ],
                ),
              ),
    );
  }
}
