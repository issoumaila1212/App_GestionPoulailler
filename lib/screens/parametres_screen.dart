import 'package:flutter/material.dart';

class ParametresScreen extends StatefulWidget {
  const ParametresScreen({super.key});

  @override
  _ParametresScreenState createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  bool notifications = true;
  String devise = "FCFA";
  List<String> devises = ["FCFA", "USD", "EUR"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Préférences",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text("Activer les notifications"),
              value: notifications,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Devise",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: devise,
              items: devises
                  .map((dev) => DropdownMenuItem(
                        value: dev,
                        child: Text(dev),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  devise = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
