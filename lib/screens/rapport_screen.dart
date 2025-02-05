import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RapportScreen extends StatelessWidget {
  const RapportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rapports et Statistiques"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Évolution des ventes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(1, 10),
                        FlSpot(2, 20),
                        FlSpot(3, 50),
                        FlSpot(4, 80),
                        FlSpot(5, 100),
                      ],
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.lightGreen],
                      ),
                      barWidth: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Répartition des pertes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.red,
                      value: 40,
                      title: "Maladies",
                      radius: 60,
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: 30,
                      title: "Accidents",
                      radius: 60,
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 30,
                      title: "Température",
                      radius: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
