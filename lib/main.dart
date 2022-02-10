import 'package:flutter/material.dart';
import 'package:projet_flutter_delagne_leslie/blocs/pokemon_card_cubit.dart';
import 'package:projet_flutter_delagne_leslie/repository/favoris_repository.dart';
import 'package:projet_flutter_delagne_leslie/repository/pokemon_card_repository.dart';
import 'package:projet_flutter_delagne_leslie/repository/repository.dart';
import 'package:projet_flutter_delagne_leslie/screen/favoris_liste.dart';
import 'package:projet_flutter_delagne_leslie/screen/home.dart';
import 'package:projet_flutter_delagne_leslie/screen/search_pokemon_card.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final FavorisRepository favorisRepository = FavorisRepository();
  final PokemonCardRepository pokemonCardRepository = PokemonCardRepository();
  final Repository repository = Repository(pokemonCardRepository, favorisRepository);

  final PokemonCardCubit pokemonCardCubit = PokemonCardCubit(repository);
  await pokemonCardCubit.loadPokemonCards();

  runApp(
      MultiProvider(
        providers: [
          Provider<PokemonCardCubit>(create: (_) => pokemonCardCubit),
          Provider<Repository>(create: (_) => repository),
        ],
        child: const MyApp(),
      )
  );
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
        '/favorisListe': (context) => const FavorisListe(),
      },

      home: const Home(),
    );
  }
}

