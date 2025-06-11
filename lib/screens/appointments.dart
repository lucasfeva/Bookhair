import 'package:bookhair/models/appointment_model.dart';
import 'package:bookhair/screens/meusagendamentos/widgets/appointment_card.dart';
import 'package:bookhair/services/appointment_service.dart';
import 'package:bookhair/services/service_locator.dart';
import 'package:bookhair/utils/user_data.dart';
import 'package:bookhair/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class MeusAgendamentosScreen extends StatefulWidget {
  const MeusAgendamentosScreen({super.key});

  @override
  State<MeusAgendamentosScreen> createState() => _MeusAgendamentosScreenState();
}

class _MeusAgendamentosScreenState extends State<MeusAgendamentosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AppointmentService _appointmentService = locator<AppointmentService>();

  List<AppointmentModel> _allAppointments = [];
  List<AppointmentModel> _upcomingAppointments = [];
  List<AppointmentModel> _completedAppointments = [];
  List<AppointmentModel> _cancelledAppointments = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Busca os agendamentos do usuário a partir da API.
  Future<void> _fetchAppointments() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userId = await UserData.getUserId();
      if (userId == null) {
        throw Exception(
          "Usuário não encontrado. Por favor, faça o login novamente.",
        );
      }

      final appointments = await _appointmentService.getUserAppointments(
        userId,
      );
      _allAppointments = appointments;

      _filterAppointments();
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceFirst("Exception: ", "");
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Filtra a lista de agendamentos usando os status da API.
  void _filterAppointments() {
    final now = DateTime.now();

    // Usando os status exatos do seu backend: 'Agendado', 'Concluido', 'Cancelado'
    _upcomingAppointments =
        _allAppointments
            .where((a) => a.status == 'Agendado' && a.date.isAfter(now))
            .toList();
    _upcomingAppointments.sort((a, b) => a.date.compareTo(b.date));

    _completedAppointments =
        _allAppointments.where((a) => a.status == 'Concluido').toList();
    _completedAppointments.sort((a, b) => b.date.compareTo(a.date));

    _cancelledAppointments =
        _allAppointments.where((a) => a.status == 'Cancelado').toList();
    _cancelledAppointments.sort((a, b) => b.date.compareTo(a.date));

    if (mounted) {
      setState(() {});
    }
  }

  /// Constrói a UI para cada aba, tratando os estados de loading, erro e lista vazia.
  Widget _buildAppointmentList(
    List<AppointmentModel> appointments,
    String emptyMessage,
  ) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.red.shade800),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: "Tentar Novamente",
                onPressed: _fetchAppointments,
              ),
            ],
          ),
        ),
      );
    }

    if (appointments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: Colors.grey.shade400,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                emptyMessage,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchAppointments,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return AppointmentCard(appointment: appointments[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Busca ainda não implementada.')),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.colorScheme.secondary,
          indicatorWeight: 3.0,
          labelColor: theme.colorScheme.onPrimary,
          unselectedLabelColor: theme.colorScheme.onPrimary.withOpacity(0.7),
          tabs: const [
            Tab(text: 'PRÓXIMOS'),
            Tab(text: 'CONCLUÍDOS'),
            Tab(text: 'CANCELADOS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentList(
            _upcomingAppointments,
            'Você não tem agendamentos futuros.',
          ),
          _buildAppointmentList(
            _completedAppointments,
            'Nenhum agendamento foi concluído ainda.',
          ),
          _buildAppointmentList(
            _cancelledAppointments,
            'Nenhum agendamento foi cancelado.',
          ),
        ],
      ),
    );
  }
}
