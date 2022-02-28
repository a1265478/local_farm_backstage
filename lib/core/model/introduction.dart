class Introduction {
  final String id;
  final String title;
  final String items;

  const Introduction({
    this.id = "",
    this.title = "",
    this.items = "",
  });

  static const Introduction empty = Introduction(
    id: "",
    title: "",
    items: "",
  );

  Introduction copyWith({String? id, String? title, String? items}) {
    return Introduction(
      id: id ?? this.id,
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }

  factory Introduction.fromJson(Map<String, dynamic> map) {
    return Introduction(
      id: map["id"],
      title: map["title"],
      items: map["items"],
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "items": items};
}
