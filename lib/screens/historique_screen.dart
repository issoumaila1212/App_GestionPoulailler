import 'package:flutter/material.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  _HistoriqueScreenState createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  List<Map<String, dynamic>> historique = [
    {
      "type": "Vente",
      "detail": "Vente de 50 poulets",
      "date": "2024-03-05",
    },
    {
      "type": "Dépense",
      "detail": "Achat de nourriture (15000 FCFA)",
      "date": "2024-03-03",
    },
    {
      "type": "Perte",
      "detail": "5 poulets morts suite à une maladie",
      "date": "2024-02-28",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des Activités"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: historique.length,
        itemBuilder: (context, index) {
          final event = historique[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                event["type"] == "Vente"
                    ? Icons.shopping_cart
                    : event["type"] == "Dépense"
                        ? Icons.money_off
                        : Icons.warning,
                color: event["type"] == "Vente"
                    ? Colors.green
                    : event["type"] == "Dépense"
                        ? Colors.orange
                        : Colors.red,
              ),
              title: Text(
                event["detail"],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Date: ${event["date"]}"),
            ),
          );
        },
      ),
    );
  }
}
