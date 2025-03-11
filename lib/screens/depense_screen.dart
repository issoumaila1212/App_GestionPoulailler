import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_depense_screen.dart';
import 'package:app_poulet/database/depense_service.dart';

class DepenseScreen extends StatefulWidget {
  const DepenseScreen({super.key});

  @override
  _DepenseScreenState createState() => _DepenseScreenState();
}

class _DepenseScreenState extends State<DepenseScreen> {
  List<Map<String, dynamic>> depenses = [];

  @override
  void initState() {
    super.initState();
    _loadDepenses();
  }

  // ✅ Charger les dépenses depuis la base de données SQLite
  Future<void> _loadDepenses() async {
    List<Map<String, dynamic>> data = await DepenseService().getDepenses();
    setState(() {
      depenses = data;
    });
  }

  // ✅ Supprimer une dépense
  Future<void> _deleteDepense(int id) async {
    await DepenseService().deleteDepense(id);
    _loadDepenses(); // Recharger la liste après suppression
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Dépenses"),
        backgroundColor: Colors.orange,
      ),
      body: depenses.isEmpty
          ? const Center(
              child: Text(
                "Aucune dépense enregistrée.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: depenses.length,
              itemBuilder: (context, index) {
                final depense = depenses[index];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.shade100,
                        child: Icon(Icons.attach_money, color: Colors.orange.shade800),
                      ),
                      title: Text(
                        "${depense["type"]} - ${depense["amount"]} FCFA",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date: ${depense["date"]}", style: const TextStyle(fontSize: 14)),
                          if (depense["description"] != null && depense["description"].isNotEmpty)
                            Text(depense["description"], style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteDepense(depense["id"]),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          final newDepense = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDepenseScreen()),
          );

          if (newDepense != null && newDepense is Map<String, dynamic>) {
            await DepenseService().addDepense(newDepense);
            _loadDepenses(); // Recharger la liste
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
