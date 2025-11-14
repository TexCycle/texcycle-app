import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/app_bottom_nav.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/app_colors.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../auth/data/repositories/auth_repository.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 2;
  final _authService = AuthService();
  final _authRepository = AuthRepository();
  
  bool _loading = true;
  String _nome = '';
  String _email = '';
  String? _cpf;
  String? _telefone;
  String? _endereco;
  String? _tipoPerfil;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final token = await _authService.getToken();
      if (token != null) {
        // Tentar buscar dados completos da API
        try {
          final user = await _authRepository.getUserProfile(token);
          setState(() {
            _nome = user.nome;
            _email = user.email;
            _cpf = user.cpf;
            _telefone = user.telefone;
            _endereco = user.endereco;
            _tipoPerfil = user.tipoConta;
            _loading = false;
          });
          // Atualizar dados salvos localmente
          await _authService.saveAuthData(token: token, user: user);
        } catch (e) {
          // Se falhar, usar dados salvos localmente
          final userData = await _authService.getUserData();
          setState(() {
            _nome = userData['nome'] ?? '';
            _email = userData['email'] ?? '';
            _cpf = userData['cpf'];
            _telefone = userData['telefone'];
            _endereco = userData['endereco'];
            _tipoPerfil = userData['tipoPerfil'];
            _loading = false;
          });
        }
      } else {
        // Se não houver token, redirecionar para login
        if (mounted) {
          context.go('/sign-in');
        }
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar dados: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getTipoPerfilLabel() {
    switch (_tipoPerfil?.toLowerCase()) {
      case 'doador':
        return 'Doador';
      case 'coletor':
        return 'Coletor';
      case 'fornecedor':
        return 'Fornecedor de Resíduos';
      default:
        return _tipoPerfil ?? 'Usuário';
    }
  }

  Future<void> _handleLogout() async {
    await _authService.logout();
    if (mounted) {
      context.go('/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
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
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
                  Text(
                    _nome.isNotEmpty ? _nome : 'Usuário',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getTipoPerfilLabel(),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
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
            _buildInfoTile("Nome", _nome.isNotEmpty ? _nome : 'Não informado'),
            if (_cpf != null && _cpf!.isNotEmpty)
              _buildInfoTile("CPF/CNPJ", _cpf!),
            _buildInfoTile("E-mail", _email.isNotEmpty ? _email : 'Não informado'),
            if (_telefone != null && _telefone!.isNotEmpty)
              _buildInfoTile("Telefone", _telefone!),
            if (_endereco != null && _endereco!.isNotEmpty)
              _buildInfoTile("Endereço", _endereco!),

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
                onPressed: _handleLogout,
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

      bottomNavigationBar: AppBottomNavBar(currentIndex: _currentIndex),
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
