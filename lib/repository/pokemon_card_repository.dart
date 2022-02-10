import 'dart:convert';
import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:http/http.dart';

class PokemonCardRepository {
  Future<List<PokemonCard>> fetchPokemonCard(String query) async {
    final Response response = await get(Uri.https('api.pokemontcg.io','/v2/cards', {
      'q': 'name:'+query
    }));
    if(response.statusCode == 200) {
      final List<PokemonCard> cards = [];

      final Map<String, dynamic> json = jsonDecode(response.body);
      if(json.containsKey("data")) {
        final List<dynamic> datas = json['data'];
        for (var dataJson in datas) {
          cards.add(PokemonCard.fromCardJson(dataJson));
        }
      }
      return cards;
    } else {
      throw Exception('Failed to load cards');
    }
  }
}