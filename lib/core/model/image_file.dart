class ImageFile {
  final String filename;
  final String base64;
  ImageFile({
    required this.filename,
    required this.base64,
  });

  ImageFile copyWith({
    String? filename,
    String? base64,
  }) {
    return ImageFile(
      filename: filename ?? this.filename,
      base64: base64 ?? this.base64,
    );
  }

  factory ImageFile.fromJson(Map<String, dynamic> map) {
    return ImageFile(
      filename: map["filename"] as String,
      base64: map["base64"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'filename': filename,
        'base64': base64,
      };
}
