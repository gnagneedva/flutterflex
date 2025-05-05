// ignore_for_file: public_member_api_docs, sort_constructors_first

class Person {
  final String name;
  final String? imageURL;
  final String characterName;
  Person({required this.name, this.imageURL, required this.characterName});

  Person copyWith({String? name, String? imageURL, String? characterName}) {
    return Person(
      name: name ?? this.name,
      imageURL: imageURL ?? this.imageURL,
      characterName: characterName ?? this.characterName,
    );
  }

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      name: map['name'] as String,
      imageURL: map['imageURL'] != null ? map['profile_path'] as String : null,
      characterName: map['character'] as String,
    );
  }
}
