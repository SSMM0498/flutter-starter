import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/utils/formatter.dart';

enum Gender { man, woman }

class UserModel {
  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? collectionId;
  final String? collectionName;
  String? avatar;
  String? avatarUrl;
  String email;
  final bool? emailVisibility;
  String firstName;
  String lastName;
  String phoneNumber;
  Gender? gender;
  DateTime? dateOfBirth;
  String username;
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
    required this.avatarUrl,
    required this.email,
    this.gender,
    this.dateOfBirth,
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
    return UserModel(
      id: json["id"] ?? "",
      created: DateTime.tryParse(json["created"] ?? ""),
      updated: DateTime.tryParse(json["updated"] ?? ""),
      collectionId: json["collectionId"] ?? "",
      collectionName: json["collectionName"] ?? "",
      avatar: json["avatar"] ?? "",
      avatarUrl: json["avatarUrl"] ?? "",
      email: json["email"] ?? "",
      gender: json["gender"].isNotEmpty
          ? Gender.values.firstWhere(
              (el) {
                return el.toString().split('.').last == json["gender"];
              },
            )
          : null,
      dateOfBirth: json["dateOfBirth"] != null && json["dateOfBirth"].isNotEmpty ? DateFormat("yyyy-MM-dd hh:mm:ss").parse(json["dateOfBirth"]) : null,
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
      avatarUrl: "",
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
          avatar!);
    } else if (avatarUrl?.isNotEmpty ?? false) {
      return Uri.parse(avatarUrl!);
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
      "avatarUrl": avatarUrl,
      "email": email,
      "gender": gender?.toString().split('.').last, // Convert gender enum to string
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
