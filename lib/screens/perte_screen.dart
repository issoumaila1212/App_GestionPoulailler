import 'package:flutter/material.dart';
import 'package:app_poulet/screens/add_perte_screen.dart';
import 'package:app_poulet/database/perte_service.dart';

class PerteScreen extends StatefulWidget {
  const PerteScreen({super.key});

  @override
  _PerteScreenState createState() => _PerteScreenState();
}

class _PerteScreenState extends State<PerteScreen> {
  List<Map<String, dynamic>> pertes = [];

  @override
  void initState() {
    super.initState();
    _loadPertes();
  }

  Future<void> _loadPertes() async {
    List<Map<String, dynamic>> data = await PerteService().getPertes();
    setState(() {
      pertes = data;
    });
  }

  Future<void> _deletePerte(int id) async {
    await PerteService().deletePerte(id);
    _loadPertes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Pertes"),
        backgroundColor: Colors.redAccent,
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
                      "${perte["cause"]} - ${perte["count"]} perdus",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () async {
          final newPerte = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPerteScreen()),
          );

          if (newPerte != null && newPerte is Map<String, dynamic>) {
            await PerteService().addPerte(newPerte);
            _loadPertes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
