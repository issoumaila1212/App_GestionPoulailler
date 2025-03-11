import 'package:flutter/material.dart';
import 'package:app_poulet/themes/images/app_images.dart';
import 'package:app_poulet/widgets/summary_cart.dart';
import 'package:app_poulet/widgets/dashboard_cart.dart';
import 'package:app_poulet/database/cycle_service.dart';
import 'package:app_poulet/database/depense_service.dart';
import 'package:app_poulet/database/vente_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cycleEnCours = 0;
  double _totalBenefices = 0;
  double _totalDepenses = 0;

  @override
  void initState() {
    super.initState();
    _loadSummaryData();
  }

  // 🟢 Charger les données du résumé
  Future<void> _loadSummaryData() async {
    int cycles = await CycleService().countCyclesEnCours();
    double depenses = await DepenseService()
        .getTotalDepensesGlobales(); // ✅ Total des dépenses
    double ventes =
        await VenteService().getTotalVentesGlobales(); // ✅ Total des ventes
    double benefices = ventes - depenses; // 🚀 Bénéfices = ventes - dépenses

    setState(() {
      _cycleEnCours = cycles;
      _totalDepenses = depenses;
      _totalBenefices = benefices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding:
            const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
        children: [
          // 🟢 Header
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logoPoulet,
                  width: 100,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Bienvenue dans l'application de Poulet SALAM",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Gérez votre poulailler en toute simplicité",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🟠 Résumé avec données dynamiques
          const Center(
            child: Text(
              "Résumé",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SummaryCard(
                  title: 'Cycle en cours',
                  value: _cycleEnCours.toString(), // ✅ Nombre de cycles
                  icon: Icons.loop,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  title: 'Bénéfices',
                  value:
                      '${_totalBenefices.toStringAsFixed(2)} FCFA', // ✅ Calcul des bénéfices
                  icon: Icons.monetization_on,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  title: 'Dépenses',
                  value:
                      '${_totalDepenses.toStringAsFixed(2)} FCFA', // ✅ Total dépenses
                  icon: Icons.money_off,
                  color: Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // 🔵 Navigation
          const Center(
            child: Text(
              "Navigation",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 15),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              DashboardCard(
                title: 'Cycles',
                icon: Icons.autorenew,
                color: Colors.blue,
                onTap: () {
                  Navigator.pushNamed(context, '/cycles');
                },
              ),
              DashboardCard(
                title: 'Dépenses',
                icon: Icons.money_off,
                color: Colors.orange,
                onTap: () {
                  Navigator.pushNamed(context, '/depenses');
                },
              ),
              DashboardCard(
                title: 'Ventes',
                icon: Icons.shopping_cart,
                color: Colors.green,
                onTap: () {
                  Navigator.pushNamed(context, '/ventes');
                },
              ),
              DashboardCard(
                title: 'Pertes',
                icon: Icons.warning,
                color: Colors.red,
                onTap: () {
                  Navigator.pushNamed(context, '/pertes');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
