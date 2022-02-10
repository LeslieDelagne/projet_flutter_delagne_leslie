import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_delagne_leslie/blocs/pokemon_card_cubit.dart';
import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:projet_flutter_delagne_leslie/repository/favoris_repository.dart';
import 'package:projet_flutter_delagne_leslie/repository/pokemon_card_repository.dart';
import 'package:projet_flutter_delagne_leslie/repository/repository.dart';
import 'package:provider/provider.dart';

class SearchPokemonCard extends StatefulWidget {
  SearchPokemonCard({Key? key}) : super(key: key);

  final Repository repository = Repository(PokemonCardRepository(), FavorisRepository());
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
        title: const Text('Rechercher une carte Pokémon'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _textFieldController,
            onFieldSubmitted: (_textFieldController) {
              const snackBar = SnackBar(content: Text('Aucune carte trouvée'),);
              if(_pokemonCards.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
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
           // _pokemonCards.isEmpty && _textFieldController.text.length > 1 ? const Text('Aucune carte trouvée')
           // :
           Expanded(
            child: ListView.builder(
                itemCount: _pokemonCards.length,
                itemBuilder: (context, index) {
                  final PokemonCard pokemonCard = _pokemonCards[index];
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        width: 350,
                        // height: ,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(
                              color: Colors.redAccent
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: ListTile(
                            title: CachedNetworkImage(
                              imageUrl: pokemonCard.image,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Text(pokemonCard.name, style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.redAccent)),
                                      ),
                                      Text('HP : ${pokemonCard.hp}', textAlign: TextAlign.start),
                                      Text('Niveau : ${pokemonCard.niveau ?? 'inconnu'}', textAlign: TextAlign.start),
                                      Text('Type : ${pokemonCard.type ?? 'inconnu'}',textAlign: TextAlign.start),
                                      Text('Évolution : ${pokemonCard.evolution ?? 'inconnu'}', textAlign: TextAlign.start),

                                    ],
                                  ),
                                  Container(
                                      width: 150,
                                      margin: const EdgeInsets.only(top: 10.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          final PokemonCard newPokemonCard = PokemonCard(
                                              pokemonCard.name,
                                              pokemonCard.hp,
                                              pokemonCard.image,
                                              pokemonCard.niveau,
                                              pokemonCard.type,
                                              pokemonCard.evolution
                                          );
                                          Provider.of<PokemonCardCubit>(context, listen: false).addFavori(pokemonCard);
                                          Navigator.of(context).pop(newPokemonCard);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text('Ajouter aux favoris', textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}