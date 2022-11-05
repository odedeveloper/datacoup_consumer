import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.items,
    this.lastEvaluatedKey,
  });

  List<Item>? items;
  String? lastEvaluatedKey;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        lastEvaluatedKey: json["LastEvaluatedKey"],
      );

  Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "LastEvaluatedKey": lastEvaluatedKey,
      };
}

class Item {
  Item({
    this.content,
    this.location,
    this.newsType,
    this.headerMultimedia,
    this.source,
    this.timeStamp,
    this.isFavourite = false,
    this.description,
    this.newsId,
    this.title,
  });

  Content? content;
  Location? location;
  String? newsType;
  String? headerMultimedia;
  String? source;
  DateTime? timeStamp;
  bool? isFavourite;
  String? description;
  String? newsId;
  String? title;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        content: Content.fromJson(json["content"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        newsType: json["newsType"],
        headerMultimedia: json["headerMultimedia"],
        source: json["source"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        description: json["description"],
        newsId: json["newsId"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "content": content!.toJson(),
        "location": location == null ? null : location!.toJson(),
        "newsType": newsType,
        "headerMultimedia": headerMultimedia,
        "source": source,
        "timeStamp": timeStamp!.toIso8601String(),
        "description": description,
        "newsId": newsId,
        "title": title,
      };
}

class Content {
  Content({
    this.link,
    this.creator,
  });

  String? link;
  String? creator;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        link: json["link"],
        creator: json["creator"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "creator": creator,
      };
}

class Location {
  Location({
    this.country,
    this.state,
    this.zipCode,
    this.tags,
  });

  List<String>? country;
  List<String>? state;
  String? zipCode;
  List<String>? tags;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        country: json["country"] == null
            ? null
            : List<String>.from(json["country"].map((x) => x)),
        state: json["state"] == null
            ? null
            : List<String>.from(json["state"].map((x) => x)),
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "country":
            country == null ? null : List<dynamic>.from(country!.map((x) => x)),
        "state":
            state == null ? null : List<dynamic>.from(state!.map((x) => x)),
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
      };
}
