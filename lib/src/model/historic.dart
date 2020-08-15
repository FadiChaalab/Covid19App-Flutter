import 'dart:convert';

List<Historic> historicFromJson(String str) =>
    List<Historic>.from(json.decode(str).map((x) => Historic.fromJson(x)));

String historicToJson(List<Historic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Historic {
  String country;
  String province;
  Timeline timeline;

  Historic({
    this.country,
    this.province,
    this.timeline,
  });

  factory Historic.fromJson(Map<String, dynamic> json) => Historic(
        country: json["country"],
        province: json["province"] == null ? null : json["province"],
        timeline: Timeline.fromJson(json["timeline"]),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "province": province == null ? null : province,
        "timeline": timeline.toJson(),
      };
}

class Timeline {
  Map<String, int> cases;
  Map<String, int> deaths;
  Map<String, int> recovered;

  Timeline({
    this.cases,
    this.deaths,
    this.recovered,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        cases:
            Map.from(json["cases"]).map((k, v) => MapEntry<String, int>(k, v)),
        deaths:
            Map.from(json["deaths"]).map((k, v) => MapEntry<String, int>(k, v)),
        recovered: Map.from(json["recovered"])
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "cases": Map.from(cases).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "deaths":
            Map.from(deaths).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "recovered":
            Map.from(recovered).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
