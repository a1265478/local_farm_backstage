import 'dart:convert';

class Service {
  final String id;
  final String type;
  final String title;
  final String content;
  final int price;

  const Service({
    this.id = "",
    this.type = "LINE",
    this.title = "",
    this.content = "",
    this.price = 999999,
  });

  static const Service empty = Service();

  Service copyWith({
    String? id,
    String? type,
    String? title,
    String? content,
    int? price,
  }) {
    return Service(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'title': title,
      'content': content,
      'price': price,
    };
  }

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Service(id: $id,type: $type, title: $title, content: $content, price: $price)';
  }
}
