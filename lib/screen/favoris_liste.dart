import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter_delagne_leslie/blocs/pokemon_card_cubit.dart';
import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';
import 'package:provider/provider.dart';

class FavorisListe extends StatelessWidget {

  const FavorisListe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes favoris'),
      ),
      body: BlocBuilder<PokemonCardCubit, List<PokemonCard>>(
  builder: (context, state) {
    return ListView.builder(
          itemCount: state.length,
          itemBuilder: (BuildContext context, int index) {
            PokemonCard pokemonCard = state[index];
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
          });
  },
),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              heroTag: 'btn_add',
              onPressed: () async {
                Navigator.of(context).pushNamed('/searchPokemonCard');
              },
              child: const Icon(Icons.add),
            ),
          ),
          FloatingActionButton(
            heroTag: 'btn_delete_all',
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Vider les favoris ?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Provider.of<PokemonCardCubit>(context, listen: false).clearFavoris();
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Icon(Icons.delete),
          ),
        ],
      )
    );
  }
}