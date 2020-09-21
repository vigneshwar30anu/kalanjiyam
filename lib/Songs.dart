// To parse this JSON data, do
//
//     final songList = songListFromJson(jsonString);

import 'dart:convert';

List<SongList> songListFromJson(String str) =>
    List<SongList>.from(json.decode(str).map((x) => SongList.fromJson(x)));

String songListToJson(List<SongList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongList {
  SongList({
    this.id,
    this.categoryId,
    this.image,
    this.author,
    this.songName,
    this.songUrl,
    this.publishedOn,
    this.shortDescription,
  });

  String id;
  String categoryId;
  String image;
  String author;
  String songName;
  String songUrl;
  DateTime publishedOn;
  String shortDescription;

  factory SongList.fromJson(Map<String, dynamic> json) => SongList(
        id: json["id"],
        categoryId: json["category_id"],
        image: json["image"],
        author: json["author"],
        songName: json["song_name"],
        songUrl: json["song_url"],
        publishedOn: DateTime.parse(json["published_on"]),
        shortDescription: json["short_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "image": image,
        "author": author,
        "song_name": songName,
        "song_url": songUrl,
        "published_on":
            "${publishedOn.year.toString().padLeft(4, '0')}-${publishedOn.month.toString().padLeft(2, '0')}-${publishedOn.day.toString().padLeft(2, '0')}",
        "short_description": shortDescription,
      };
}
