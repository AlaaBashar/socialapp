import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Color? boxShadowColor;
  final double? spreadShadowRadius;
  final double? blurShadowRadius;
  final bool? showShadow;
  final bool? showGradient;
  final bool? showAddImage;
  final String? imageUrl;
  final BoxFit? imageFit;
  final AlignmentGeometry? imageAlign;
  final BlurStyle? blurShadowStyle;
  final bool? showBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? imageScale;
  final AlignmentGeometry? beginGradientAlign;
  final AlignmentGeometry? endGradientAlign;
  final List<Color>? gradientColorsList;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;

  const ContainerWidget({
    Key? key,
    this.height,
    this.width,
    this.child,
    this.alignment,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius,
    this.boxShadowColor,
    this.spreadShadowRadius=0.0,
    this.blurShadowRadius = 0.0,
    this.showShadow = false,
    this.blurShadowStyle,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.beginGradientAlign,
    this.endGradientAlign,
    this.showGradient = false,
    this.gradientColorsList,
    this.showAddImage = false,
    this.imageUrl,
    this.imageFit,
    this.imageAlign,
    this.imageScale=1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        image: showAddImage!
            ? DecorationImage(
          scale: imageScale!,
          isAntiAlias: true,
          fit: imageFit,
          alignment: imageAlign ?? AlignmentDirectional.center,
          image: NetworkImage('$imageUrl'),
        )
            : null,
        color:color,
        borderRadius: borderRadius!,
        gradient: showGradient! ? LinearGradient(
          begin: beginGradientAlign ?? Alignment.topRight,
          end: endGradientAlign ?? Alignment.bottomLeft,
          colors: gradientColorsList ?? [
            Colors.amber,
            Colors.indigo,],
        ): null,
        border: showBorder!
            ? Border.all(color: borderColor ?? Colors.black, width: borderWidth!, )
            : null,
        boxShadow: showShadow! ? [
          BoxShadow(
            blurStyle: blurShadowStyle ?? BlurStyle.normal,
            color: boxShadowColor ?? Colors.grey,
            spreadRadius: spreadShadowRadius!,
            blurRadius: blurShadowRadius!,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ]:[],
      ),
      alignment:alignment,


      child: child,
    );
  }
}
