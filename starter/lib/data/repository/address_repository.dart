import 'dart:convert';

import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/data/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final PocketBase pb = PocketBaseSingleton().client;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = pb.authStore.model.id!;
      if (userId.isEmpty) throw "Unable to find user information. Try again in few minutes.";

      final result = await pb.collection('users').getOne(
            userId,
            expand: 'addresses',
          );
      final addresses = result.expand['addresses'];
      if (addresses != null) {
        return addresses.map((address) {
          final ad = AddressModel.fromJson(json.decode(json.encode(address)));
          return ad;
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw "Something went wrong while saving Address Information. Try again later $e";
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      await pb.collection('addresses').update(addressId, body: {'selectedAddress': selected});
    } catch (e) {
      throw "Unable to update your address selection. Try again later. $e";
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = pb.authStore.model.id!;
      address.user = userId;
      final currentAddress = await pb.collection('addresses').create(body: address.toJson());
      final addressId = currentAddress.id;
      await pb.collection('users').update(userId, body: {
        'addresses+': addressId,
      });
      return addressId;
    } catch (e) {
      throw "Something went wrong while saving Address Information. Try again later $e";
    }
  }
}
