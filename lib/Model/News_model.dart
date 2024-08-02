

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  String? status;
  int? totalResults;
  List<Article>? articles;

  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source!.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt!.toIso8601String(),
    "content": content,
  };
}

class Source {
  Id? id;
  Name? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: idValues.map[json["id"]],
    name: nameValues.map[json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": idValues.reverse[id],
    "name": nameValues.reverse[name],
  };
}

enum Id {
  FOX_NEWS,
  GOOGLE_NEWS,
  THE_WASHINGTON_POST
}

final idValues = EnumValues({
  "fox-news": Id.FOX_NEWS,
  "google-news": Id.GOOGLE_NEWS,
  "the-washington-post": Id.THE_WASHINGTON_POST
});

enum Name {
  FOX_BUSINESS,
  FOX_NEWS,
  GOOGLE_NEWS,
  THE_WASHINGTON_POST
}

final nameValues = EnumValues({
  "Fox Business": Name.FOX_BUSINESS,
  "Fox News": Name.FOX_NEWS,
  "Google News": Name.GOOGLE_NEWS,
  "The Washington Post": Name.THE_WASHINGTON_POST
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
