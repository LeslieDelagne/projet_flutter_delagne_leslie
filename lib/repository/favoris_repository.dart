import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavorisRepository {

  //Sauvegarder des cartes dans mes favoris
  Future<void> savePokemonCards(List<PokemonCard> pokemonCards) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> listJson = [];
    for (final PokemonCard pokemonCard in pokemonCards) {
      listJson.add(pokemonCard.toJson());
    }

    prefs.setStringList('pokemonCards', listJson);
  }


  //Récupérer les cartes enregistrées dans mes favoris
  Future<List<PokemonCard>> loadPokemonCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList('pokemonCards');

    if(list == null) {
      return [];
    }

    final List<PokemonCard> pokemonCards = list.map((element) {
      return PokemonCard.fromJson(element);
    }).toList();

    return pokemonCards;
  }

}