import 'package:flutter/material.dart';

class AddVenteScreen extends StatefulWidget {
  const AddVenteScreen({super.key});

  @override
  _AddVenteScreenState createState() => _AddVenteScreenState();
}

class _AddVenteScreenState extends State<AddVenteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // ✅ Liste statique des cycles
  List<String> cycles = ["Cycle 1 - Poulets de chair", "Cycle 2 - Poules pondeuses"];
  String _selectedCycle = "Cycle 1 - Poulets de chair"; // Cycle par défaut

  // ✅ Liste des types de vente
  List<String> typesVentePoulet = ["Vente directe", "Vente en gros"];
  List<String> typesVenteOeufs = ["Vente en gros", "Détail marché"];

  String? _selectedTypeVente;

  void _saveVente() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "cycle": _selectedCycle,
        "type": _selectedTypeVente,
        "quantity": _quantityController.text,
        "unit": _selectedCycle.contains("Pondeuses") ? "Alvéoles" : "Poulets",
        "price": "${_priceController.text} FCFA",
        "date": _dateController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une Vente")),
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
                    _selectedTypeVente = null; // Réinitialisation du type de vente
                  });
                },
              ),
              const SizedBox(height: 10),

              const Text("Type de vente", style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedTypeVente,
                items: (_selectedCycle.contains("Pondeuses")
                        ? typesVenteOeufs
                        : typesVentePoulet)
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTypeVente = value!;
                  });
                },
                validator: (value) => value == null ? "Sélectionnez un type" : null,
              ),
              const SizedBox(height: 10),

              // ✅ Mise à jour dynamique du texte en fonction du cycle sélectionné
              Text(
                _selectedCycle.contains("Pondeuses")
                    ? "Nombre d’alvéoles vendues"
                    : "Nombre de poulets vendus",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: _selectedCycle.contains("Pondeuses")
                      ? "Ex: 30 alvéoles"
                      : "Ex: 50 poulets",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),

              const Text("Prix total", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ex: 50000",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 10),

              const Text("Date", style: TextStyle(fontSize: 16)),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  hintText: "Ex: 2024-03-05",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveVente,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
