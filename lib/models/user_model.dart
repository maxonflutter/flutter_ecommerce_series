import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String fullName;
  final String email;
  final String address;
  final String city;
  final String country;
  final String zipCode;

  const User({
    this.id,
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.zipCode = '',
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? address,
    String? city,
    String? country,
    String? zipCode,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, [
    String? id,
  ]) {
    return User(
      id: id ?? json['id'],
      fullName: json['fullName'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fullName': fullName,
      'email': email,
      'address': address,
      'city': city,
      'country': country,
      'zipCode': zipCode
    };
  }

  static const empty = User(id: '');

  @override
  List<Object?> get props =>
      [id, fullName, email, address, city, country, zipCode];
}
