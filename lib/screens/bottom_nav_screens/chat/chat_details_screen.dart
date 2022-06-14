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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 10.0),
            child: Column(
              children:  [
                buildMessage(),
                const SizedBox(height: 40.0,),
                buildMyMessage(),
                const Spacer(flex: 1,),
                TextFieldApp(
                  controller: messageController,
                  hintText: 'type your message here...',
                  inputFormatters: [
                    RegExpValidator.beginWhitespace
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      ShowToastSnackBar.displayToast(message: 'message Must Be Not Empty');
                      return '';
                    }
                  },
                  showCursor: true,
                  isRTL: false,
                  suffixIcon: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                      onTap: onSendMessage,
                      child: const Icon(MyFlutterApp.send)),
                ),
                const SizedBox(height: 20.0,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMessage() =>const Padding(
    padding: EdgeInsets.only(right: 26.0),
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: ContainerWidget(
        color: Colors.white,
        borderRadius:BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
        child:Text('Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World',style: TextStyle(color: Colors.black),),
      ),
    ),
  );
  Widget buildMyMessage() =>const Padding(
    padding: EdgeInsets.only(left: 26.0),
    child: Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ContainerWidget(
        color: Colors.blue,
        borderRadius:BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
        child:Text('Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World',style: TextStyle(color: Colors.black),),
      ),
    ),
  );

  Future<void> onSendMessage()async{
    FocusScope.of(context).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) return;
  }
}
