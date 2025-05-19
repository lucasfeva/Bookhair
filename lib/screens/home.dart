import 'package:flutter/material.dart';
import '../components/home_top_bar.dart';
import '../components/service_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141416),

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () => Navigator.pushNamed(context, '/perfil'),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeTopBar(),
            _WhiteBody(),
          ],
        ),
      ),
    );
  }
}

class _WhiteBody extends StatelessWidget {
  const _WhiteBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: const [
          SizedBox(height: 20),
          ServiceCategories(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
