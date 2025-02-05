import 'package:flutter/material.dart';

class AddCycleScreen extends StatefulWidget {
  const AddCycleScreen({super.key});

  @override
  _AddCycleScreenState createState() => _AddCycleScreenState();
}

class _AddCycleScreenState extends State<AddCycleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  String _selectedType = "Poulet de chair";
  String _selectedStatus = "En cours";

  void _saveCycle() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "name": _nameController.text,
        "startDate": _dateController.text,
        "status": _selectedStatus,
        "type": _selectedType,
        "initialCount": int.parse(_countController.text),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un cycle")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Nom du cycle", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Ex: Cycle 3 - Poulets de chair",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),
              const Text("Type de volaille", style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: ["Poulet de chair", "Poules pondeuses", "Autre"]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text("Date de début", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: "Ex: 23/12/2024",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),
              const Text("Nombre initial de volailles",
                  style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _countController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ex: 100",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),
              const Text("Statut du cycle", style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                items: ["En cours", "Terminé"]
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveCycle,
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
