import 'dart:convert';

import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String brandIntroduction;
  final String designIntroduction;
  final String webUrl;
  final List<String> imageList;

  const Customer({
    this.id = "",
    this.name = "",
    this.brandIntroduction = "",
    this.designIntroduction = "",
    this.webUrl = "",
    this.imageList = const [],
  });

  static const Customer empty = Customer();

  Customer copyWith({
    String? id,
    String? name,
    String? brandIntroduction,
    String? designIntroduction,
    String? webUrl,
    List<String>? imageList,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      brandIntroduction: brandIntroduction ?? this.brandIntroduction,
      designIntroduction: designIntroduction ?? this.designIntroduction,
      webUrl: webUrl ?? this.webUrl,
      imageList: imageList ?? this.imageList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'brandIntroduction': brandIntroduction,
      'designIntroduction': designIntroduction,
      'webUrl': webUrl,
    };
  }

  factory Customer.fromJson(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      name: map['name'] as String,
      brandIntroduction: map['brandIntroduction'] as String,
      designIntroduction: map['designIntroduction'] as String,
      webUrl: map['webUrl'] as String,
      imageList: const [],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, brandIntroduction: $brandIntroduction, designIntroduction: $designIntroduction, webUrl: $webUrl, imageList: $imageList)';
  }

  @override
  List<Object?> get props =>
      [id, name, brandIntroduction, designIntroduction, webUrl, imageList];
}
