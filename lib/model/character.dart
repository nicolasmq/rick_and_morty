// To parse this JSON data, do
//
//     final character = characterFromMap(jsonString);

import 'dart:convert';

class Character {
  final Info? info;
  final List<CharacterData>? characterDataList;

  Character({
    this.info,
    this.characterDataList,
  });

  Character copyWith({
    Info? info,
    List<CharacterData>? results,
  }) =>
      Character(
        info: info ?? this.info,
        characterDataList: results ?? this.characterDataList,
      );

  factory Character.fromJson(String str) => Character.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Character.fromMap(Map<String, dynamic> json) => Character(
    info: json["info"] == null ? null : Info.fromMap(json["info"]),
    characterDataList: json["results"] == null ? [] : List<CharacterData>.from(json["results"]!.map((x) => CharacterData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "info": info?.toMap(),
    "results": characterDataList == null ? [] : List<dynamic>.from(characterDataList!.map((x) => x.toMap())),
  };
}

class Info {
  final int? count;
  final int? pages;
  final String? next;
  final dynamic prev;

  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  Info copyWith({
    int? count,
    int? pages,
    String? next,
    dynamic prev,
  }) =>
      Info(
        count: count ?? this.count,
        pages: pages ?? this.pages,
        next: next ?? this.next,
        prev: prev ?? this.prev,
      );

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
    prev: json["prev"],
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "pages": pages,
    "next": next,
    "prev": prev,
  };
}

class CharacterData {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Location? origin;
  final Location? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final DateTime? created;

  CharacterData({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  CharacterData copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    Location? origin,
    Location? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) =>
      CharacterData(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        species: species ?? this.species,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        origin: origin ?? this.origin,
        location: location ?? this.location,
        image: image ?? this.image,
        episode: episode ?? this.episode,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory CharacterData.fromJson(String str) => CharacterData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CharacterData.fromMap(Map<String, dynamic> json) => CharacterData(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    type: json["type"],
    gender: json["gender"],
    origin: json["origin"] == null ? null : Location.fromMap(json["origin"]),
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    image: json["image"],
    episode: json["episode"] == null ? [] : List<String>.from(json["episode"]!.map((x) => x)),
    url: json["url"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "type": type,
    "gender": gender,
    "origin": origin?.toMap(),
    "location": location?.toMap(),
    "image": image,
    "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
    "url": url,
    "created": created?.toIso8601String(),
  };
}

class Location {
  final String? name;
  final String? url;

  Location({
    this.name,
    this.url,
  });

  Location copyWith({
    String? name,
    String? url,
  }) =>
      Location(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "url": url,
  };
}
