import 'package:bloc/bloc.dart';
import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:projet_flutter_delagne_leslie/repository/repository.dart';

class PokemonCardCubit extends Cubit<List<PokemonCard>> {
  PokemonCardCubit(this._repository) : super([]);
  final Repository _repository;

  void addFavori(PokemonCard pokemonCard) {
    emit([...state, pokemonCard]);
    _repository.savePokemonCards(state);
  }
  Future<void> loadPokemonCards() async {
    final List<PokemonCard> pokemonCards = await _repository.loadPokemonCards();
    emit(pokemonCards);
  }

  void clearFavoris() {
    emit([]);
    _repository.savePokemonCards(state);
  }

}