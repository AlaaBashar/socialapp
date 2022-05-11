import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/export_feature.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditSettingsScreen extends StatefulWidget {
  final UserModel userData;
  const EditSettingsScreen({Key? key, required this.userData}) : super(key: key);


  @override
  State<EditSettingsScreen> createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? profileImage;
  File? coverImage;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  setState(() {
    nameController.text = widget.userData.name.toString();
    bioController.text = widget.userData.bio.toString();
  });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
      body: Form(
        key: _formKey,
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
                          backgroundImage: profileImage == null ? NetworkImage('${widget.userData.image}') : FileImage(profileImage!) as ImageProvider,
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
              controller: bioController,
              horizontalPadding: 20.0,
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

          ],
        ),
      ),
    );
  }
  void onUpdate()async{
    if(!_formKey.currentState!.validate()){return;}
    if (profileImage != null) {
      String? urls;
      urls = await Storage.uploadUserImage(image: profileImage).catchError((onError){
        showSnackBar(context, onError.toString());
      });
      print(urls);
    }
    if (coverImage != null) {
      String? url;
      url = await Storage.uploadUserImage(image: coverImage).catchError((onError){
        showSnackBar(context, onError.toString());
      });

      print(url);
    }
  }

  void getCoverImage() async {
    coverImage =
        await Storage.getGalleryImage(image: coverImage).catchError((onError) {
      showSnackBar(context, onError.toString());
    });
    setState(() {});
  }

  getProfileImage() async {
    profileImage = await Storage.getGalleryImage(image: profileImage)
        .catchError((onError) {
      showSnackBar(context, onError.toString());
    });
    setState(() {});
  }
}