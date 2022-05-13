import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../export_feature.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {

  var postController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var userData = Auth.currentUser;
  File? postImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppbar(
        title: 'Create Post',
        actions: [
          TextButton(
            onPressed: onPost,
            child: Text('POST', style: Theme.of(context).textTheme.button),
          ),
          const SizedBox(
            width: 15.0,
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                '${userData!.image}'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${userData!.name}',
                              style: const TextStyle(height: 1.4),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              'Public',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: DefaultTextFieldWidget(
                      hintText: 'what is on your mind ...',
                      controller: postController,

                      validator: (String? value) {
                        if (value!.isEmpty) {
                          showSnackBar(context, 'Post must not be empty');
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                  postImage != null
                      ? Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 180.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(postImage!),),
                      ),
                    ),
                  )
                      : Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 180.0,
                      width: double.infinity,
                      decoration:  BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      child:  Icon(Icons.image,size: 50.0,color: Theme.of(context).scaffoldBackgroundColor,),

                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: addPhoto,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(MyFlutterApp.image_1),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text('add photo'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: addTags,
                          child: const Text('# tags'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],),









    );
  }

  void onPost() async{
    if (!_formKey.currentState!.validate()) {return;}
    FocusScope.of(context).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
    String? postContent = postController.text;
    String? postUrl ;
    if (postImage != null) {
      postUrl = await Storage.uploadUserImage(image: postImage)
          .catchError((onError) {
        showSnackBar(context, onError.toString());
      });
    }
    PostModel postModel = PostModel();
    postModel
    ..userUid = userData!.uid
    ..user = userData
    ..postContent = postContent
    ..date = DateTime.now()
    ..postImage = postUrl ?? '';

    await Api.uploadPost(postModel: postModel);


  }
  void addPhoto()async{
    postImage = await Storage.getGalleryImage(image: postImage)
        .catchError((onError) {
      showSnackBar(context, onError.toString());
    });
    setState(() {});

  }
  void addTags(){}



}
/*
* Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider('${userData!.image}'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userData!.name}',
                          style: const TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          'Public',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: DefaultTextFieldWidget(
                  hintText: 'what is on your mind ...',
                  controller: postController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      showSnackBar(context, 'Post must not be empty');
                      return '';
                    }
                    return null;
                  },
                ),
              ),
              postImage != null
                  ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                        height: 180.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0),),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: FileImage(postImage!)),
                        ),
                      ),
                  )
                  : const SizedBox(),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: addPhoto,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(MyFlutterApp.image_1),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text('add photo'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed:addTags,
                      child: const Text('# tags'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
*
*
* */