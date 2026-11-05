import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InventarioProductivoScreen extends StatefulWidget {
  const InventarioProductivoScreen({super.key});

  @override
  State<InventarioProductivoScreen> createState() => _InventarioProductivoScreenState();
}

class _InventarioProductivoScreenState extends State<InventarioProductivoScreen> {
  // Datos simulados para el inventario
  final List<Map<String, dynamic>> inventario = [
    {'item': 'Tractor Kubota', 'categoria': 'Maquinaria', 'cantidad': '1 Unidad', 'estado': 'Operativo', 'icono': FontAwesomeIcons.tractor},
    {'item': 'Abono Orgánico (Bultos)', 'categoria': 'Insumos', 'cantidad': '120 Bultos', 'estado': 'Stock Alto', 'icono': FontAwesomeIcons.seedling},
    {'item': 'Fumigadoras de Espalda', 'categoria': 'Herramientas', 'cantidad': '5 Unidades', 'estado': 'Mantenimiento', 'icono': FontAwesomeIcons.sprayCan},
    {'item': 'Semilla de Plátano', 'categoria': 'Insumos', 'cantidad': '500 Kg', 'estado': 'Stock Medio', 'icono': FontAwesomeIcons.leaf},
  ];

  // Datos simulados para el calendario
  final List<Map<String, dynamic>> calendario = [
    {'actividad': 'Siembra de Maíz Secundario', 'fecha': '05 Nov - 10 Nov 2026', 'fase': 'Siembra', 'estado': 'Próximo', 'color': Colors.blue},
    {'actividad': 'Abonado General de Cafetales', 'fecha': '15 Nov - 20 Nov 2026', 'fase': 'Mantenimiento', 'estado': 'Programado', 'color': Colors.orange},
    {'actividad': 'Cosecha Principal de Café', 'fecha': '01 Dic - 30 Dic 2026', 'fase': 'Cosecha', 'estado': 'En espera', 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Color(0xFF00615C)),
          title: const Text('Control Productivo', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            labelColor: Color(0xFF00615C),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF00615C),
            indicatorWeight: 3,
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.boxesStacked, size: 20), text: 'Inventario Físico'),
              Tab(icon: FaIcon(FontAwesomeIcons.calendarDays, size: 20), text: 'Calendario Productivo'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _construirVistaInventario(),
              _construirVistaCalendario(),
            ],
          ),
        ),
      ),
    );
  }

  // VISTA 1: INVENTARIO FÍSICO
  Widget _construirVistaInventario() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Existencias de la Asociación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.plus, size: 14, color: Colors.white),
                label: const Text('Registrar Ítem', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C)),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1.2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: inventario.length,
              itemBuilder: (context, index) {
                final item = inventario[index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(item['icono'], size: 40, color: const Color(0xFF00615C)),
                      const SizedBox(height: 15),
                      Text(item['item'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 5),
                      Text(item['cantidad'], style: const TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                        child: Text(item['estado'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // VISTA 2: CALENDARIO PRODUCTIVO
  Widget _construirVistaCalendario() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cronograma de Actividades', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.calendarPlus, size: 14, color: Colors.white),
                label: const Text('Agendar Actividad', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C)),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: calendario.length,
              itemBuilder: (context, index) {
                final evento = calendario[index];
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(color: (evento['color'] as Color).withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Center(child: FaIcon(FontAwesomeIcons.leaf, color: evento['color'] as Color, size: 20)),
                    ),
                    title: Text(evento['actividad'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.clock, size: 12, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(evento['fecha'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(evento['fase'], style: TextStyle(color: evento['color'] as Color, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(evento['estado'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}