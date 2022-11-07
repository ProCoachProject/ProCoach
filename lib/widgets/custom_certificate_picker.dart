import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_coach/models/coach.dart';

class CustomCertificatePicker extends StatefulWidget {
  CustomCertificatePicker({Key? key}) : super(key: key);

  @override
  State<CustomCertificatePicker> createState() =>
      _CustomCertificatePickerState();
}

class _CustomCertificatePickerState extends State<CustomCertificatePicker> {
  final ImagePicker _picker = ImagePicker();

  XFile? image = null;

  Future<void> addCertificate() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
    if (image != null) {
      Coach.certificateImage = File(image!.path);
      Coach.certificateImageName = image!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.grey.withOpacity(0.4),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: addCertificate,
        splashColor: Color(0xff06283D).withOpacity(0.4),
        highlightColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          width: 1920 / 4,
          height: 1080 / 4,
          child: image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Your Certificate',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff06283D),
                      ),
                    ),
                    Icon(
                      Icons.add_box_rounded,
                      color: Color(0xff06283D),
                      size: 50,
                    ),
                  ],
                )
              : Image(
                  image: FileImage(File(image!.path)),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
