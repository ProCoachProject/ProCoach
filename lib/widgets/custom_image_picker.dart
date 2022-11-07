import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_coach/models/coach.dart';

class CustomImagePicker extends StatefulWidget {
  CustomImagePicker({this.title = 'Add Your Picture'});

  final String title;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();

  XFile? image = null;

  Future<void> addImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
    if (image != null) {
      Coach.imageFile = File(image!.path);
      Coach.imageFileName = image!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.grey.withOpacity(0.4),
      borderRadius: BorderRadius.circular(1000),
      child: InkWell(
        onTap: addImage,
        splashColor: Color(0xff06283D).withOpacity(0.4),
        highlightColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 200,
          child: image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
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
