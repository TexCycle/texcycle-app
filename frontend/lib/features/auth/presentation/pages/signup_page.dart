import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nomeCtrl = TextEditingController();
  final cpfCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final telCtrl = TextEditingController();
  final enderecoCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool termosAceitos = false;
  bool obscure = true;

  @override
  void dispose() {
    nomeCtrl.dispose();
    cpfCtrl.dispose();
    emailCtrl.dispose();
    telCtrl.dispose();
    enderecoCtrl.dispose();
    senhaCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, color: AppColors.navyAccent) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: ConstrainedBox(
                // 100% da altura disponível (SafeArea já desconta status bar/notch)
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                // Centraliza vertical e horizontalmente quando houver espaço
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ------- Header -------
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.navy,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.person_add_alt_1,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Crie sua conta',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Junte-se ao ciclo têxtil e comece a doar ou coletar.',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ------- Form -------
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nomeCtrl,
                                    decoration: _dec(
                                      'Nome completo',
                                      icon: Icons.badge_outlined,
                                    ),
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                        ? 'Obrigatório'
                                        : null,
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: cpfCtrl,
                                    keyboardType: TextInputType.number,
                                    decoration: _dec(
                                      'CPF',
                                      icon: Icons.credit_card_outlined,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: emailCtrl,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: _dec(
                                      'E-mail',
                                      icon: Icons.alternate_email,
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Obrigatório';
                                      }
                                      final ok = RegExp(
                                        r'^[^@]+@[^@]+\.[^@]+',
                                      ).hasMatch(v);
                                      return ok ? null : 'E-mail inválido';
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: telCtrl,
                                    keyboardType: TextInputType.phone,
                                    decoration: _dec(
                                      'Celular',
                                      icon: Icons.phone_outlined,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: enderecoCtrl,
                                    decoration: _dec(
                                      'Endereço',
                                      icon: Icons.location_on_outlined,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: senhaCtrl,
                                    obscureText: obscure,
                                    decoration:
                                        _dec(
                                          'Senha',
                                          icon: Icons.lock_outline,
                                        ).copyWith(
                                          suffixIcon: IconButton(
                                            onPressed: () => setState(
                                              () => obscure = !obscure,
                                            ),
                                            icon: Icon(
                                              obscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                          ),
                                        ),
                                    validator: (v) =>
                                        (v == null || v.length < 6)
                                        ? 'Min. 6 caracteres'
                                        : null,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: termosAceitos,
                                        activeColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        onChanged: (v) => setState(
                                          () => termosAceitos = v ?? false,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Expanded(
                                        child: Wrap(
                                          children: [
                                            Text('Estou de acordo com os '),
                                            Text(
                                              'Termos de Uso',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(' e '),
                                            Text(
                                              'Política de Privacidade',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text('.'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ------- Ações -------
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  side: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    width: 1.4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => context.go('/login'),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => context.go('/map'),
                                child: const Text(
                                  'Criar conta',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => context.go('/signin'),
                          child: const Text("Já tem uma conta? Faça login"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
