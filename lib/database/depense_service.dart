import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class DepenseService {
  // 📌 Obtenir toutes les dépenses
  Future<List<Map<String, dynamic>>> getDepenses() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query("depenses");
  }

  Future<double> getTotalDepenses(int cycleId) async {
  final db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery(
    "SELECT SUM(amount) AS total FROM depenses WHERE cycle_id = ?",
    [cycleId],
  );

  return result.isNotEmpty && result.first["total"] != null
      ? (result.first["total"] as num).toDouble()
      : 0.0;
}

// 🟢 Total des dépenses pour TOUS les cycles (utilisé dans l'accueil)
Future<double> getTotalDepensesGlobales() async {
  final db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery("SELECT SUM(amount) AS total FROM depenses");

  return result.isNotEmpty && result.first["total"] != null
      ? (result.first["total"] as num).toDouble()
      : 0.0;
}


  
  

  // 📌 Ajouter une dépense
  Future<int> addDepense(Map<String, dynamic> depense) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert("depenses", {
      "cycle_id": depense["cycleId"], // ⚠ Utilise cycle_id pour lier au cycle
      "type": depense["type"],
      "amount": depense["amount"],
    });
  }

  // 📌 Mettre à jour une dépense
  Future<int> updateDepense(int id, Map<String, dynamic> updatedDepense) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      "depenses",
      updatedDepense,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // 📌 Supprimer une dépense
  Future<int> deleteDepense(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete("depenses", where: "id = ?", whereArgs: [id]);
  }
}
