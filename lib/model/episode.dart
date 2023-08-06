// To parse this JSON data, do
//
//     final episode = episodeFromMap(jsonString);

import 'dart:convert';

class Episode {
  final Info? info;
  final List<EpisodeData>? episodeDataList;

  Episode({
    this.info,
    this.episodeDataList,
  });

  Episode copyWith({
    Info? info,
    List<EpisodeData>? results,
  }) =>
      Episode(
        info: info ?? this.info,
        episodeDataList: results ?? this.episodeDataList,
      );

  factory Episode.fromJson(String str) => Episode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
    info: json["info"] == null ? null : Info.fromMap(json["info"]),
    episodeDataList: json["results"] == null ? [] : List<EpisodeData>.from(json["results"]!.map((x) => EpisodeData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "info": info?.toMap(),
    "results": episodeDataList == null ? [] : List<dynamic>.from(episodeDataList!.map((x) => x.toMap())),
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

class EpisodeData {
  final int? id;
  final String? name;
  final String? airDate;
  final String? episode;
  final List<String>? characters;
  final String? url;
  final DateTime? created;

  EpisodeData({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  EpisodeData copyWith({
    int? id,
    String? name,
    String? airDate,
    String? episode,
    List<String>? characters,
    String? url,
    DateTime? created,
  }) =>
      EpisodeData(
        id: id ?? this.id,
        name: name ?? this.name,
        airDate: airDate ?? this.airDate,
        episode: episode ?? this.episode,
        characters: characters ?? this.characters,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory EpisodeData.fromJson(String str) => EpisodeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EpisodeData.fromMap(Map<String, dynamic> json) => EpisodeData(
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
