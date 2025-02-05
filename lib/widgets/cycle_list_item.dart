import 'package:flutter/material.dart';

class CycleListItem extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final VoidCallback onTap;

  const CycleListItem({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Début: $date - Statut: $status"),
        trailing: Chip(
          label: Text(
            status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: status == "En cours" ? Colors.green : Colors.red,
        ),
        onTap: onTap,
      ),
    );
  }
}
