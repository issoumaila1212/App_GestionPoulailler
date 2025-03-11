import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_cycle_screen.dart';
import 'package:app_poulet/screens/cycle_detail_screen.dart';
import 'package:app_poulet/database/cycle_service.dart';

class CycleScreen extends StatefulWidget {
  const CycleScreen({super.key});

  @override
  _CycleScreenState createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  List<Map<String, dynamic>> cycles = [];

  @override
  void initState() {
    super.initState();
    _loadCycles();
  }

  // 📌 Charger les cycles depuis SQLite
  Future<void> _loadCycles() async {
    List<Map<String, dynamic>> data = await CycleService().getCycles();
    setState(() {
      cycles = data;
    });
  }

  // 📌 Ajouter un cycle dans la base SQLite
  Future<void> _addCycle(Map<String, dynamic> newCycle) async {
    await CycleService().addCycle(newCycle);
    _loadCycles(); // ✅ Recharger la liste après ajout
  }

  // 📌 Changer le statut du cycle (En cours ⬌ Terminé)
  Future<void> _changeStatus(int index) async {
    String currentStatus = cycles[index]["status"];
    String newStatus = (currentStatus == "En cours") ? "Terminé" : "En cours";

    await CycleService().updateCycleStatus(cycles[index]["id"], newStatus);
    _loadCycles(); // ✅ Recharger la liste après modification
  }

  // 📌 Supprimer un cycle
  Future<void> _deleteCycle(int index) async {
    await CycleService().deleteCycle(cycles[index]["id"]);
    _loadCycles(); // ✅ Recharger la liste après suppression
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Cycles"),
      ),
      body: cycles.isEmpty
          ? const Center(
              child: Text("Aucun cycle enregistré.",
                  style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
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
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Début: ${cycle["start_date"]} - Statut: ${cycle["status"]}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            cycle["status"] == "En cours"
                                ? Icons.check_circle
                                : Icons.refresh,
                            color: cycle["status"] == "En cours"
                                ? Colors.green
                                : Colors.orange,
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
