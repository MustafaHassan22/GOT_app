class CharacterContinent {
  late String name;

  CharacterContinent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
