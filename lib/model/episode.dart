// To parse this JSON data, do
//
//     final episode = episodeFromMap(jsonString);

import 'dart:convert';

class Episode {
  final int? id;
  final String? name;
  final String? airDate;
  final String? episode;
  final List<String>? characters;
  final String? url;
  final DateTime? created;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  Episode copyWith({
    int? id,
    String? name,
    String? airDate,
    String? episode,
    List<String>? characters,
    String? url,
    DateTime? created,
  }) =>
      Episode(
        id: id ?? this.id,
        name: name ?? this.name,
        airDate: airDate ?? this.airDate,
        episode: episode ?? this.episode,
        characters: characters ?? this.characters,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory Episode.fromJson(String str) => Episode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
    id: json["id"],
    name: json["name"],
    airDate: json["air_date"],
    episode: json["episode"],
    characters: json["characters"] == null ? [] : List<String>.from(json["characters"]!.map((x) => x)),
    url: json["url"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "air_date": airDate,
    "episode": episode,
    "characters": characters == null ? [] : List<dynamic>.from(characters!.map((x) => x)),
    "url": url,
    "created": created?.toIso8601String(),
  };
}
