import 'package:flutter/material.dart';

import '../services/location_service.dart';
import 'custom_button.dart';

class CustomLocationPicker extends StatefulWidget {
  const CustomLocationPicker({Key? key}) : super(key: key);

  @override
  State<CustomLocationPicker> createState() => _CustomLocationPickerState();
}

class _CustomLocationPickerState extends State<CustomLocationPicker> {
  Widget locationStatus = Text(
    'Take My Gym Location',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  Future<void> getLocation() async {
    setState(() {
      locationStatus = CircularProgressIndicator(color: Colors.white);
    });
    await Future.delayed(Duration(seconds: 2));
    String response = await LocationService.getCurrentLocation();
    setState(() {
      locationStatus = Text(
        response,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: locationStatus,
      width: 300,
      height: 50,
      onPress: getLocation,
    );
  }
}
