import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../../../core/config/app_colors.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

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
  final cepCtrl = TextEditingController();
  final logradouroCtrl = TextEditingController();
  final bairroCtrl = TextEditingController();
  final localidadeCtrl = TextEditingController();
  final ufCtrl = TextEditingController();
  final numeroCtrl = TextEditingController();
  final complementoCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final _authRepository = AuthRepository();
  
  bool termosAceitos = false;
  bool obscure = true;
  bool _loading = false;
  bool _buscandoCep = false;

  String? tipoConta;

  @override
  void dispose() {
    nomeCtrl.dispose();
    cpfCtrl.dispose();
    emailCtrl.dispose();
    telCtrl.dispose();
    cepCtrl.dispose();
    logradouroCtrl.dispose();
    bairroCtrl.dispose();
    localidadeCtrl.dispose();
    ufCtrl.dispose();
    numeroCtrl.dispose();
    complementoCtrl.dispose();
    senhaCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, color: AppColors.navyAccent) : null,
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _buscarCep(String cep) async {
    final digits = cep.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length != 8) return;

    setState(() => _buscandoCep = true);

    try {
      final response = await http.get(
        Uri.parse('https://viacep.com.br/ws/$digits/json/'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['erro'] == true) {
          if (mounted) {
            _showError('CEP não encontrado');
          }
          return;
        }

        if (mounted) {
          setState(() {
            logradouroCtrl.text = data['logradouro'] ?? '';
            bairroCtrl.text = data['bairro'] ?? '';
            localidadeCtrl.text = data['localidade'] ?? '';
            ufCtrl.text = data['uf'] ?? '';
          });
        }
      } else {
        if (mounted) {
          _showError('Erro ao buscar CEP');
        }
      }
    } catch (e) {
      if (mounted) {
        _showError('Erro ao buscar CEP: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _buscandoCep = false);
      }
    }
  }

  String _montarEndereco() {
    final parts = <String>[];
    
    // logradouro + número
    final logradouro = logradouroCtrl.text.trim();
    final numero = numeroCtrl.text.trim();
    if (logradouro.isNotEmpty) {
      if (numero.isNotEmpty) {
        parts.add('$logradouro, $numero');
      } else {
        parts.add(logradouro);
      }
    }
    
    // complemento (se houver)
    final complemento = complementoCtrl.text.trim();
    if (complemento.isNotEmpty) {
      parts.add(complemento);
    }
    
    // bairro
    final bairro = bairroCtrl.text.trim();
    if (bairro.isNotEmpty) {
      parts.add(bairro);
    }
    
    // localidade - uf
    final localidade = localidadeCtrl.text.trim();
    final uf = ufCtrl.text.trim();
    if (localidade.isNotEmpty && uf.isNotEmpty) {
      parts.add('$localidade - $uf');
    } else if (localidade.isNotEmpty) {
      parts.add(localidade);
    }
    
    // cep
    final cep = cepCtrl.text.trim();
    if (cep.isNotEmpty) {
      parts.add('CEP: $cep');
    }
    
    return parts.join(', ');
  }

  bool _isValidCPF(String cpf) {
    final digits = cpf.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length != 11) return false;
    
    if (RegExp(r'^(\d)\1{10}$').hasMatch(digits)) return false;
    
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(digits[i]) * (10 - i);
    }
    int digit1 = (sum * 10) % 11;
    if (digit1 == 10) digit1 = 0;
    if (digit1 != int.parse(digits[9])) return false;
    
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(digits[i]) * (11 - i);
    }
    int digit2 = (sum * 10) % 11;
    if (digit2 == 10) digit2 = 0;
    if (digit2 != int.parse(digits[10])) return false;
    
    return true;
  }

  bool _isValidCNPJ(String cnpj) {
    final digits = cnpj.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length != 14) return false;
    
    if (RegExp(r'^(\d)\1{13}$').hasMatch(digits)) return false;
    
    final weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(digits[i]) * weights1[i];
    }
    int digit1 = sum % 11;
    digit1 = digit1 < 2 ? 0 : 11 - digit1;
    if (digit1 != int.parse(digits[12])) return false;
    
    final weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    sum = 0;
    for (int i = 0; i < 13; i++) {
      sum += int.parse(digits[i]) * weights2[i];
    }
    int digit2 = sum % 11;
    digit2 = digit2 < 2 ? 0 : 11 - digit2;
    if (digit2 != int.parse(digits[13])) return false;
    
    return true;
  }

  Future<void> _onSubmit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!termosAceitos) {
      _showError('Você precisa aceitar os Termos de Uso');
      return;
    }

    setState(() => _loading = true);

    try {
      final enderecoCompleto = _montarEndereco();
      
      final request = SignUpRequest(
        nome: nomeCtrl.text.trim(),
        cpf: cpfCtrl.text.trim().isNotEmpty ? cpfCtrl.text.trim() : null,
        email: emailCtrl.text.trim(),
        telefone: telCtrl.text.trim(),
        endereco: enderecoCompleto.isEmpty ? null : enderecoCompleto,
        password: senhaCtrl.text,
        tipoConta: "doador",
      );

      await _authRepository.signUp(request);

      if (mounted) {
        // Salvar token e dados do usuário 
        // await SharedPreferences.getInstance().then((prefs) {
        //   prefs.setString('token', response.token);
        //   prefs.setString('user_id', response.user.id);
        // });

        _showSuccess('Conta criada com sucesso!');
        
        await Future.delayed(const Duration(milliseconds: 500));
        
        if (mounted) {
          context.go('/sign-in');
        }
      }
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Erro ao criar conta: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  18,
                                  16,
                                  8,
                                ),
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
                                          'CPF/CNPJ',
                                          icon: Icons.credit_card_outlined,
                                        ),
                                        validator: (v) {
                                          if (v == null || v.trim().isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          final value = v.trim();
                                          final digits = value.replaceAll(RegExp(r'[^\d]'), '');
                                          
                                          if (digits.length == 11) {
                                            if (!_isValidCPF(value)) {
                                              return 'CPF inválido';
                                            }
                                          } else if (digits.length == 14) {
                                            if (!_isValidCNPJ(value)) {
                                              return 'CNPJ inválido';
                                            }
                                          } else {
                                            return 'CPF deve ter 11 dígitos ou CNPJ deve ter 14 dígitos';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: emailCtrl,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: _dec(
                                          'E-mail',
                                          icon: Icons.alternate_email,
                                        ),
                                        validator: (v) {
                                          if (v == null || v.trim().isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          final email = v.trim();
                                          // verifica se tem @
                                          if (!email.contains('@')) {
                                            return 'E-mail deve conter @';
                                          }
                                          // verifica formato básico: texto@texto.texto
                                          final emailRegex = RegExp(
                                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                          );
                                          if (!emailRegex.hasMatch(email)) {
                                            return 'E-mail inválido';
                                          }
                                          return null;
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
                                        validator: (v) {
                                          if (v == null || v.trim().isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          final digits = v.replaceAll(RegExp(r'[^\d]'), '');
                                          if (digits.length == 10 && digits[2] == '9') {
                                            return 'Celular incompleto (falta um dígito)';
                                          }
                                          if (digits.length == 11 && digits[2] != '9') {
                                            return 'Telefone inválido';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: cepCtrl,
                                        keyboardType: TextInputType.number,
                                        decoration: _dec(
                                          'CEP',
                                          icon: Icons.pin_drop_outlined,
                                        ).copyWith(
                                          suffixIcon: _buscandoCep
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(12),
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                                  ),
                                                )
                                              : IconButton(
                                                  icon: const Icon(Icons.search),
                                                  onPressed: () {
                                                    if (cepCtrl.text.isNotEmpty) {
                                                      _buscarCep(cepCtrl.text);
                                                    }
                                                  },
                                                ),
                                        ),
                                        validator: (v) {
                                          if (v == null || v.trim().isEmpty) {
                                            return 'Obrigatório';
                                          }
                                          final cep = v.replaceAll(RegExp(r'[^\d]'), '');
                                          if (cep.length != 8) {
                                            return 'CEP deve ter 8 dígitos';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          final digits = value.replaceAll(RegExp(r'[^\d]'), '');
                                          if (digits.length == 8) {
                                            _buscarCep(digits);
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: logradouroCtrl,
                                        decoration: _dec(
                                          'Logradouro',
                                          icon: Icons.streetview_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              controller: numeroCtrl,
                                              keyboardType: TextInputType.number,
                                              decoration: _dec(
                                                'Número',
                                                icon: Icons.numbers_outlined,
                                              ),
                                              validator: (v) {
                                                if (v == null || v.trim().isEmpty) {
                                                  return 'Obrigatório';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            flex: 3,
                                            child: TextFormField(
                                              controller: complementoCtrl,
                                              decoration: _dec(
                                                'Complemento',
                                                icon: Icons.home_outlined,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: bairroCtrl,
                                        decoration: _dec(
                                          'Bairro',
                                          icon: Icons.location_city_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: TextFormField(
                                              controller: localidadeCtrl,
                                              decoration: _dec(
                                                'Cidade',
                                                icon: Icons.apartment_outlined,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          SizedBox(
                                            width: 120,
                                            child: TextFormField(
                                              controller: ufCtrl,
                                              decoration: _dec(
                                                'UF',
                                                icon: Icons.flag_outlined,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: senhaCtrl,
                                        obscureText: obscure,
                                        decoration: _dec(
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
                                            activeColor: cs.primary,
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      side: BorderSide(
                                        color: cs.primary,
                                        width: 1.4,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => context.go('/login'),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: cs.primary,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: termosAceitos ? _onSubmit : null,
                                    child: const Text(
                                      'Criar conta',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => context.go('/sign-in'),
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
        ),
        if (_loading) const AppLoading(),
      ],
    );
  }
}