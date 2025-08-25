import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../core/config/app_colors.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _map = MapController();
  final List<Marker> _markers = [];
  int _currentIndex = 0;
  bool _locating = false;

  static const LatLng _initialCenter = LatLng(-25.4284, -49.2733);
  static const double _initialZoom = 14;

  Future<void> _goToMyLocation({bool silent = false}) async {
    try {
      setState(() => _locating = !silent);
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.deniedForever ||
          perm == LocationPermission.denied) {
        if (!silent && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permissão de localização negada')),
          );
        }
        setState(() => _locating = false);
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final me = LatLng(pos.latitude, pos.longitude);

      _map.move(me, 16);
      setState(() {
        _markers.removeWhere((m) => (m.key as ValueKey?)?.value == 'me');
        _markers.add(
          Marker(
            key: const ValueKey('me'),
            point: me,
            width: 40,
            height: 40,
            child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
          ),
        );
      });
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  void _onTapMap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      _markers.add(
        Marker(
          key: ValueKey('pin_${latlng.latitude}_${latlng.longitude}'),
          point: latlng,
          width: 36,
          height: 36,
          child: const Icon(Icons.place, color: Colors.red, size: 36),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --------- HEADER (branco) ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  // pill de busca
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.navy,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Para onde?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // avatar
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        /* TODO: perfil */
                      },
                      icon: Icon(Icons.person_outline, color: AppColors.navy),
                      tooltip: 'Perfil',
                    ),
                  ),
                ],
              ),
            ),

            // --------- MAPA (não ocupa a tela toda) ----------
            // Usa Expanded para preencher o espaço ENTRE header e footer.
            // Envolvido num card com bordas arredondadas.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: ClipRRect(
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _map,
                        options: MapOptions(
                          initialCenter: _initialCenter,
                          initialZoom: _initialZoom,
                          onTap: _onTapMap,
                          interactionOptions: const InteractionOptions(
                            flags:
                                InteractiveFlag.pinchZoom |
                                InteractiveFlag.drag |
                                InteractiveFlag.doubleTapZoom,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: const ['a', 'b', 'c'],
                            userAgentPackageName: 'com.texcycle_app.frontend',
                          ),
                          MarkerLayer(markers: _markers),
                        ],
                      ),

                      // botão "minha localização" dentro do card do mapa
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: FloatingActionButton(
                          heroTag: 'locate_me',
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.navy,
                          onPressed: _goToMyLocation,
                          child: _locating
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.my_location),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // --------- FOOTER (sempre no final da tela) ----------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          /* ... */
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.navy,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.home_outlined),
            ),
            
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.grid_view_outlined),
            ),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.receipt_long_outlined),
            ),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Padding(padding: EdgeInsets.only(top: 8),
            child: Icon(Icons.person_outline),
            ),
            label: 'Conta',
          ),
        ],
      ),
    );
  }
}
