import 'package:flutter/material.dart';

class AddDepenseScreen extends StatefulWidget {
  const AddDepenseScreen({super.key});

  @override
  _AddDepenseScreenState createState() => _AddDepenseScreenState();
}

class _AddDepenseScreenState extends State<AddDepenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // ✅ Liste statique des cycles
  List<String> cycles = [
    "Cycle 1 - Poulets de chair",
    "Cycle 2 - Poules pondeuses"
  ];
  String _selectedCycle = "Cycle 1 - Poulets de chair"; // Cycle par défaut

  void _saveDepense() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "cycle": _selectedCycle,
        "type": _typeController.text,
        "amount": "${_amountController.text} FCFA",
        "date": _dateController.text,
        "description": _descriptionController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une Dépense")),
      body: SingleChildScrollView(
        // ✅ Permet le défilement
        padding: const EdgeInsets.all(16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
            .onDrag, // ✅ Cache le clavier en scrollant
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
              const Text("Type de dépense", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(
                  hintText: "Ex: Nourriture, Médicaments, Matériel",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),
              const Text("Montant", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ex: 5000",
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
                  hintText: "Ex: 2024-01-20",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),
              const Text("Description", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Ex: Achat de nourriture pour 2 semaines",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveDepense,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
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
