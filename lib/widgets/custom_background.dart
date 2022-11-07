import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: -600,
            right: -500,
            child: CircleAvatar(
              backgroundColor: Color(0xff06283D).withOpacity(0.15),
              radius: 550,
            ),
          ),
        ],
      ),
    );
  }
}
