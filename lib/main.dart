import 'package:flutter/material.dart';
import 'package:projet_flutter_delagne_leslie/screen/favoris_liste.dart';
import 'package:projet_flutter_delagne_leslie/screen/home.dart';
import 'package:projet_flutter_delagne_leslie/screen/search_pokemon_card.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.red[400],
          secondary: Colors.red[400]
        )
        // primarySwatch: Colors.redAccent,
      ),
      routes: {
        '/home': (context) => const Home(),
        '/searchPokemonCard': (context) => SearchPokemonCard(),
        '/favorisListe': (context) => FavorisListe(),
      },

      home: const Home(),
    );
  }
}

