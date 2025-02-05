import 'package:app_poulet/screens/depense_screen.dart';
import 'package:app_poulet/screens/perte_screen.dart';
import 'package:app_poulet/screens/vente_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cycle_screen.dart'; // ✅ Correction de l'import
import 'screens/add_cycle_screen.dart';
import 'screens/depense_screen.dart';
import 'screens/vente_screen.dart'; // ✅ Ajout de l'import
import 'screens/perte_screen.dart';
import 'screens/historique_screen.dart';
import 'screens/rapport_screen.dart';
import 'screens/parametres_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // ✅ Définit la route de démarrage
      routes: {
        '/': (context) => const LoginScreen(), // ✅ Page de connexion par défaut
        '/home': (context) => const HomeScreen(), // ✅ Accueil
        '/cycles': (context) => const CycleScreen(),
        '/depenses': (context) => const DepenseScreen(), // ✅ Gestion des cycles
        '/ventes': (context) => const VenteScreen(), // ✅ Gestion des cycles
        '/pertes': (context) => const PerteScreen(),
        '/historique': (context) => const HistoriqueScreen(),
        '/rapports': (context) => const RapportScreen(),
        '/parametres': (context) => const ParametresScreen(),


      },
    );
  }
}
