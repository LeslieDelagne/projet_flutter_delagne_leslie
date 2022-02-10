import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:projet_flutter_delagne_leslie/repository/pokemon_card_repository.dart';

class Repository {
  Repository(this._pokemonCardRepository);

  final PokemonCardRepository _pokemonCardRepository;

  Future<List<PokemonCard>> searchPokemonCard(String query) {
    return _pokemonCardRepository.fetchPokemonCard(query);
  }
}