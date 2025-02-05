import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_depense_screen.dart';

class DepenseScreen extends StatefulWidget {
  const DepenseScreen({super.key});

  @override
  _DepenseScreenState createState() => _DepenseScreenState();
}

class _DepenseScreenState extends State<DepenseScreen> {
  List<Map<String, dynamic>> depenses = [
    {
      "cycle": "Cycle 1 - Poulets de chair",
      "type": "Nourriture",
      "amount": "15000 FCFA",
      "date": "2024-01-10",
      "description": "Achat de maïs et tourteau de soja",
    },
    {
      "cycle": "Cycle 1 - Poulets de chair",
      "type": "Médicaments",
      "amount": "5000 FCFA",
      "date": "2024-01-15",
      "description": "Vaccination des poulets",
    },
    {
      "cycle": "Cycle 2 - Poules pondeuses",
      "type": "Matériel",
      "amount": "12000 FCFA",
      "date": "2024-02-01",
      "description": "Achat de lampes chauffantes",
    },
  ];

  // ✅ Ajouter une nouvelle dépense
  void _addDepense(Map<String, dynamic> newDepense) {
    setState(() {
      depenses.add(newDepense);
    });
  }

  // ❌ Supprimer une dépense
  void _deleteDepense(int index) {
    setState(() {
      depenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Dépenses"),
        backgroundColor: Colors.redAccent,
      ),
      body: depenses.isEmpty
          ? const Center(child: Text("Aucune dépense enregistrée."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: depenses.length,
              itemBuilder: (context, index) {
                final depense = depenses[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      "${depense["cycle"]} - ${depense["type"]}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Montant: ${depense["amount"]} \nDate: ${depense["date"]}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteDepense(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          final newDepense = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDepenseScreen()),
          );
          if (newDepense != null) {
            _addDepense(newDepense);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
