import 'package:flutter/material.dart';

import '../../../export_feature.dart';

class SendImageScreen extends StatefulWidget {
  final String? imageUrl;
  final String? receiverUid;
   const SendImageScreen({Key? key, this.imageUrl, this.receiverUid,}) : super(key: key);

  @override
  State<SendImageScreen> createState() => _SendImageScreenState();
}

class _SendImageScreenState extends State<SendImageScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(child: InteractiveViewer(
              clipBehavior: Clip.none,

              child: AspectRatio(
                  aspectRatio: 1,
                      child: ReusableCachedNetworkImage(imageUrl: widget.imageUrl!,)),
            )),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(children: [
                        TextFieldApp(
                          controller: messageController,
                          prefixIcon: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap:(){},
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

                        ),
                      ],),
                    ),
                    const SizedBox(width: 5.0,),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: FittedBox(
                        child: FloatingActionButton(
                          onPressed: ()=> onSendImage(context: context),
                          focusColor: Colors.transparent,
                          tooltip: 'Send Message',
                          backgroundColor: Colors.greenAccent,
                          child: const Icon(MyFlutterApp.send),
                          splashColor: Colors.transparent,
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            const SizedBox(height: 26.0,),
          ],
        ),
      ),
    );
  }

  Future<void> onSendImage({BuildContext? context}) async {
    if(widget.imageUrl!.isNotEmpty){
      MessageModel messageModel = MessageModel();
      messageModel
        ..senderUid= Auth.currentUser!.uid
        ..receiverUid = widget.receiverUid
        ..message = messageController.text
        ..imageMessage = widget.imageUrl
        ..date = DateTime.now();

      await Api.sendMessages(messageModel: messageModel)
          .then((value) => {})
          .catchError((onError){
        debugPrint('$onError');
        ShowToastSnackBar.displayToast(message: onError.toString());});
      Navigator.pop(context!);
      setState(() {});
    }


  }
}
