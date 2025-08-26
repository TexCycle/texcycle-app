import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/app_colors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        title: const Text(
          "Minha Conta",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              color: AppColors.navy,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person, color: Colors.white, size: 42),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Pedro Miguel Radwanski",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Doador",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // TODO: ação editar perfil
                    },
                    child: const Text("Editar Perfil"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            _buildInfoTile("Nome", "Pedro Miguel Radwanski"),
            _buildInfoTile("CPF", "123.456.789-00"),
            _buildInfoTile("E-mail", "pedro.miguel@email.com"),
            _buildInfoTile("Telefone", "(41) 99999-9999"),
            _buildInfoTile("Endereço", "Rua XV de Novembro, 123 - Curitiba/PR"),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.go('/signin');
                },
                icon: const Icon(Icons.exit_to_app),
                label: const Text(
                  "Sair",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
          if (i == 0) context.go('/map');
          if (i == 1) context.go('/services');
          if (i == 2) context.go('/activity');
          if (i == 3) context.go('/account');
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.navy,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Conta',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.info_outline, color: Colors.grey),
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(value, style: const TextStyle(color: Colors.black87)),
        ),
        const Divider(height: 1, thickness: 0.5),
      ],
    );
  }
}
