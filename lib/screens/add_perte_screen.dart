import 'package:flutter/material.dart';

class AddPerteScreen extends StatefulWidget {
  const AddPerteScreen({super.key});

  @override
  _AddPerteScreenState createState() => _AddPerteScreenState();
}

class _AddPerteScreenState extends State<AddPerteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // ✅ Liste statique des cycles
  List<String> cycles = [
    "Cycle 1 - Poulets de chair",
    "Cycle 2 - Poules pondeuses"
  ];
  String _selectedCycle = "Cycle 1 - Poulets de chair"; // Cycle par défaut

  void _savePerte() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "cycle": _selectedCycle,
        "cause": _causeController.text,
        "count": _countController.text,
        "date": _dateController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une Perte")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Cycle concerné", style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedCycle,
                items: cycles
                    .map((cycle) => DropdownMenuItem(
                          value: cycle,
                          child: Text(cycle),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCycle = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text("Cause de la perte", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _causeController,
                decoration: const InputDecoration(
                  hintText: "Ex: Maladie, Accident, Température",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),
              const Text("Nombre de pertes", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _countController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ex: 5, 10, etc.",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),
              const Text("Date", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: "Ex: 2024-01-10",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _savePerte,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Ajouter"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
