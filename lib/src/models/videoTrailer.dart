// To parse this JSON data, do
//
//     final videoTrailer = videoTrailerFromJson(jsonString);

import 'dart:convert';

VideoTrailer videoTrailerFromJson(String str) =>
    VideoTrailer.fromJson(json.decode(str));

String videoTrailerToJson(VideoTrailer data) => json.encode(data.toJson());

class VideoTrailer {
  VideoTrailer({
    this.id,
    this.results,
  });

  int id;
  List<Resultv> results;

  factory VideoTrailer.fromJson(Map<String, dynamic> json) => VideoTrailer(
        id: json["id"],
        results:
            List<Resultv>.from(json["results"].map((x) => Resultv.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Resultv {
  Resultv({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  factory Resultv.fromJson(Map<String, dynamic> json) => Resultv(
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        key: json["key"],
        name: json["name"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "key": key,
        "name": name,
        "site": site,
        "size": size,
        "type": type,
      };
}
