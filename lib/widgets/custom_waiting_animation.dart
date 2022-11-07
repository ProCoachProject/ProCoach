import 'package:flutter/material.dart';

class CustomWaitingAnimation extends StatelessWidget {
  const CustomWaitingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Color(0xff06283D),
      ),
    );
  }
}
