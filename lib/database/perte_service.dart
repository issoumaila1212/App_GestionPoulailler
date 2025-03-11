import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class PerteService {
  // 📌 Obtenir toutes les pertes
  Future<List<Map<String, dynamic>>> getPertes() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query("pertes");
  }

  Future<int> getTotalPertes(int cycleId) async {
  final db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery(
    "SELECT SUM(count) AS total FROM pertes WHERE cycle_id = ?",
    [cycleId],
  );

  return result.isNotEmpty && result.first["total"] != null
      ? (result.first["total"] as num).toInt()
      : 0;
}


  // 📌 Ajouter une perte
  Future<int> addPerte(Map<String, dynamic> perte) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert("pertes", {
      "cycle_id": perte["cycle_id"], // ✅ Stocke l'ID du cycle
      "cause": perte["cause"],
      "count": perte["count"],
      "synced": 0, // ⚠ Ajout de la synchronisation avec Firebase plus tard
    });
  }

  // 📌 Supprimer une perte
  Future<int> deletePerte(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete("pertes", where: "id = ?", whereArgs: [id]);
  }
}
