import 'package:flutter/material.dart';
import 'package:app_poulet/database/perte_service.dart';
import 'package:app_poulet/database/cycle_service.dart'; // Pour récupérer les cycles

class AddPerteScreen extends StatefulWidget {
  const AddPerteScreen({super.key});

  @override
  _AddPerteScreenState createState() => _AddPerteScreenState();
}

class _AddPerteScreenState extends State<AddPerteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countController = TextEditingController();

  List<Map<String, dynamic>> _cycles = [];
  int? _selectedCycleId;
  String? _selectedCause; // ✅ Cause sous forme de menu déroulant

  // ✅ Liste des causes prédéfinies
  final List<String> _causesList = [
    "Maladie",
    "Accident",
    "Problème de nutrition",
    "Prédateur",
    "Autre"
  ];

  @override
  void initState() {
    super.initState();
    _loadCycles();
  }

  Future<void> _loadCycles() async {
    List<Map<String, dynamic>> data = await CycleService().getCycles();
    setState(() {
      _cycles = data;
      if (_cycles.isNotEmpty) {
        _selectedCycleId = _cycles.first["id"];
      }
    });
  }

  void _savePerte() async {
    if (_formKey.currentState!.validate() &&
        _selectedCycleId != null &&
        _selectedCause != null) {
      await PerteService().addPerte({
        "cycle_id": _selectedCycleId,
        "cause": _selectedCause, // ✅ Cause sélectionnée
        "count": int.parse(_countController.text),
      });

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une Perte"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sélectionner un cycle",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<int>(
                value: _selectedCycleId,
                items: _cycles.map((cycle) {
                  return DropdownMenuItem<int>(
                    value: cycle["id"],
                    child: Text(cycle["name"]),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCycleId = value!;
                  });
                },
              ),
              const SizedBox(height: 10),

              // ✅ Sélecteur pour la cause
              const Text(
                "Sélectionner une cause",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCause,
                items: _causesList.map((cause) {
                  return DropdownMenuItem<String>(
                    value: cause,
                    child: Text(cause),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCause = value!;
                  });
                },
                validator: (value) =>
                    value == null ? "Sélectionnez une cause" : null,
              ),
              const SizedBox(height: 10),

              _buildTextField("Nombre de pertes", _countController,
                  keyboardType: TextInputType.number),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePerte,
                child: const Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          validator: (value) =>
              value!.isEmpty ? "Ce champ est obligatoire" : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
