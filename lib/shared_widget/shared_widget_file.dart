import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../export_feature.dart';


class DefaultButtonWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final double? horizontalPadding;
  final Color? color;
  final Function()? onPressed;

  const DefaultButtonWidget({
    Key? key,
    required this.text,
    this.height,
    this.color,
    required this.onPressed,
    this.textColor,
    this.horizontalPadding,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding!)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: MaterialButton(
        minWidth: double.infinity,
        color: color ?? Colors.grey,
        height: height ?? 50.0,
        textColor: textColor ?? Colors.white,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: fontSize ?? 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class PostTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final Color? hintTextColor;
  final double? height;
  final double? horizontalPadding;
  final bool? isObscure;
  final Icon? icon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? isSuffixShow;
  final VoidCallback? suffixOnPressed;
  final ValueChanged<String>? onSubmit;
  final IconData? suffixIcon;

  const PostTextFieldWidget({
    Key? key,
    this.hintText,
    required this.controller,
    this.isObscure,
     this.validator,
    this.icon,
    this.height,
    this.horizontalPadding,
    this.isSuffixShow = false,
    this.suffixOnPressed,
    this.suffixIcon,
    this.onSubmit,
    this.hintTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding!)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: height ?? 50.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            inputFormatters: [
            ///BlacklistingTextInputFormatter(RegExp('[^[a-zA-Z0-9_ ]*$ ]')),
            ///Leading whitespace
              RegExpValidator.beginWhitespace,
            ///Trailing whitespace:
            ///FilteringTextInputFormatter.deny(RegExp(r'[\s]+$')),
          ],
            obscureText: isObscure ?? false,
            onChanged: onSubmit,
            decoration: InputDecoration(
              icon: icon,
              hintText: hintText,
              hintStyle:TextStyle(color: hintTextColor ?? Colors.grey),
              border: InputBorder.none,
              enabled: true,
              suffixIcon: isSuffixShow == true
                  ? IconButton(
                      icon: Icon(suffixIcon!),
                      splashColor: Colors.transparent,
                      onPressed: suffixOnPressed,
                    )
                  : null,
            ),
            validator: validator,
        ),
      ),
    );
  }
}

Future showMyDialog({context, required String? title, required String? body}) async =>
    showDialog(
  context: context,
  //barrierDismissible: false, // user must tap button!
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      titlePadding:EdgeInsets.zero ,
      title: Column(
        children: [
          Container(
            decoration:BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.3,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                )
              ],
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius:const BorderRadius.only(topLeft:Radius.circular(15.0),topRight:Radius.circular(15.0 )),
            ),
            height: 70.0,
            width: double.infinity,
            child: const Icon(Icons.warning_amber_rounded,size: 55.0,color: Colors.grey,),
          ),
          const SizedBox(height: 10.0,),
            Text('$title!',style: Theme.of(context).textTheme.headline3,),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children:  [
            Text('$body?',style: Theme.of(context).textTheme.bodyText2,),
          ],
        ),
      ),
      actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Text('No'),
              splashColor: Colors.redAccent,
              elevation: 8.0,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Text('Yes'),
              splashColor: Colors.greenAccent,
              elevation: 8.0,

            ),
          ],
        );
  },
);


class DefaultAppbar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final List<String>? titlesList;
  final int? titlesIndex;
  final Widget? leading;

  const DefaultAppbar({
    Key? key,
    this.title,
    this.actions,
    this.titlesList,
    this.titlesIndex,
    this.leading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(

      title:  Text(title ?? titlesList![titlesIndex!]),
      actions: actions,
      leading: leading,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
