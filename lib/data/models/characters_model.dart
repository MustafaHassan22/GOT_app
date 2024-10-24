class Character {
  late int charId;
  late String name;
  late String firstName;
  late String lastName;
  late String title;
  late String family;
  late String imageUrl;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['id'];
    name = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    title = json['title'];
    family = json['family'];
    imageUrl = json['imageUrl'];
  }
}
