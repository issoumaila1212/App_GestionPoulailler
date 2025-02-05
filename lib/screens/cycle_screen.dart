import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_cycle_screen.dart';
import 'package:app_poulet/screens/cycle_detail_screen.dart';

class CycleScreen extends StatefulWidget {
  
  const CycleScreen({super.key});

  @override
  _CycleScreenState createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  List<Map<String, dynamic>> cycles = [
    {
      "name": "Cycle 1 - Poulets de chair",
      "startDate": "2024-03-01",
      "status": "En cours",
      "initialCount": 100,
    },
    {
      "name": "Cycle 2 - Poules pondeuses",
      "startDate": "2023-09-01",
      "status": "Terminé",
      "initialCount": 50,
    },
  ];

  // Fonction pour ajouter un nouveau cycle
  void _addCycle(Map<String, dynamic> newCycle) {
    setState(() {
      cycles.add(newCycle);
    });
  }

  // Fonction pour modifier le statut du cycle
  void _changeStatus(int index) {
    setState(() {
      cycles[index]["status"] =
          cycles[index]["status"] == "En cours" ? "Terminé" : "En cours";
    });
  }

  // Fonction pour supprimer un cycle
  void _deleteCycle(int index) {
    setState(() {
      cycles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Cycles"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cycles.length,
        itemBuilder: (context, index) {
          final cycle = cycles[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                cycle["name"],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Début: ${cycle["startDate"]} - Statut: ${cycle["status"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      cycle["status"] == "En cours" ? Icons.check_circle : Icons.refresh,
                      color: cycle["status"] == "En cours" ? Colors.green : Colors.orange,
                    ),
                    onPressed: () => _changeStatus(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteCycle(index),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CycleDetailScreen(cycle: cycle),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCycle = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCycleScreen()),
          );
          if (newCycle != null) {
            _addCycle(newCycle);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
