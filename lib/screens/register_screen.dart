import 'dart:io';
import 'package:flutter/material.dart';
import '../../export_feature.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var birthdayController = TextEditingController();
  var idController = TextEditingController();
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1,),
                          const Text(
                            'SIGN UP',
                            style:
                            TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Create an Account,it\'s free',
                            style: TextStyle(fontSize: 20.0, color: Colors.grey),
                          ),
                          const SizedBox(height: 25.0,),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 55.0,
                                  backgroundImage: profileImage == null
                                      ? const AssetImage(ImageHelper.user)
                                      : FileImage(profileImage!) as ImageProvider,
                                ),
                              ),

                              IconButton(
                                iconSize: 15.0,
                                onPressed: getProfileImage,
                                icon: CircleAvatar(
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    child: const Icon(Icons.camera_enhance,)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25.0,),
                          TextFieldApp(
                            height: 60.0,
                            controller: nameController,
                            hintText: 'Name',
                            isRTL: false,
                            showCursor: true,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => nameController.clear(),
                            ),
                            prefixIcon: const Icon(Icons.text_fields),
                            inputFormatters: [
                              RegExpValidator.insertEnglish
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                ShowToastSnackBar.displayToast(message: 'Name Must Be Not Empty');
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
                              RegExpValidator.clearWhitespace,
                              RegExpValidator.insertEnglish
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
                            obscureText: RegisterProvider.watch(context).isVisible,
                            isRTL: false,
                            showCursor: true,
                            suffixIcon: IconButton(
                              icon: Icon(RegisterProvider.watch(context).modeIcon),
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
                          TextFieldApp(
                            height: 60.0,
                            type:TextInputType.number,
                            controller: phoneController,
                            hintText: 'Phone',
                            isRTL: false,
                            showCursor: true,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => phoneController.clear(),
                            ),
                            prefixIcon: const Icon(Icons.phone_android),
                            inputFormatters: [
                              RegExpValidator.clearWhitespace
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                ShowToastSnackBar.displayToast(message: 'Phone Must Be Not Empty');
                                return '';
                              }
                              if (!RegExpValidator.isValidPhone(phone: value.toString()) && value.isNotEmpty) {
                                ShowToastSnackBar.displayToast(message: 'At least 10 digit of phone') ;
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
                            readOnly: true,
                            onTap: ()async{
                              String? date = await DateTimePicker.datePicker(context: context);
                              birthdayController.text = date!;
                            },
                            controller: birthdayController,
                            hintText: 'Birthday Date',
                            isRTL: false,
                            showCursor: true,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => birthdayController.clear(),
                            ),
                            prefixIcon: const Icon(Icons.date_range),
                            validator: (value) {
                              if (value!.isEmpty) {
                                ShowToastSnackBar.displayToast(message: 'Birthday date Must Be Not Empty');
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
                            type:TextInputType.number,
                            controller: idController,
                            hintText: 'ID',
                            isRTL: false,
                            showCursor: true,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => idController.clear(),
                            ),
                            prefixIcon: const Icon(Icons.app_registration),
                            inputFormatters: [
                              RegExpValidator.clearWhitespace
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                ShowToastSnackBar.displayToast(message: 'ID Must Be Not Empty');
                                return '';
                              }
                               if (!RegExpValidator.isValidPhone(phone: value.toString()) && value.isNotEmpty) {
                                 ShowToastSnackBar.displayToast(message: 'At least 10 digit of ID') ;
                                 return '';
                               }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          const Spacer(flex: 1,),
                          DefaultButtonWidget(
                            fontSize: 16.0,
                            onPressed: onRegister,
                            text: 'Sign Up',
                            color: Colors.lightBlue,
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
    RegisterProvider.read(context).visibilitySuffix();
  }
  void onRegister() async{
    if (!_formKey.currentState!.validate()) {return;}

    if(profileImage == null){
      ShowToastSnackBar.displayToast(message: 'Profile Image must be not empty');
      return;}
    FocusScope.of(context).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
    String? name = nameController.text;
    String? birthDay = birthdayController.text;
    String? password = passwordController.text.trim();
    String? email = emailController.text.trim();
    String? phone = phoneController.text.trim();
    String? id = idController.text.trim();

    RegisterProvider.read(context).onRegisterPro(
      email: email,
      password: password,
      context: context,
      id: id,
      name: name,
      phone: phone,
      birthDay: birthDay,
      profileImage: profileImage
    );
  }
  void getProfileImage() async {
    profileImage = await Storage.getGalleryImage(image: profileImage).catchError((onError) {
      showSnackBar(context, onError.toString());
    });
    setState(() {});
  }
}
