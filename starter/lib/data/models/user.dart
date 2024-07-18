import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/utils/formatter.dart';

class UserModel {
  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? collectionId;
  final String? collectionName;
  String? avatar;
  String email;
  final bool? emailVisibility;
  String firstName;
  String lastName;
  String phoneNumber;
  final String? username;
  final bool? verified;
  final String? role; // Added role field
  String? token;

  UserModel({
    required this.id,
    required this.created,
    required this.updated,
    required this.collectionId,
    required this.collectionName,
    required this.avatar,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailVisibility,
    required this.username,
    required this.verified,
    required this.role, // Added role parameter
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    debugPrintStack(label: '❓ --user-- $json');
    return UserModel(
      id: json["id"] ?? "",
      created: DateTime.tryParse(json["created"] ?? ""),
      updated: DateTime.tryParse(json["updated"] ?? ""),
      collectionId: json["collectionId"] ?? "",
      collectionName: json["collectionName"] ?? "",
      avatar: json["avatar"] ?? "",
      email: json["email"] ?? "",
      emailVisibility: json["emailVisibility"] ?? "",
      phoneNumber: json['phoneNumber'] ?? "" ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      username: json["username"] ?? "",
      verified: json["verified"] ?? "",
      role: json["role"] ?? "",
      token: json["token"] ?? "",
    );
  }

  // empty method
  static UserModel empty() {
    return UserModel(
      id: "",
      created: DateTime.now(),
      updated: DateTime.now(),
      collectionId: "",
      collectionName: "",
      avatar: "",
      email: "",
      emailVisibility: false,
      phoneNumber: "",
      firstName: "",
      lastName: "",
      username: "",
      verified: false,
      role: "", // Initialize role to empty string
      token: "",
    );
  }

  Uri? get profilePicUrl {
    if (avatar?.isNotEmpty ?? false) {
      return PocketBaseSingleton().client.getFileUrl(
            RecordModel(
              id: id ?? "",
              collectionId: collectionId ?? "",
              collectionName: collectionName ?? "",
            ),
            avatar!,
          );
    }
    return null;
  }

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => Formatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split(" ");

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "created": created?.toIso8601String(),
      "updated": updated?.toIso8601String(),
      "collectionId": collectionId,
      "collectionName": collectionName,
      "avatar": avatar,
      "email": email,
      "emailVisibility": emailVisibility,
      'firstName': firstName,
      'lastName': lastName,
      "username": username,
      "verified": verified,
      "role": role, // Include role in JSON serialization
      "token": token,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
