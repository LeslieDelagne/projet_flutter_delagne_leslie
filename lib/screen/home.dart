import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_delagne_leslie/models/pokemon_card.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokéCard Collection')
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://www.neitsabes.fr/wp-content/uploads/2018/12/Je-collectionne-les-cartes-Pok%C3%A9mon-0.jpg',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text('Retrouve sur cette appli l\'ensemble des cartes pokemon, et ajoute celles qui te manque à ta wishlist ! ',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final PokemonCard? pokemon = await Navigator.of(context).pushNamed(
                            '/favorisListe',
                          ) as PokemonCard?;
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Voir ma Wishlist'),
                        )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}