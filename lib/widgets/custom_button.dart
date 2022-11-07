import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.child,
    required this.width,
    required this.height,
    required this.onPress,
    this.borderRadius = 20,
  });

  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color(0xff06283D),
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPress,
        splashColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.transparent,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
