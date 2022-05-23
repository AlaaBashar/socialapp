import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/export_feature.dart';

class EditSettingsScreen extends StatefulWidget {
  final UserModel userData;
  const EditSettingsScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<EditSettingsScreen> createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var idController = TextEditingController();
  File? profileImage;
  File? coverImage;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  setState(() {
    nameController.text = widget.userData.name.toString();
    phoneController.text = widget.userData.phone.toString();
    bioController.text = widget.userData.bio.toString();
    idController.text = widget.userData.id.toString();
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        title: 'Edit Settings',
        actions: [
          TextButton(
            onPressed: onUpdate,
            child: Text('Update', style: Theme.of(context).textTheme.button),
          ),
          const SizedBox(width: 15.0,),
        ],
      ),
      body: FadeInUp(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 230.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 180.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(4.0),
                                  topLeft: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:coverImage == null
                                      ?CachedNetworkImageProvider('${widget.userData.cover}'):FileImage(coverImage!) as ImageProvider
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            iconSize: 15.0,
                            onPressed: getCoverImage,
                            icon: CircleAvatar(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: const Icon(Icons.camera_enhance,)),
                          )
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 55.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${widget.userData.image}')
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                DefaultTextFieldWidget(
                  controller: nameController,
                  suffixIcon: Icons.clear,
                  isSuffixShow: true,
                  suffixOnPressed:()=>nameController.clear(),
                  horizontalPadding: 20.0,
                  icon: const Icon(MyFlutterApp.user),
                  validator: (String? value)  {
                    if (value!.isEmpty) {
                      return 'Name must be not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DefaultTextFieldWidget(
                  controller: phoneController,
                  horizontalPadding: 20.0,
                  suffixIcon: Icons.clear,
                  isSuffixShow: true,
                  suffixOnPressed:()=>phoneController.clear(),
                  icon: const Icon(MyFlutterApp.phone),
                  validator: (String? value)  {
                    if (value!.isEmpty) {
                      return 'Phone must be not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DefaultTextFieldWidget(
                  controller: bioController,
                  horizontalPadding: 20.0,
                  suffixIcon: Icons.clear,
                  isSuffixShow: true,
                  suffixOnPressed:()=>bioController.clear(),
                  icon: const Icon(MyFlutterApp.info_circle),
                  validator: (String? value)  {
                    if (value!.isEmpty) {
                      return 'Bio must be not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DefaultTextFieldWidget(
                  controller: idController,
                  horizontalPadding: 20.0,
                  suffixIcon: Icons.clear,
                  isSuffixShow: true,
                  suffixOnPressed:()=>idController.clear(),
                  icon: const Icon(Icons.credit_card),
                  validator: (String? value)  {
                    if (value!.isEmpty) {
                      return 'ID must be not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onUpdate()async{
    var editUserRead = EditUserDate.read(context);
    final shouldPop = await showMyDialog(
      context: context,
      title: 'Warning',
      body: 'Are you sure to update data',
    );
    FocusScope.of(context).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
    String? name = nameController.text;
    String? phone = phoneController.text.trim();
    String? bio = bioController.text;
    String? id = idController.text.trim();
    if(shouldPop == true){
    if(!_formKey.currentState!.validate()){return;}
    editUserRead.onEdit(
        context: context,
        name: name,
        phone: phone,
        bio: bio,
        id: id,
        coverImage: coverImage,
        profileImage: profileImage);
    }
    // if(shouldPop == true){
    //   ProgressCircleDialog.show(context);
    //   if (profileImage != null) {
    //     imageUrl = await Storage.uploadUserImage(image: profileImage).catchError((onError){
    //       showSnackBar(context, onError.toString());
    //     });
    //   }
    //   if (coverImage != null) {
    //     coverUrl = await Storage.uploadUserImage(image: coverImage).catchError((onError){
    //       showSnackBar(context, onError.toString());
    //     });
    //
    //   }
    //   UserModel userModel = UserModel();
    //   userModel
    //     ..name = name
    //     ..phone = phone
    //     ..email = widget.userData.email
    //     ..bio = bio
    //     ..id = id
    //     ..date =DateTime.now()
    //     ..image = imageUrl ?? widget.userData.image
    //     ..cover = coverUrl ?? widget.userData.cover;
    //   await Api.editUserProfile(model: userModel, docId: widget.userData.uid)
    //       .catchError((onError) {
    //     showSnackBar(context, onError.toString());
    //     ProgressCircleDialog.dismiss(context);
    //   });
    //   ProgressCircleDialog.dismiss(context);
    //   Navigator.pop(context , true) ;
    //
    // }


  }

  void getCoverImage() async {
    coverImage = await Storage.getGalleryImage(image: coverImage).catchError((onError) {
      showSnackBar(context, onError.toString());
    });
    setState(() {});
  }

  void getProfileImage() async {
    profileImage = await Storage.getGalleryImage(image: profileImage).catchError((onError) {
      showSnackBar(context, onError.toString());
    });
    setState(() {});
  }
}