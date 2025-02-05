import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_vente_screen.dart';

class VenteScreen extends StatefulWidget {
  const VenteScreen({super.key});

  @override
  _VenteScreenState createState() => _VenteScreenState();
}

class _VenteScreenState extends State<VenteScreen> {
  List<Map<String, dynamic>> ventes = [
    {
      "cycle": "Cycle 1 - Poulets de chair",
      "type": "Vente directe",
      "quantity": "50",
      "price": "50000 FCFA",
      "date": "2024-03-05",
    },
    {
      "cycle": "Cycle 2 - Poules pondeuses",
      "type": "Gros",
      "quantity": "20",
      "price": "20000 FCFA",
      "date": "2024-02-15",
    },
  ];

  // ✅ Ajouter une nouvelle vente
  void _addVente(Map<String, dynamic> newVente) {
    setState(() {
      ventes.add(newVente);
    });
  }

  // ❌ Supprimer une vente
  void _deleteVente(int index) {
    setState(() {
      ventes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Ventes"),
        backgroundColor: Colors.green,
      ),
      body: ventes.isEmpty
          ? const Center(child: Text("Aucune vente enregistrée."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ventes.length,
              itemBuilder: (context, index) {
                final vente = ventes[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      "${vente["cycle"]} - ${vente["type"]}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Quantité: ${vente["quantity"]} - Prix: ${vente["price"]} \nDate: ${vente["date"]}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteVente(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          final newVente = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddVenteScreen()),
          );
          if (newVente != null) {
            _addVente(newVente);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
