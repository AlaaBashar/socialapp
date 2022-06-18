import 'package:flutter/material.dart';

import '../../export_feature.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            return SingleChildScrollView(

              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Welcome back ! Login with your credentials',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                            TextFieldApp(
                            height: 60.0,
                            controller: emailController,
                            hintText: 'Email Address',
                            isRTL: false,
                            showCursor: true,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => emailController.clear(),
                            ),
                            prefixIcon: const Icon(Icons.email),
                            inputFormatters: [
                              RegExpValidator.clearWhitespace
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                ShowToastSnackBar.displayToast(message: 'Email Must Be Not Empty');
                                return '';
                              }
                              if (!RegExpValidator.isValidEmail(email: value.toString()) && value.isNotEmpty) {
                                ShowToastSnackBar.displayToast(message: 'Badly format of email');
                                return '';
                              }
                              return null;
                            },

                          ),

                          const SizedBox(
                            height: 25.0,
                          ),
                          TextFieldApp(
                            height: 60.0,
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: LoginProvider.watch(context).isVisible,
                            isRTL: false,
                            showCursor: true,
                            suffixIcon: IconButton(
                              icon: Icon(LoginProvider.watch(context).modeIcon),
                              onPressed: () => suffixOnPressed(),
                            ),
                              prefixIcon: const Icon(Icons.lock),
                            inputFormatters: [
                              RegExpValidator.clearWhitespace
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                ShowToastSnackBar.displayToast(message: 'Password Must Be Not Empty');
                                return '';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          DefaultButtonWidget(
                            fontSize: 16.0,
                            onPressed: onLogin,
                            text: 'Login',
                            color: Colors.lightBlue,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  openNewPage(context, RegisterScreen());
                                },
                                child: const Text('SignUp Now'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void suffixOnPressed() {
    LoginProvider.read(context).visibilitySuffix();
  }
  void onLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) return;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    LoginProvider.read(context).onLoginPro(
      email: email,
      password: password,
      context: context,
    );
  }
}
