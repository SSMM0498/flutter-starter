// lib/features/device/services/device_access_service.dart
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starter/common/widgets/loaders/loaders.dart';

class DeviceAccessService extends GetxController {
  static DeviceAccessService get instance => Get.find();

  /// --- Image Picker --- ///
  /// Picks an image from the gallery. Returns the XFile or null.
  Future<XFile?> pickImageFromGallery() async {
    try {
      // Request permission
      if (!await _handlePermission(Permission.photos)) return null;

      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
      return image;
    } on PlatformException catch (e) {
      Loaders.errorSnackBar(title: 'Platform Error', message: 'Failed to pick image: ${e.message}');
      return null;
    }
  }

  /// Captures an image with the camera. Returns the XFile or null.
  Future<XFile?> takePictureWithCamera() async {
    try {
      // Request permission
      if (!await _handlePermission(Permission.camera)) return null;

      final image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 70);
      return image;
    } on PlatformException catch (e) {
      Loaders.errorSnackBar(title: 'Platform Error', message: 'Failed to take picture: ${e.message}');
      return null;
    }
  }

  /// --- Geolocation --- //
  /// Gets the current device location. Returns a Position object or null.
  /// Handles all permission checks and service enabling internally.
  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled on the device
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Loaders.warningSnackBar(title: 'Location Services Disabled', message: 'Please enable location services on your device.');
        // Optionally, prompt the user to open settings
        // await Geolocator.openLocationSettings();
        return null;
      }

      // Check and request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Loaders.warningSnackBar(title: 'Location Permission Denied', message: 'Location permission is required to use this feature.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Loaders.warningSnackBar(title: 'Location Permission Denied Permanently', message: 'Please enable location permissions in your device settings.');
        // Optionally, prompt the user to open app settings
        // await openAppSettings();
        return null;
      }

      // If permissions are granted, get the current position
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Location Error', message: 'Failed to get current location: $e');
      return null;
    }
  }


  /// --- Private Helper --- //
  /// Generic permission handler for simple permissions like camera or photos.
  Future<bool> _handlePermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      return true;
    }
    if (status.isDenied) {
      Loaders.warningSnackBar(title: 'Permission Denied', message: 'This permission is required to proceed.');
      return false;
    }
    if (status.isPermanentlyDenied) {
      Loaders.warningSnackBar(title: 'Permission Denied Permanently', message: 'Please enable this permission in your device settings.');
      openAppSettings();
      return false;
    }
    return false;
  }
}