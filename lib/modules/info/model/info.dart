import 'dart:convert';

class Info {
  final String email;
  final String address;
  final String mobilePhone;
  final String phone;

  const Info({
    this.email = "",
    this.address = "",
    this.mobilePhone = "",
    this.phone = "",
  });

  static const empty = Info();

  Info copyWith({
    String? email,
    String? address,
    String? mobilePhone,
    String? phone,
  }) {
    return Info(
      email: email ?? this.email,
      address: address ?? this.address,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'address': address,
      'mobilePhone': mobilePhone,
      'phone': phone,
    };
  }

  factory Info.fromJson(Map<String, dynamic> map) {
    return Info(
      email: map['email'] as String,
      address: map['address'] as String,
      mobilePhone: map['mobilePhone'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Info( email: $email, address: $address, mobilePhone: $mobilePhone, phone: $phone)';
  }
}
