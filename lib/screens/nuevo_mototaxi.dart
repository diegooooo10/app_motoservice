import 'package:flutter/material.dart';

class NuevoMototaxi extends StatelessWidget {
  const NuevoMototaxi({super.key});

  Widget buildInputCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
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

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final placaController = TextEditingController();
    final telefonoController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildInputCard(
            icon: Icons.person_outline,
            label: 'Nombre',
            controller: nombreController,
          ),
          buildInputCard(
            icon: Icons.badge_outlined,
            label: 'Placa',
            controller: placaController,
          ),
          buildInputCard(
            icon: Icons.phone_outlined,
            label: 'Teléfono',
            controller: telefonoController,
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
              child: const Text('Dar de alta', style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
