import 'package:starter/utils/formatter.dart';

class AddressModel {
  String id;
  String? user;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  bool selectedAddress;

  AddressModel({
    required this.id,
    this.user,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.selectedAddress = false,
  });

  String get formattedPhoneNo => Formatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(id: '', name: '', phoneNumber: '', street: '', city: '', state: '', postalCode: '', country: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': [user],
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'selectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      name: json['name'] as String,
      user: json['user'] ?? '',
      phoneNumber: json['phoneNumber'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      selectedAddress: json['selectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}
