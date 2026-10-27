import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransaccionesCostosScreen extends StatefulWidget {
  const TransaccionesCostosScreen({super.key});

  @override
  State<TransaccionesCostosScreen> createState() => _TransaccionesCostosScreenState();
}

class _TransaccionesCostosScreenState extends State<TransaccionesCostosScreen> {
  bool estaCargando = true;

  List<Map<String, dynamic>> transacciones = [
    {'id': '1', 'tipo': 'ingreso', 'concepto': 'Venta de Plátano Verde', 'monto': 1250000.0, 'fecha': '14/09/2026'},
    {'id': '2', 'tipo': 'egreso', 'concepto': 'Compra de Insumos', 'monto': 350000.0, 'fecha': '12/09/2026'}
  ];

  String tipoTransaccion = 'ingreso';

  // Controladores INGRESOS
  final TextEditingController prodCtrl = TextEditingController();
  final TextEditingController tipoVentaCtrl = TextEditingController();
  final TextEditingController cantCtrl = TextEditingController();
  final TextEditingController precioUnitCtrl = TextEditingController();
  final TextEditingController precioEnvioCtrl = TextEditingController();

  // Controladores GASTOS
  final TextEditingController categoriaCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController importeGastoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => estaCargando = false);
    });
  }

  @override
  void dispose() {
    prodCtrl.dispose();
    tipoVentaCtrl.dispose();
    cantCtrl.dispose();
    precioUnitCtrl.dispose();
    precioEnvioCtrl.dispose();
    categoriaCtrl.dispose();
    descCtrl.dispose();
    importeGastoCtrl.dispose();
    super.dispose();
  }

  // Utilidad para formatear números como moneda (ej: $ 1.250.000)
  String formatearMoneda(double valor) {
    String s = valor.round().abs().toString();
    String resultado = '';
    int cont = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      resultado = s[i] + resultado;
      cont++;
      if (cont == 3 && i != 0) {
        resultado = '.$resultado';
        cont = 0;
      }
    }
    return '${valor < 0 ? "-" : ""}\$$resultado';
  }

  double get importeCalculadoIngreso {
    double cant = double.tryParse(cantCtrl.text) ?? 0;
    double precioU = double.tryParse(precioUnitCtrl.text) ?? 0;
    double envio = double.tryParse(precioEnvioCtrl.text) ?? 0;
    return (cant * precioU) + envio;
  }

  void limpiarFormulario() {
    prodCtrl.clear();
    tipoVentaCtrl.clear();
    cantCtrl.clear();
    precioUnitCtrl.clear();
    precioEnvioCtrl.clear();
    categoriaCtrl.clear();
    descCtrl.clear();
    importeGastoCtrl.clear();
    tipoTransaccion = 'ingreso';
  }

  void guardarTransaccion() {
    Map<String, dynamic> nuevoRegistro;
    final ahora = DateTime.now();
    final fechaHoy = "${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}";

    if (tipoTransaccion == 'ingreso') {
      if (prodCtrl.text.trim().isEmpty || cantCtrl.text.trim().isEmpty || precioUnitCtrl.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Completa los campos requeridos del ingreso.'), backgroundColor: Colors.red));
        return;
      }
      nuevoRegistro = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'tipo': 'ingreso',
        'concepto': 'Venta: ${prodCtrl.text} (${cantCtrl.text} unid.)',
        'monto': importeCalculadoIngreso,
        'fecha': fechaHoy
      };
    } else {
      if (categoriaCtrl.text.trim().isEmpty || importeGastoCtrl.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Completa los campos requeridos del gasto.'), backgroundColor: Colors.red));
        return;
      }
      nuevoRegistro = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'tipo': 'egreso',
        'concepto': '${categoriaCtrl.text}\n${descCtrl.text}',
        'monto': double.tryParse(importeGastoCtrl.text) ?? 0,
        'fecha': fechaHoy
      };
    }

    setState(() {
      transacciones.insert(0, nuevoRegistro);
    });

    limpiarFormulario();
    Navigator.pop(context); // Cerrar modal
  }

  void mostrarModalTransaccion() {
    limpiarFormulario();
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              insetPadding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Nueva Transacción', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                    const SizedBox(height: 20),

                    // Selector de tipo
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFFF4F6F8), borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setDialogState(() => tipoTransaccion = 'ingreso'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: tipoTransaccion == 'ingreso' ? const Color(0xFF2E7D32) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('Ingreso (Venta)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: tipoTransaccion == 'ingreso' ? Colors.white : const Color(0xFF666666))),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setDialogState(() => tipoTransaccion = 'egreso'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: tipoTransaccion == 'egreso' ? const Color(0xFFD32F2F) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('Costo/Egreso', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: tipoTransaccion == 'egreso' ? Colors.white : const Color(0xFF666666))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Formulario desplazable
                    Expanded(
                      child: SingleChildScrollView(
                        child: tipoTransaccion == 'ingreso' 
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: _construirInput('Producto *', 'Ej. Plátano', prodCtrl)),
                                  const SizedBox(width: 10),
                                  Expanded(child: _construirInput('Tipo de Venta', 'Ej. Mayorista', tipoVentaCtrl)),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: _construirInput('Cantidad *', '0', cantCtrl, esNumero: true, alCambiar: (_) => setDialogState(() {}))),
                                  const SizedBox(width: 10),
                                  Expanded(child: _construirInput('Precio Unit. *', '\$ 0', precioUnitCtrl, esNumero: true, alCambiar: (_) => setDialogState(() {}))),
                                ],
                              ),
                              _construirInput('Precio de Envío', '\$ 0', precioEnvioCtrl, esNumero: true, alCambiar: (_) => setDialogState(() {})),
                              
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFC8E6C9))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Importe Total Calculado:', style: TextStyle(fontSize: 14, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                                    Text(formatearMoneda(importeCalculadoIngreso), style: const TextStyle(fontSize: 18, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _construirInput('Categoría de Gasto *', 'Ej. Semillas, Transporte...', categoriaCtrl),
                              _construirInput('Descripción', 'Detalles del gasto', descCtrl),
                              _construirInput('Importe Total *', '\$ 0', importeGastoCtrl, esNumero: true),
                            ],
                          ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botones
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(backgroundColor: const Color(0xFFF4F6F8), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            child: const Text('Cancelar', style: TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: guardarTransaccion,
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            child: const Text('Registrar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget _construirInput(String label, String hint, TextEditingController controlador, {bool esNumero = false, Function(String)? alCambiar}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
          const SizedBox(height: 5),
          TextField(
            controller: controlador,
            keyboardType: esNumero ? TextInputType.number : TextInputType.text,
            onChanged: alCambiar,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF4F6F8),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF00615C))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (estaCargando) {
      return const Scaffold(
        backgroundColor: Color(0xFFF4F6F8),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF00615C)),
              SizedBox(height: 16),
              Text('Calculando finanzas...', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    double totalIngresos = transacciones.where((t) => t['tipo'] == 'ingreso').fold(0.0, (sum, t) => sum + t['monto']);
    double totalEgresos = transacciones.where((t) => t['tipo'] == 'egreso').fold(0.0, (sum, t) => sum + t['monto']);
    double balanceNeto = totalIngresos - totalEgresos;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      floatingActionButton: FloatingActionButton(
        onPressed: mostrarModalTransaccion,
        backgroundColor: const Color(0xFF00615C),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ENCABEZADO
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 2), blurRadius: 3)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Color(0xFF00615C), size: 20),
                    onPressed: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Text('Transacciones y Costos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            // CONTENIDO
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TABLERO FINANCIERO
                        Container(
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 4), blurRadius: 10)],
                          ),
                          child: Column(
                            children: [
                              const Text('Balance Neto', style: TextStyle(fontSize: 14, color: Color(0xFF666666), fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(formatearMoneda(balanceNeto), style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: balanceNeto >= 0 ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F))),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: Color(0xFFE0E0E0), height: 1)),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text('Ingresos', style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
                                        const SizedBox(height: 5),
                                        Text(formatearMoneda(totalIngresos), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text('Costos/Egresos', style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
                                        const SizedBox(height: 5),
                                        Text(formatearMoneda(totalEgresos), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Text('Historial Reciente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        const SizedBox(height: 15),

                        // LISTA DE TRANSACCIONES
                        ...transacciones.map((t) {
                          bool esIngreso = t['tipo'] == 'ingreso';
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), offset: const Offset(0, 1), blurRadius: 3)],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: esIngreso ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: FaIcon(esIngreso ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown, size: 16, color: esIngreso ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F)),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(t['concepto'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                                      const SizedBox(height: 3),
                                      Text(t['fecha'], style: const TextStyle(fontSize: 12, color: Color(0xFF888888))),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${esIngreso ? "+" : "-"}${formatearMoneda(t['monto'])}',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: esIngreso ? const Color(0xFF2E7D32) : const Color(0xFF333333)),
                                )
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 80), // Espacio para que el FAB no tape el último
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}