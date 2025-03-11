import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class CycleService {
  // 📌 Obtenir tous les cycles
  Future<List<Map<String, dynamic>>> getCycles() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query("cycles");
  }

  // 📌 Ajouter un cycle (Correction `start_date` au lieu de `startDate`)
  Future<int> addCycle(Map<String, dynamic> cycle) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert("cycles", {
      "name": cycle["name"],
      "type": cycle["type"],
      "start_date": cycle["startDate"], // ✅ Correction ici
      "end_date": cycle["endDate"], 
      "initial_count": cycle["initialCount"],
      "status": cycle["status"]
    });
  }

  Future<int> countCyclesEnCours() async {
  final db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery(
    "SELECT COUNT(*) AS total FROM cycles WHERE status = 'En cours'"
  );
  return result.isNotEmpty ? (result.first["total"] as int) : 0;
}


  // 📌 Mettre à jour le statut d’un cycle
  Future<int> updateCycleStatus(int id, String newStatus) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      "cycles",
      {"status": newStatus},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // 📌 Supprimer un cycle
  Future<int> deleteCycle(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete("cycles", where: "id = ?", whereArgs: [id]);
  }
}
