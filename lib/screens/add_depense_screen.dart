import 'package:flutter/material.dart';
import 'package:app_poulet/database/depense_service.dart';
import 'package:app_poulet/database/cycle_service.dart';

class AddDepenseScreen extends StatefulWidget {
  const AddDepenseScreen({super.key});

  @override
  _AddDepenseScreenState createState() => _AddDepenseScreenState();
}

class _AddDepenseScreenState extends State<AddDepenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  List<Map<String, dynamic>> _cycles = []; // Stocke les cycles enregistrés
  int? _selectedCycleId; // ID du cycle sélectionné

  @override
  void initState() {
    super.initState();
    _loadCycles();
  }

  // ✅ Charge les cycles depuis la base de données SQLite
  Future<void> _loadCycles() async {
    List<Map<String, dynamic>> data = await CycleService().getCycles();
    setState(() {
      _cycles = data;
      if (_cycles.isNotEmpty) {
        _selectedCycleId = _cycles.first["id"]; // Prend le premier cycle par défaut
      }
    });
  }

  // ✅ Enregistre une nouvelle dépense
  void _saveDepense() async {
    if (_formKey.currentState!.validate() && _selectedCycleId != null) {
      await DepenseService().addDepense({
        "cycle_id": _selectedCycleId,
        "type": _typeController.text,
        "amount": double.tryParse(_amountController.text) ?? 0.0, // Convertir en float
      });

      Navigator.pop(context, true); // ✅ Retour à la liste des dépenses
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une Dépense"), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField("Cycle concerné", _selectedCycleId, _cycles),
              _buildTextField("Type de dépense", _typeController),
              _buildTextField("Montant", _amountController, keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveDepense,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Ajouter", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Widget pour le champ de texte standard
  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          validator: isRequired ? (value) => value!.isEmpty ? "Ce champ est obligatoire" : null : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // ✅ Widget pour le champ de sélection de cycle
  Widget _buildDropdownField(String label, int? selectedValue, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<int>(
          value: selectedValue,
          items: items.map((cycle) {
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
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
