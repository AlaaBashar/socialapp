import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool? showForegroundImage;
  final bool? showBackgroundImage;
  final String? backgroundImageUrl;
  final String? foregroundImageUrl;
  final double? radius;
  final double? minRadius;
  final double? maxRadius;

  const CircleAvatarWidget({
    Key? key,
    this.child,
    this.backgroundColor,
    this.backgroundImageUrl,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.foregroundColor = Colors.black,
    this.showForegroundImage = false,
    this.foregroundImageUrl,
    this.showBackgroundImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? Colors.amber,
      backgroundImage:showBackgroundImage! ? NetworkImage('$backgroundImageUrl') : null,
      minRadius:minRadius,
      maxRadius:maxRadius,
      foregroundColor: foregroundColor,
      foregroundImage: showForegroundImage! ? NetworkImage('$foregroundImageUrl') : null,
      radius: radius,
      child: child,
    );
  }
}
