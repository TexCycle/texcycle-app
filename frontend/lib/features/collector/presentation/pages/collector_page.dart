import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/app_bottom_nav.dart';
import '../../../../../core/config/app_colors.dart';

class CollectorPage extends StatefulWidget {
  const CollectorPage({super.key});

  @override
  State<CollectorPage> createState() => _CollectorPageState();
}

class _CollectorPageState extends State<CollectorPage> {
  int _currentIndex = 2;
  String _status = "Todos";

  final List<Map<String, String>> _coletasDisponiveis = [
    {"tipo": "Algodão", "endereco": "Rua das Flores, 123"},
    {"tipo": "Jeans", "endereco": "Av. Curitiba, 456"},
    {"tipo": "Tecido misto", "endereco": "Rua Paraná, 789"},
  ];

  final List<Map<String, String>> _historicoColetas = [
    {"tipo": "Algodão", "endereco": "Rua São Pedro, 111", "data": "12/01/2025"},
    {"tipo": "Jeans", "endereco": "Av. Brasil, 222", "data": "05/01/2025"},
    {
      "tipo": "Poliéster",
      "endereco": "Rua XV de Novembro, 333",
      "data": "20/12/2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: AppColors.navy,
          elevation: 0,
          title: const Text(
            "Área do Coletador",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Coletas"),
              Tab(text: "Histórico"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _status,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Todos",
                              child: Text("Todos"),
                            ),
                            DropdownMenuItem(
                              value: "Pendentes",
                              child: Text("Pendentes"),
                            ),
                            DropdownMenuItem(
                              value: "Aceitas",
                              child: Text("Aceitas"),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => _status = v ?? "Todos"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: aplicar filtro
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.filter_list),
                        label: const Text("Filtrar"),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: _coletasDisponiveis.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final coleta = _coletasDisponiveis[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.black87,
                          ),
                          title: Text(coleta["tipo"] ?? ""),
                          subtitle: Text(coleta["endereco"] ?? ""),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // TODO: aceitar coleta
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Aceitar"),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: solicitar nova coleta
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Solicitar nova coleta"),
                  ),
                ),
              ],
            ),

            ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _historicoColetas.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final coleta = _historicoColetas[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(coleta["tipo"] ?? ""),
                    subtitle: Text("${coleta["endereco"]} - ${coleta["data"]}"),
                  ),
                );
              },
            ),
          ],
        ),

        bottomNavigationBar: AppBottomNavBar(currentIndex: _currentIndex),
      ),
    );
  }
}
