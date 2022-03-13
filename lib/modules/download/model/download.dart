import 'dart:convert';

class Download {
  final String id;
  final String filename;
  Download({
    required this.id,
    required this.filename,
  });

  Download copyWith({
    String? id,
    String? filename,
  }) {
    return Download(
      id: id ?? this.id,
      filename: filename ?? this.filename,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'filename': filename,
    };
  }

  factory Download.fromJson(Map<String, dynamic> map) {
    return Download(
      id: map['id'] as String,
      filename: map['filename'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Download(id: $id, filename: $filename)';
}
