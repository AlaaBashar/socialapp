import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/export_feature.dart';

class ChatDetailsScreen extends StatefulWidget {
  final UserModel? userModel;
  const ChatDetailsScreen({Key? key, this.userModel}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {

  UserModel? model;
  var messageController = TextEditingController();
  List<MessageModel>? messagesList = [];
  final _formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  bool? isButtonActive = false;
  String? receiverUid;
  File? messageImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.userModel;
    messageController.addListener(() {
     if(messageController.text.isNotEmpty){

       setState(() {
         isButtonActive = true;
       });
     }
     if(messageController.text.isEmpty){
       setState(() {
         isButtonActive = false;
       });
     }
    });

  }
  @override
  void dispose() {
    messageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool? backGround = ChangeMode.watch(context).isDark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(children: [
          Hero(
            tag: '${model!.image}',
            child: CircleAvatarWidget(
              showBackgroundImage: true,
              backgroundImageUrl: model!.image,
            ),
          ),
          const SizedBox(width: 15.0,),
          Text('${model!.name}',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),),
        ],),
        actions: const [
          Icon(MyFlutterApp.video_1,size: 20.0,),
          SizedBox(width: 20.0,),
          Icon(Icons.call,size: 25.0,),
          SizedBox(width: 20.0,),
          Icon(Icons.more_vert,size: 25.0,),
          SizedBox(width: 15.0,),
        ],
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Container(
          decoration:  BoxDecoration(
              image:DecorationImage(
                invertColors:backGround? false : true ,
            fit: BoxFit.cover,
            image: const AssetImage(ImageHelper.whatsUpWallPaper),
          ) ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Api.getMessages(receiverUid:model!.uid),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child:  Text(''),
                          );
                        }
                        else{
                          messagesList =snapshot.data!.docs.map((e) => MessageModel.fromJson(e.data() as Map<String,dynamic>)).toList();
                          MessageModel? messageModel;
                          return CustomScrollView(
                            controller: scrollController,
                            keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag,
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    messageModel = messagesList![index];
                                      receiverUid =messageModel!.receiverUid;
                                    if(index == messagesList!.length ){
                                      return Container(height: 70.0,);
                                    }
                                    if(messageModel != null){
                                      return Column(
                                        children: [
                                          const SizedBox(height: 16.0,),
                                          messageModel!.senderUid == Auth.currentUser!.uid
                                              ?buildMyMessage(messageModel: messageModel)
                                              :buildMessage(messageModel: messageModel),

                                        ],
                                      );
                                    }

                                    },
                                  childCount: messagesList!.length ,
                                ),
                              ),
                              const SliverToBoxAdapter(child:  SizedBox(height: 30.0,),),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 55.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldApp(
                                controller: messageController,
                                prefixIcon: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:setEmojis,
                                    child: const Icon(Icons.emoji_emotions)),
                                hintText: 'Message',
                                inputFormatters: [
                                  RegExpValidator.beginWhitespace
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    ShowToastSnackBar.displayToast(message: 'message Must Be Not Empty');
                                    return '';
                                  }
                                  return null;
                                },
                                isRTL: false,
                                suffixIcon:InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap:()=>  addPhoto(receiverUid:receiverUid.toString() ),
                                    child: const Icon(Icons.camera_enhance)),

                              ),
                            ),
                            const SizedBox(width: 5.0,),
                            isButtonActive!
                                ? SizedBox(
                              width: 45,
                              height: 45,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  onPressed: onSendMessage,
                                  focusColor: Colors.transparent,
                                  tooltip: 'Send Message',
                                  backgroundColor: Colors.greenAccent,
                                  child: const Icon(MyFlutterApp.send),
                                  splashColor: Colors.transparent,
                                ),
                              ),
                            )
                                :SizedBox(
                              width: 45,
                              height: 45,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  onPressed: (){},
                                  focusColor: Colors.transparent,
                                  tooltip: 'Send Message',
                                  backgroundColor: Colors.grey,
                                  child: const Icon(MyFlutterApp.send),
                                  splashColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        // messageImage != null
                        //     ?Dismissible(
                        //   onDismissed: (direction){
                        //     setState(() {
                        //       messageImage = null;
                        //     });
                        //   },
                        //   key: const Key(''),
                        //   child: Container(
                        //     height: 100.0,
                        //     width: 100,
                        //     decoration: BoxDecoration(
                        //       borderRadius: const BorderRadius.all(
                        //         Radius.circular(4.0),
                        //       ),
                        //       image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: FileImage(messageImage!),
                        //       ),
                        //     ),
                        //   ),
                        // )
                        //     :const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildMessage({MessageModel? messageModel}) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onLongPress: ()=>removeMessages(messageModel: messageModel),
    child: Padding(
      padding: const EdgeInsets.only(right: 100.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: messageModel!.imageMessage!.isNotEmpty
            ? messageModel.message!.isEmpty
            ?InkWell(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
            FocusManager.instance.primaryFocus?.unfocus();
            openNewPage(context, FullChatImageScreen(imageUrl:messageModel.imageMessage,));
          },
          child: Hero(
            tag: messageModel.imageMessage.toString(),
            child: ContainerWidget(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(4.0),
              color: Colors.white,
              showAddImage: true,
              imageUrl: messageModel.imageMessage,
              borderRadius:const BorderRadiusDirectional.only(
                bottomStart:  Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              ),
              child:Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Text(timeFormat(date: messageModel.date),style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey),)),
            ),
          ),
        )
            :ContainerWidget(
          width: 200,
          color: Colors.white,
          borderRadius:const BorderRadiusDirectional.only(
            bottomStart:  Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  FocusManager.instance.primaryFocus?.unfocus();
                  openNewPage(context, FullChatImageScreen(imageUrl:messageModel.imageMessage,));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                  child: Hero(
                    tag: messageModel.imageMessage.toString(),
                    child: ReusableCachedNetworkImage(
                      height: 200,
                      width: 200,
                      imageUrl: '${messageModel.imageMessage}',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${messageModel.message}',style: TextStyle(color: Colors.black),),
                    const SizedBox(height: 2.0,),
                    Text(timeFormat(date: messageModel.date),style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey),),
                  ],
                ),
              ),
            ],
          ),
        )
            :ContainerWidget(
          color: Colors.white,
          borderRadius:const BorderRadiusDirectional.only(
            bottomStart:  Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${messageModel.message}',style: const TextStyle(color: Colors.black),),
              const SizedBox(height: 2.0,),
              Text(timeFormat(date: messageModel.date),style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey),),
            ],
          ),
        ),
      ),
    ),
  );
  Widget buildMyMessage({MessageModel? messageModel}) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onLongPress: ()=>removeMessages(messageModel: messageModel),
    child: Padding(
      padding: const EdgeInsets.only(left: 100.0),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: messageModel!.imageMessage!.isNotEmpty
            ?messageModel.message!.isEmpty
            ?InkWell(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
            FocusManager.instance.primaryFocus?.unfocus();
            openNewPage(context, FullChatImageScreen(imageUrl:messageModel.imageMessage,));
          },
          child: Hero(
            tag: messageModel.imageMessage.toString(),
            child: ContainerWidget(
            width: 200,
            height: 200,
            padding: const EdgeInsets.all(4.0),
            color: Colors.blue,
            showAddImage: true,
            imageUrl: messageModel.imageMessage,
            borderRadius:const BorderRadiusDirectional.only(
                bottomStart:  Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
            ),
            child:Align(
                alignment: AlignmentDirectional.bottomEnd,
                  child: Text(timeFormat(date: messageModel.date),style: Theme.of(context).textTheme.caption,)),
        ),
          ),
            )
            :ContainerWidget(
          width: 200,
          color: Colors.blue,
          borderRadius:const BorderRadiusDirectional.only(
            bottomStart:  Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  FocusManager.instance.primaryFocus?.unfocus();
                  openNewPage(context, FullChatImageScreen(imageUrl:messageModel.imageMessage,));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                  child: Hero(
                    tag: messageModel.imageMessage.toString(),
                    child: ReusableCachedNetworkImage(
                      height: 200,
                      width: 200,
                      imageUrl: '${messageModel.imageMessage}',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${messageModel.message}'),
                    const SizedBox(height: 2.0,),
                    Text(timeFormat(date: messageModel.date),style: Theme.of(context).textTheme.caption,),
                  ],
                ),
              ),
            ],
          ),
        )
            :ContainerWidget(
          color: Colors.blue,
          borderRadius:const BorderRadiusDirectional.only(
            bottomStart:  Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${messageModel.message}',style: const TextStyle(color: Colors.white),),
              const SizedBox(height: 2.0,),
              Text(timeFormat(date: messageModel.date),style: Theme.of(context).textTheme.caption,),
            ],
          ),
        ),
      ),
    ),
  );
  Future<void> onSendMessage()async{
    if (messageController.text.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      MessageModel messageModel = MessageModel();
      messageModel
        ..senderUid= Auth.currentUser!.uid
        ..receiverUid = model!.uid
        ..message = messageController.text
        ..imageMessage = ''
        ..date = DateTime.now();
      messageController.clear();
      await Api.sendMessages(messageModel: messageModel)
          .then((value) => {})
          .catchError((onError){
        debugPrint('$onError');
        ShowToastSnackBar.displayToast(message: onError.toString());});
    }
    setState(() {});
  }
  Future<void> removeMessages({MessageModel? messageModel})async{
    FocusScope.of(context).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
    final bool? shouldPop = await showMyDialog(
      context: context,
      title: 'Warning',
      body: 'Are you sure to delete a message',
    );
    if(shouldPop!) {
      await Api.removeMessages(messageModel: messageModel).catchError((onError) {
        ShowToastSnackBar.displayToast(message: onError.toString());
      });

    }
    setState(() {});



  }
  Future<void> addPhoto({String? receiverUid}) async {
    messageImage = await Storage.getGalleryImage(image: messageImage).catchError((onError) {
      showSnackBar(context, onError.toString());
    }) ?? messageImage;
     debugPrint('-----------------------------------------');
     debugPrint(receiverUid.toString());
     debugPrint('-----------------------------------------');

    if (messageImage != null) {
      ProgressCircleDialog.show(context);
      await Storage.uploadUserImage(image: messageImage).then((value) {
        openNewPage(context,SendImageScreen(imageUrl: value,receiverUid: receiverUid),);})
          .catchError((onError) {
        showSnackBar(context, onError.toString());
      });
      ProgressCircleDialog.dismiss(context);
      messageImage = null;
    }
    setState(() {});
  }
  void setEmojis() {
    // EmojiKeyboard(
    //   onEmojiSelected: (Emoji emoji){
    //     messageController.text = emoji.toString();
    //   },
    // );
  }

}


