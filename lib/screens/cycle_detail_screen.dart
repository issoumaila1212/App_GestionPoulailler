import 'package:flutter/material.dart';
import 'package:app_poulet/widgets/summary_cart.dart';

class CycleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> cycle; // ✅ Données dynamiques du cycle

  const CycleDetailScreen(
      {super.key, required this.cycle}); // ✅ Ajout de "required this.cycle"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cycle["name"]),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Section principale avec fond arrondi
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
                    cycle["name"], // ✅ Affichage dynamique du nom
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "📅 Date de début : ${cycle["startDate"]}",
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  Text(
                    "🐔 Nombre initial : ${cycle["initialCount"]}",
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  Text(
                    "📌 Statut : ${cycle["status"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cycle["status"] == "En cours"
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🟠 Résumé sous forme de cartes stylées
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
                    value: '5', // Placeholder
                    icon: Icons.warning,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SummaryCard(
                    title: 'Dépenses',
                    value: '2000 FCFA', // Placeholder
                    icon: Icons.money_off,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SummaryCard(
                    title: 'Ventes',
                    value: '5000 FCFA', // Placeholder
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
                    // 🟢 Action de modification à ajouter ici
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text("Modifier"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showDeleteDialog(context);
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text("Supprimer"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
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
                // 🚨 Suppression à implémenter
                Navigator.pop(context);
              },
              child:
                  const Text("Supprimer", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
