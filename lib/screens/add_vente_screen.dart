import 'package:flutter/material.dart';
import 'package:app_poulet/database/vente_service.dart';
import 'package:app_poulet/database/cycle_service.dart';

class AddVenteScreen extends StatefulWidget {
  const AddVenteScreen({super.key});

  @override
  _AddVenteScreenState createState() => _AddVenteScreenState();
}

class _AddVenteScreenState extends State<AddVenteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<Map<String, dynamic>> _cycles = [];
  int? _selectedCycleId;
  String _selectedCycleType = "";

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
        _selectedCycleType = _cycles.first["type"];
      }
    });
  }

  void _saveVente() async {
    if (_formKey.currentState!.validate() && _selectedCycleId != null) {
      await VenteService().addVente({
        "cycle_id": _selectedCycleId,
        "type": _selectedCycleType,
        "quantity": _quantityController.text,
        "price": _priceController.text,
      });

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une Vente"), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sélectionner un cycle", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<int>(
                value: _selectedCycleId,
                items: _cycles.map((cycle) {
                  return DropdownMenuItem<int>(
                    value: cycle["id"],
                    child: Text(cycle["name"]),
                    onTap: () {
                      setState(() {
                        _selectedCycleType = cycle["type"];
                      });
                    },
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCycleId = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                  _selectedCycleType == "Poules pondeuses"
                      ? "Nombre d'alvéoles vendus"
                      : "Nombre de poulets vendus",
                  _quantityController,
                  keyboardType: TextInputType.number),
              _buildTextField("Prix total (FCFA)", _priceController, keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveVente,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          validator: (value) => value!.isEmpty ? "Ce champ est obligatoire" : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
