import 'dart:convert';

class PokemonCard {
  String name;
  String hp;
  String image;
  String? niveau;
  String? type;
  String? evolution;

  @override
  String toString() {
    return 'Pokemon{name: $name, hp: $hp, image: $image, niveau: $niveau, type: $type, evolution: $evolution}';
  }

  PokemonCard(this.name, this.hp, this.image, this.niveau, this.type, this.evolution);


  factory PokemonCard.fromCardJson(Map<String, dynamic> json) {
    final String name = json['name'];
    final String hp = json ['hp'];
    final String image = json['images']['small'];
    final String? niveau = json['level'];
    final String? type = json['types'][0];
    final List<dynamic> evolutionList = json['evolvesTo'] ?? [];
    final String? evolution = evolutionList.isEmpty ? null : evolutionList[0];

    return PokemonCard(name, hp, image, niveau, type, evolution);
  }

  String toJson() {
    return jsonEncode({
      'name': name,
      'hp': hp,
      'image': image,
      'niveau': niveau,
      'type': type,
      'evolution': evolution,

    });
  }

  factory PokemonCard.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return PokemonCard(
      map['name'],
      map['hp'],
      map['image'],
      map['niveau'],
      map['type'],
      map['evolution'],
    );
  }
}