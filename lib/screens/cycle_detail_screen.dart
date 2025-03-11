import 'package:flutter/material.dart';
import 'package:app_poulet/widgets/summary_cart.dart';
import 'package:app_poulet/database/cycle_service.dart';
import 'package:app_poulet/database/depense_service.dart';
import 'package:app_poulet/database/perte_service.dart';
import 'package:app_poulet/database/vente_service.dart';

class CycleDetailScreen extends StatefulWidget {
  final Map<String, dynamic> cycle; // ✅ Données dynamiques du cycle

  const CycleDetailScreen({super.key, required this.cycle});

  @override
  _CycleDetailScreenState createState() => _CycleDetailScreenState();
}

class _CycleDetailScreenState extends State<CycleDetailScreen> {
  int totalPertes = 0;
  double totalDepenses = 0;
  double totalVentes = 0;

  @override
  void initState() {
    super.initState();
    _loadCycleDetails();
  }

  Future<void> _loadCycleDetails() async {
    int pertes = await PerteService().getTotalPertes(widget.cycle["id"]);
    double depenses = await DepenseService().getTotalDepenses(widget.cycle["id"]);
    double ventes = await VenteService().getTotalVentes(widget.cycle["id"]);

    setState(() {
      totalPertes = pertes;
      totalDepenses = depenses;
      totalVentes = ventes;
    });
  }

  Future<void> _deleteCycle() async {
    await CycleService().deleteCycle(widget.cycle["id"]);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cycle["name"]),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Informations générales du cycle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cycle["name"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("📅 Date de début : ${widget.cycle["start_date"]}",
                      style: const TextStyle(fontSize: 16, color: Colors.white70)),
                  Text("🐔 Nombre initial : ${widget.cycle["initial_count"]}",
                      style: const TextStyle(fontSize: 16, color: Colors.white70)),
                  Text(
                    "📌 Statut : ${widget.cycle["status"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.cycle["status"] == "En cours"
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🟠 Résumé des transactions
            const Text(
              "Résumé",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Pertes',
                    value: '$totalPertes',
                    icon: Icons.warning,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SummaryCard(
                    title: 'Dépenses',
                    value: '$totalDepenses FCFA',
                    icon: Icons.money_off,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SummaryCard(
                    title: 'Ventes',
                    value: '$totalVentes FCFA',
                    icon: Icons.shopping_cart,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            // 🔴 Actions utilisateur (Modifier ou Supprimer)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // 🟢 Ajoutez ici l'action de modification
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text("Modifier"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showDeleteDialog(context),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text("Supprimer"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔴 Fenêtre de confirmation pour suppression
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Supprimer ce cycle ?"),
          content: const Text(
              "Voulez-vous vraiment supprimer ce cycle ? Cette action est irréversible."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                _deleteCycle();
                Navigator.pop(context);
              },
              child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
