import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../export_feature.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(
      const Duration(
        seconds: 1,
      ),
    ).then(
      (value) => checkLoginUser(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent,),);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageHelper.logo,
            width: 150.0,
            height: 150.0,
          ),
          const SizedBox(
            height: 16.0,
          ),
          getCenterCircularProgress(),
        ],
      ),
    );
  }

  void checkLoginUser() async {
    UserModel? user = await Auth.getUserFromPref();

    if (user == null) {
      openNewPage(context, const LoginScreen(), popPreviousPages: true);
    }
    else {
      UserModel? userLogin = await Api.getUserFromUid(user.uid ?? '');

      if (userLogin == null) return;

      if (userLogin.isBlocked!) {
        showSnackBar(context , 'Please contact technical support to activate your account');
        await Auth.logout();
        openNewPage(context, const LoginScreen(), popPreviousPages: true);
        return;
      }

      await Auth.updateUserInPref(userLogin);

      openNewPage(context, const HomeScreen(), popPreviousPages: true);
    }
  }
}
