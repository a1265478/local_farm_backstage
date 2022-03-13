import 'dart:convert';

class Info {
  final String sendEmail;
  final String email;
  final String address;
  final String mobilePhone;
  final String phone;

  const Info({
    this.sendEmail = "",
    this.email = "",
    this.address = "",
    this.mobilePhone = "",
    this.phone = "",
  });

  static const empty = Info();

  Info copyWith({
    String? sendEmail,
    String? email,
    String? address,
    String? mobilePhone,
    String? phone,
  }) {
    return Info(
      sendEmail: sendEmail ?? this.sendEmail,
      email: email ?? this.email,
      address: address ?? this.address,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sendEmail': sendEmail,
      'email': email,
      'address': address,
      'mobilePhone': mobilePhone,
      'phone': phone,
    };
  }

  factory Info.fromJson(Map<String, dynamic> map) {
    return Info(
      sendEmail: map['sendEmail'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      mobilePhone: map['mobilePhone'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Info(sendEmail: $sendEmail, email: $email, address: $address, mobilePhone: $mobilePhone, phone: $phone)';
  }
}
