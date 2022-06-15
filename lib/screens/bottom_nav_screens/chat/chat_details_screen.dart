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
  var messageController = TextEditingController();
  List<MessageModel>? messagesList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool? backGround = ChangeMode.watch(context).isDark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(children: [
          Hero(
            tag: '${widget.userModel!.image}',
            child: CircleAvatarWidget(
              showBackgroundImage: true,
              backgroundImageUrl: widget.userModel!.image,
            ),
          ),
          const SizedBox(width: 15.0,),
          Text('${widget.userModel!.name}',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),),
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
              padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 10.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Api.getMessages(receiverUid: widget.userModel!.uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child:  Text('',
                      ),
                    );
                  }
                  else{
                    messagesList =snapshot.data!.docs.map((e) => MessageModel.fromJson(e.data() as Map<String,dynamic>)).toList();
                    MessageModel? messageModel;
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 55.0),
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context ,index)
                              {
                                messageModel = messagesList![index];
                                return messageModel!.senderUid == Auth.currentUser!.uid
                                    ?buildMyMessage(messageModel: messageModel)
                                    :buildMessage(messageModel: messageModel);
                              },
                              separatorBuilder: (context ,index) => const SizedBox(height: 10.0,),
                              itemCount: messagesList!.length,
                            ),
                          ),
                        ),
                        Align(

                          alignment: AlignmentDirectional.bottomCenter,
                          child: TextFieldApp(
                            controller: messageController,
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
                            suffixIcon: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: onSendMessage,
                                child: const Icon(MyFlutterApp.send)),
                          ),
                        ),
                      ],
                    );
                  }

                  }
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
      padding: const EdgeInsets.only(right: 26.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: ContainerWidget(
          color: Colors.white,
          borderRadius:const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${messageModel!.message}',style: const TextStyle(color: Colors.black),),
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
      padding: const EdgeInsets.only(left: 26.0),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: ContainerWidget(
          color: Colors.green.shade800,
          borderRadius:const BorderRadiusDirectional.only(
            bottomStart:  Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${messageModel!.message}',style: const TextStyle(color: Colors.white),),
              Text(timeFormat(date: messageModel.date),style: Theme.of(context).textTheme.caption,),
            ],
          ),
        ),
      ),
    ),
  );
  Future<void> onSendMessage()async{
     FocusScope.of(context).requestFocus(FocusNode());
     FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) return;

    MessageModel messageModel = MessageModel();
    messageModel
    ..senderUid= Auth.currentUser!.uid
    ..receiverUid = widget.userModel!.uid
    ..message = messageController.text
    ..date = DateTime.now();

    await Api.sendMessages(messageModel: messageModel)
        .then((value) => {messageController.clear()})
        .catchError((onError){
          debugPrint('$onError');
          ShowToastSnackBar.displayToast(message: onError.toString());
    });
  }
  Future<void> removeMessages({MessageModel? messageModel})async{
    final shouldPop = await showMyDialog(
      context: context,
      title: 'Warning',
      body: 'Are you sure to delete a message',
    );
    if(shouldPop) {
      Api.removeMessages(messageModel: messageModel).catchError((onError) {
        ShowToastSnackBar.displayToast(message: onError.toString());
      });
    }
    setState(() {});



  }
}
