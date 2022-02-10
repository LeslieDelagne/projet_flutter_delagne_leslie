import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:projet_flutter_delagne_leslie/repository/favoris_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavorisListe extends StatefulWidget {
  FavorisListe({Key? key}) : super(key: key);

  final FavorisRepository favorisRepository = FavorisRepository();

  @override
  State<FavorisListe> createState() => _FavorisListeState();
}

class _FavorisListeState extends State<FavorisListe> {

  List<PokemonCard> _pokemonCards = [];

  @override
  void initState() {
    widget.favorisRepository.loadPokemonCards().then((pokemonCards) {
      _setPokemonCards(pokemonCards);
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
        title: const Text('Ma wishList'),
      ),
      body: _pokemonCards.isEmpty ? const Text("Pas de cartes") : ListView.builder(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(pokemonCard.name, style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.redAccent)),
                            ),
                            Text('HP : ${pokemonCard.hp}', textAlign: TextAlign.start),
                            Text('Niveau : ${pokemonCard.niveau ?? 'inconnu'}', textAlign: TextAlign.start),
                            Text('Type : ${pokemonCard.type ?? 'inconnu'}',textAlign: TextAlign.start),
                            Text('Évolution : ${pokemonCard.evolution ?? 'inconnu'}', textAlign: TextAlign.start),

                          ],
                        ),
                      )
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              heroTag: 'btn_add',
              onPressed: () async {
                final PokemonCard? pokemonCard = await Navigator.of(context).pushNamed('/searchPokemonCard') as PokemonCard?;
                if(pokemonCard != null) {
                  setState(() {
                    _pokemonCards.add(pokemonCard);
                  });
                  widget.favorisRepository.savePokemonCards(_pokemonCards);

                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Ajouter une carte'),
            ),
            FloatingActionButton.extended(
              heroTag: 'btn_delete_all',
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Vider la wishlist ?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final wishlist = await SharedPreferences.getInstance();
                        await wishlist.clear();
                        setState(() {
                          _pokemonCards = [];
                        });
                        Navigator.pop(context, 'Cancel');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              label: Text('Vider la wishlist'),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      )
    );
  }
}