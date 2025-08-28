import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/search_header.dart';
import 'package:frontend/shared/widgets/app_bottom_nav.dart';
import '../../../../../core/config/app_colors.dart';

class DonorInfoPage extends StatefulWidget {
  const DonorInfoPage({super.key});

  @override
  State<DonorInfoPage> createState() => _DonorInfoPageState();
}

class _DonorInfoPageState extends State<DonorInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final tipoCtrl = TextEditingController();
  final metrosCtrl = TextEditingController();
  final kgCtrl = TextEditingController();
  final enderecoCtrl = TextEditingController();

  int _currentIndex = 2;

  @override
  void dispose() {
    tipoCtrl.dispose();
    metrosCtrl.dispose();
    kgCtrl.dispose();
    enderecoCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: AppColors.navyAccent) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SearchHeader(
                placeholder: 'Para onde?',
                trailing: CircleAvatar(
                  backgroundColor: AppColors.navy,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: tipoCtrl,
                            decoration: _dec("Tipo de material",
                                icon: Icons.category_outlined),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? "Obrigatório" : null,
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: metrosCtrl,
                            keyboardType: TextInputType.number,
                            decoration: _dec("Quantidade em metros",
                                icon: Icons.straighten),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? "Obrigatório" : null,
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: kgCtrl,
                            keyboardType: TextInputType.number,
                            decoration: _dec("Quantidade em KG",
                                icon: Icons.monitor_weight_outlined),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? "Obrigatório" : null,
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: enderecoCtrl,
                            decoration: _dec("Endereço de coleta",
                                icon: Icons.location_on_outlined),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? "Obrigatório" : null,
                          ),
                          const SizedBox(height: 24),

                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // TODO: salvar material
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Material cadastrado!")),
                                );
                              }
                            },
                            icon: const Icon(Icons.check),
                            label: const Text(
                              "Cadastrar Material",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: AppBottomNavBar(currentIndex: _currentIndex),
    );
  }
}
