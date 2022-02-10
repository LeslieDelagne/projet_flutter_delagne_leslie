import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:projet_flutter_delagne_leslie/repository/favoris_repository.dart';
import 'package:projet_flutter_delagne_leslie/repository/pokemon_card_repository.dart';
import 'package:projet_flutter_delagne_leslie/repository/repository.dart';

class SearchPokemonCard extends StatefulWidget {
  SearchPokemonCard({Key? key}) : super(key: key);

  final Repository repository = Repository(PokemonCardRepository());
  final FavorisRepository favorisRepository = FavorisRepository();


  @override
  State<SearchPokemonCard> createState() => _SearchPokemonCardState();
}

class _SearchPokemonCardState extends State<SearchPokemonCard> {
  List<PokemonCard> _pokemonCards = [];

  final _textFieldController = TextEditingController();

  @override
  void initState() {
    widget.favorisRepository.loadPokemonCards().then((companies) {
      _setPokemonCards(_pokemonCards);
    });
    super.initState();
  }

  void _setPokemonCards(List<PokemonCard> pokemonCards) {
    setState(() {
      _pokemonCards = pokemonCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rchercher un Pokémon'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _textFieldController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Rechercher'
            ),
            onChanged: (String value) async {
                final List<PokemonCard> pokemonCards = await widget.repository
                    .searchPokemonCard(_textFieldController.text);
                setState(() {
                  _pokemonCards = pokemonCards;
                });
            },
          ),
           _pokemonCards.isEmpty && _textFieldController.text.length > 1 ? const Text('Aucune carte trouvée')
           : Expanded(
            child: ListView.builder(
                itemCount: _pokemonCards.length,
                itemBuilder: (context, index) {
                  final PokemonCard pokemonCard = _pokemonCards[index];
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0, top: 20.0, left: 50.0, right: 50.0),
                        child: ListTile(
                          title: CachedNetworkImage(
                            imageUrl: pokemonCard.image,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                          subtitle: Column(
                            children: [
                              Text(pokemonCard.name, style:const TextStyle(fontWeight: FontWeight.bold),),
                              Text('HP : ${pokemonCard.hp}'),
                              pokemonCard.niveau != null ? Text('Niveau: ${pokemonCard.niveau}') : const Text('Niveau inconnu'),
                              pokemonCard.type != null ? Text('Type: ${pokemonCard.type}') : const Text('Type inconnu'),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      print(pokemonCard.name);
                                      print(pokemonCard.hp);
                                      print(pokemonCard.niveau);
                                      print(pokemonCard.type);
                                      print(pokemonCard.evolution);
                                      final PokemonCard newPokemonCard = PokemonCard(
                                          pokemonCard.name,
                                          pokemonCard.hp,
                                          pokemonCard.image,
                                          pokemonCard.niveau,
                                          pokemonCard.type,
                                          pokemonCard.evolution
                                      );
                                      Navigator.of(context).pop(newPokemonCard);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text('Ajouter à ma wishlist'),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}