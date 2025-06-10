import 'package:flutter/material.dart';

class NuevoServicio extends StatelessWidget {
  const NuevoServicio({super.key});

  Widget buildTextFieldCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 14),
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.blue, size: 22),
            labelText: label,
            labelStyle: const TextStyle(fontSize: 13, color: Colors.black54),
            floatingLabelStyle: const TextStyle(color: Colors.blue, fontSize: 12),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownCard({
    required IconData icon,
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.blue, size: 22),
            labelText: label,
            labelStyle: const TextStyle(fontSize: 13, color: Colors.black54),
            floatingLabelStyle: const TextStyle(color: Colors.blue, fontSize: 12),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placaController = TextEditingController();
    final fechaController = TextEditingController();
    final horaController = TextEditingController();
    final comentariosController = TextEditingController();

    String? servicioSeleccionado;
    String? zonaSeleccionada;

    final servicios = ['Mantenimiento', 'Electrica', 'Cambio de llantas', "Revisión y ajuste de freonos", "Cambio de aceite", "Lavado y estética", "Lubricacion de cadena"];
    final zonas = ['Selene', 'Las Arboledas', 'El tripangulo', "San fransisco tlaltenco", "Ojo de agua", "San miguel (Tláhuac)", "Quiahutla", "La ciénega"];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextFieldCard(
              icon: Icons.article_outlined,
              label: 'Placa',
              controller: placaController,
            ),
            buildDropdownCard(
              icon: Icons.build_outlined,
              label: 'Servicio',
              value: servicioSeleccionado,
              items: servicios,
              onChanged: (val) {
                servicioSeleccionado = val;
              },
            ),
            buildDropdownCard(
              icon: Icons.location_on_outlined,
              label: 'Zona',
              value: zonaSeleccionada,
              items: zonas,
              onChanged: (val) {
                zonaSeleccionada = val;
              },
            ),
            buildTextFieldCard(
              icon: Icons.calendar_today,
              label: 'Fecha',
              controller: fechaController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  fechaController.text = "${pickedDate.toLocal()}".split(' ')[0];
                }
              },
            ),
            buildTextFieldCard(
              icon: Icons.access_time,
              label: 'Hora',
              controller: horaController,
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  horaController.text = pickedTime.format(context);
                }
              },
            ),
            buildTextFieldCard(
              icon: Icons.comment_outlined,
              label: 'Comentarios',
              controller: comentariosController,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  //
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                ),
                child: const Text('Agregar servicio', style: TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
