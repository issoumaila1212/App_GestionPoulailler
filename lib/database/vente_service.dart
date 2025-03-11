import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class VenteService {
  // 📌 Obtenir toutes les ventes
  Future<List<Map<String, dynamic>>> getVentes() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query("ventes");
  }

  // 📌 Obtenir les ventes par cycle
  Future<List<Map<String, dynamic>>> getVentesByCycle(int cycleId) async {
    final db = await DatabaseHelper.instance.database;
    return await db.query("ventes", where: "cycle_id = ?", whereArgs: [cycleId]);
  }

  // 📌 Obtenir la quantité totale vendue pour un cycle donné
Future<int> getTotalQuantiteVentes(int cycleId) async {
  final db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery(
    "SELECT SUM(quantity) AS total FROM ventes WHERE cycle_id = ?",
    [cycleId],
  );

  return result.isNotEmpty && result.first["total"] != null
      ? (result.first["total"] as num).toInt()
      : 0;
}


  // 📌 Ajouter une vente
  Future<int> addVente(Map<String, dynamic> vente) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert("ventes", {
      "cycle_id": vente["cycle_id"], // ✅ Stocke l'ID du cycle
      "type": vente["type"], // ✅ Type (Poulet de chair ou Alvéoles d'œufs)
      "quantity": vente["quantity"],
      "price": vente["price"],
      "synced": 0, // ⚠ Ajout de la synchronisation avec Firebase plus tard
    });
  }

  // 📌 Obtenir le total des ventes pour un cycle donné
  Future<double> getTotalVentes(int cycleId) async {
  final db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery(
    "SELECT SUM(price * quantity) AS total FROM ventes WHERE cycle_id = ?",
    [cycleId],
  );

  return result.isNotEmpty && result.first["total"] != null
      ? (result.first["total"] as num).toDouble()
      : 0.0;
}

// 🟢 Total des ventes pour TOUS les cycles (utilisé dans l'accueil)
Future<double> getTotalVentesGlobales() async {
  final db = await DatabaseHelper.instance.database;
  var result = await db.rawQuery("SELECT SUM(price * quantity) AS total FROM ventes");

  return result.isNotEmpty && result.first["total"] != null
      ? (result.first["total"] as num).toDouble()
      : 0.0;
}

 

  // 📌 Supprimer une vente
  Future<int> deleteVente(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete("ventes", where: "id = ?", whereArgs: [id]);
  }
}
