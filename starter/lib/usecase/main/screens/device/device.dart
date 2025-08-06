import 'dart:io';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:image_picker/image_picker.dart';
import 'package:starter/core/services/device/device_access_service.dart';

class DeviceAccessTestScreen extends StatefulWidget {
  const DeviceAccessTestScreen({super.key});

  @override
  State<DeviceAccessTestScreen> createState() => _DeviceAccessTestScreenState();
}

class _DeviceAccessTestScreenState extends State<DeviceAccessTestScreen> {
  // State variables to hold the results from the service
  XFile? _imageFile;
  Position? _currentPosition;
  String _errorMessage = '';

  // Get an instance of our service
  final DeviceAccessService _deviceAccessService = DeviceAccessService.instance;

  // --- Methods to call the service and update the UI ---

  Future<void> _pickImage() async {
    final file = await _deviceAccessService.pickImageFromGallery();
    if (file != null) {
      setState(() {
        _imageFile = file;
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'Image picking was cancelled or failed.';
      });
    }
  }

  Future<void> _takePicture() async {
    final file = await _deviceAccessService.takePictureWithCamera();
    if (file != null) {
      setState(() {
        _imageFile = file;
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'Taking a picture was cancelled or failed.';
      });
    }
  }

  Future<void> _getLocation() async {
    final position = await _deviceAccessService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _currentPosition = position;
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'Fetching location failed or was denied.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Access Test'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Action Buttons ---
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Picture with Camera'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _getLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Get Current Location'),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // --- Results Display Area ---
              const Text('Results:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Display error message if any
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),

              // Display the selected image
              if (_imageFile != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selected Image:', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Image.file(File(_imageFile!.path), height: 200),
                    const SizedBox(height: 8),
                    Text('Path: ${_imageFile!.path}', style: const TextStyle(fontSize: 12)),
                  ],
                ),

              const SizedBox(height: 16),

              // Display the location data
              if (_currentPosition != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Location:', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('Latitude: ${_currentPosition!.latitude}'),
                    Text('Longitude: ${_currentPosition!.longitude}'),
                    Text('Accuracy: ${_currentPosition!.accuracy.toStringAsFixed(2)}m'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
