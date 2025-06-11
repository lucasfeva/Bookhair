// import 'package:flutter/material.dart';
// import 'package:bookhair/models/appointment_model.dart';
// import 'package:bookhair/components/appointment_card.dart';
// import 'package:bookhair/services/appointment_service.dart';
// import 'package:bookhair/components/button.dart';
// import 'package:bookhair/data/constants/colors.dart';

// class MeusAgendamentosScreen extends StatefulWidget {
//   const MeusAgendamentosScreen({super.key});

//   @override
//   State<MeusAgendamentosScreen> createState() => _MeusAgendamentosScreenState();
// }

// class _MeusAgendamentosScreenState extends State<MeusAgendamentosScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final AppointmentService _appointmentService = locator<AppointmentService>();

//   List<AppointmentModel> _allAppointments = [];
//   List<AppointmentModel> _upcomingAppointments = [];
//   List<AppointmentModel> _completedAppointments = [];
//   List<AppointmentModel> _cancelledAppointments = [];

//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _fetchAppointments();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchAppointments() async {
//     if (!mounted) return;
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final userId = await UserData.getUserId();
//       if (userId == null) {
//         throw Exception(
//           "Usuário não encontrado. Por favor, faça o login novamente.",
//         );
//       }

//       final appointments = await _appointmentService.getUserAppointments(
//         userId,
//       );
//       _allAppointments = appointments;

//       _filterAppointments();
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorMessage = e.toString().replaceFirst("Exception: ", "");
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   void _filterAppointments() {
//     final now = DateTime.now();

//     _upcomingAppointments =
//         _allAppointments
//             .where((a) => a.status == 'Agendado' && a.date.isAfter(now))
//             .toList()
//           ..sort((a, b) => a.date.compareTo(b.date));

//     _completedAppointments =
//         _allAppointments.where((a) => a.status == 'Concluido').toList()
//           ..sort((a, b) => b.date.compareTo(a.date));

//     _cancelledAppointments =
//         _allAppointments.where((a) => a.status == 'Cancelado').toList()
//           ..sort((a, b) => b.date.compareTo(a.date));

//     if (mounted) setState(() {});
//   }

//   Widget _buildAppointmentList(
//     List<AppointmentModel> appointments,
//     String emptyMessage,
//   ) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (_errorMessage != null) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.error_outline, color: Colors.red, size: 48),
//               const SizedBox(height: 12),
//               Text(_errorMessage!, textAlign: TextAlign.center),
//               const SizedBox(height: 24),
//               Button(text: 'Tentar novamente', onPressed: _fetchAppointments),
//             ],
//           ),
//         ),
//       );
//     }

//     if (appointments.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(
//                 Icons.calendar_today_outlined,
//                 size: 48,
//                 color: AppColors.gray400,
//               ),
//               SizedBox(height: 12),
//               Text(
//                 'Nenhum agendamento encontrado.',
//                 style: TextStyle(color: AppColors.gray500),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return RefreshIndicator(
//       onRefresh: _fetchAppointments,
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//         itemCount: appointments.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: AppointmentCard(appointment: appointments[index]),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Meus agendamentos'),
//         centerTitle: true,
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: AppColors.gray900,
//           unselectedLabelColor: AppColors.gray400,
//           indicatorColor: AppColors.slate500,
//           tabs: const [
//             Tab(text: 'Próximos'),
//             Tab(text: 'Concluídos'),
//             Tab(text: 'Cancelados'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildAppointmentList(
//             _upcomingAppointments,
//             'Você não tem agendamentos futuros.',
//           ),
//           _buildAppointmentList(
//             _completedAppointments,
//             'Nenhum agendamento foi concluído ainda.',
//           ),
//           _buildAppointmentList(
//             _cancelledAppointments,
//             'Nenhum agendamento foi cancelado.',
//           ),
//         ],
//       ),
//     );
//   }
// }
