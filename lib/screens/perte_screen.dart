import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_perte_screen.dart';

class PerteScreen extends StatefulWidget {
  const PerteScreen({super.key});

  @override
  _PerteScreenState createState() => _PerteScreenState();
}

class _PerteScreenState extends State<PerteScreen> {
  List<Map<String, dynamic>> pertes = [
    {
      "cycle": "Cycle 1 - Poulets de chair",
      "date": "2024-01-10",
      "cause": "Maladie",
      "count": 10,
    },
    {
      "cycle": "Cycle 2 - Poules pondeuses",
      "date": "2024-02-05",
      "cause": "Chute de température",
      "count": 3,
    },
  ];

  // ✅ Ajouter une nouvelle perte
  void _addPerte(Map<String, dynamic> newPerte) {
    setState(() {
      pertes.add(newPerte);
    });
  }

  // ❌ Supprimer une perte
  void _deletePerte(int index) {
    setState(() {
      pertes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Pertes"),
        backgroundColor: Colors.orange,
      ),
      body: pertes.isEmpty
          ? const Center(child: Text("Aucune perte enregistrée."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pertes.length,
              itemBuilder: (context, index) {
                final perte = pertes[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      "${perte["cycle"]} - ${perte["cause"]}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Date: ${perte["date"]} - Nombre: ${perte["count"]}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePerte(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          final newPerte = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPerteScreen()),
          );
          if (newPerte != null) {
            _addPerte(newPerte);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
