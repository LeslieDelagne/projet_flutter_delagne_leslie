import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:projet_flutter_delagne_leslie/repository/favoris_repository.dart';
import 'package:projet_flutter_delagne_leslie/repository/pokemon_card_repository.dart';

class Repository {
  Repository(this._pokemonCardRepository, this._favorisRepository);

  final PokemonCardRepository _pokemonCardRepository;
  final FavorisRepository _favorisRepository;

  Future<List<PokemonCard>> searchPokemonCard(String query) {
    return _pokemonCardRepository.fetchPokemonCard(query);
  }

  Future<void> savePokemonCards(List<PokemonCard> pokemonCards) async {
    _favorisRepository.savePokemonCards(pokemonCards);
  }

  Future<List<PokemonCard>> loadPokemonCards() async =>_favorisRepository.loadPokemonCards();
}