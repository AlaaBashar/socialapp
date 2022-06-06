import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../export_feature.dart';


Future<dynamic> openNewPage(BuildContext context, Widget widget,
    {bool popPreviousPages = false}) {
  return Future<dynamic>.delayed(Duration.zero, () {
    if (!popPreviousPages) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => widget,
          settings: RouteSettings(arguments: widget),
        ),
      );
    } else {
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => widget,
              settings: RouteSettings(
                arguments: widget,
              )),
          (Route<dynamic> route) => false);
    }
  });
}

double getScreenWidth(BuildContext context, {bool realWidth = false}) {
  if (realWidth) {
    return MediaQuery.of(context).size.width;
  } //to preview widget like phone scale in preview

  if (kIsWeb) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.width / 4
        : MediaQuery.of(context).size.height / 4;
  }

  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.width
      : MediaQuery.of(context).size.height;
}

double getScreenHeight(BuildContext context, {bool realHeight = false}) {
  if (realHeight) {
    return MediaQuery.of(context).size.height;
  } //to preview widget like phone scale in preview
  if (kIsWeb) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.height / 1.4
        : MediaQuery.of(context).size.width / 1.4;
  }
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.height
      : MediaQuery.of(context).size.width;
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class ProgressCircleDialog {
  static bool _isShow = false;

  static show(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    _isShow = true;
  }

  static dismiss(BuildContext context) {
    if (_isShow) {
      Navigator.pop(context);
      _isShow = false;
    }
  }
}
class ProgressLinearDialog {
  static bool _isShow = false;
  static show(
    BuildContext? context,
      {String? title,
  }) {
    showDialog(
        context: context!,
        builder: (_) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text('$title...!',style: Theme.of(context).textTheme.button,),
                  const SizedBox(height: 5.0,),
                   LinearProgressIndicator(minHeight: 3.0,backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
                ],
              ),
            )),
          ),
        ),
        barrierDismissible: false);
    _isShow = true;
  }

  static dismiss(BuildContext context) {
    if (_isShow) {
      Navigator.pop(context);
      _isShow = false;
    }
  }
}

class ShowToast {
  static FToast? fToast = FToast();

  static Widget toastDesign({
    String? message,
    Color? color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color ?? Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null ? Icon(icon) : const Icon(Icons.error),
          const SizedBox(
            width: 12.0,
          ),
          message != null ? Text(message) : const Text('Enter message'),
        ],
      ),
    );
  }

  static display({
    required BuildContext context,
    String? message,
    Color? color,
    IconData? icon,
  }) {
    fToast!.init(context);
    fToast!.showToast(
      child: toastDesign(
        message: message,
        color: color,
        icon: icon,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

}

void showToast(
   {required String text,
  required Color textColor,
  required Color backgroundColor,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: ${bloc.runtimeType}');
  }
}

void printFullText(String text){
  
  final pattern = RegExp('.{1800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget getCenterCircularProgress(
    {double? padding, double? size, Color? color, double radius = 12 , }) {
  return Container(
    padding: EdgeInsets.all(padding ?? 0.0),
    height: size ,
    width: size ,
    child: Center(
      child: CupertinoActivityIndicator(radius: radius,),
    ),
  );
}

void showSnackBar(BuildContext context, String value,{
  bool isError = false,
  bool isSuccess = false,
  Duration? duration,
  SnackBarAction? snackBarAction,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      value,
    ),
    duration: duration ?? const Duration(seconds: 2),
    action: snackBarAction,
    backgroundColor: isError
        ? Colors.red[800]
        : isSuccess
        ? Colors.green[800]
        : null,
  ));
}
String dataFormat({DateTime? date}){
  return DateFormat('hh:mm a,  MMM /d /yyyy').format(date!);
}