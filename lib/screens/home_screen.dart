import 'package:flutter/material.dart';
import 'package:app_poulet/themes/images/app_images.dart';
import 'package:app_poulet/widgets/summary_cart.dart';
import 'package:app_poulet/widgets/dashboard_cart.dart';
import 'package:app_poulet/screens/cycle_screen.dart';
import 'package:app_poulet/screens/depense_screen.dart';
import 'package:app_poulet/screens/perte_screen.dart';
import 'package:app_poulet/screens/historique_screen.dart';
import 'package:app_poulet/screens/rapport_screen.dart';
import 'package:app_poulet/screens/parametres_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index pour gérer la navigation

  final List<Widget> _pages = [
    const HomePageContent(), // Accueil
    const HistoriqueScreen(), // Historique des activités
    const RapportScreen(), // Rapports et statistiques
    const ParametresScreen(), // Paramètres
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Historique",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Rapports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Paramètres",
          ),
        ],
      ),
    );
  }
}

// Contenu principal de la page d'accueil
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      children: [
        // Header avec le logo et message de bienvenue
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

        // Section Résumé
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
                value: '3',
                icon: Icons.loop,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SummaryCard(
                title: 'Bénéfices',
                value: '5000 FCFA',
                icon: Icons.monetization_on,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SummaryCard(
                title: 'Dépenses',
                value: '2000 FCFA',
                icon: Icons.money_off,
                color: Colors.orange,
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),

        // Section Navigation
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
    );
  }
}
