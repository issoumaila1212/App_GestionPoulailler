import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_vente_screen.dart';
import 'package:app_poulet/database/vente_service.dart';

class VenteScreen extends StatefulWidget {
  const VenteScreen({super.key});

  @override
  _VenteScreenState createState() => _VenteScreenState();
}

class _VenteScreenState extends State<VenteScreen> {
  List<Map<String, dynamic>> ventes = [];

  @override
  void initState() {
    super.initState();
    _loadVentes();
  }

  Future<void> _loadVentes() async {
    List<Map<String, dynamic>> data = await VenteService().getVentes();
    setState(() {
      ventes = data;
    });
  }

  Future<void> _deleteVente(int id) async {
    await VenteService().deleteVente(id);
    _loadVentes();
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
                      "${vente["type"]} - ${vente["quantity"]} vendus",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Prix: ${vente["price"]} FCFA \nDate: ${vente["date"]}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteVente(vente["id"]),
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

          if (newVente != null && newVente is Map<String, dynamic>) {
            await VenteService().addVente(newVente);
            _loadVentes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
