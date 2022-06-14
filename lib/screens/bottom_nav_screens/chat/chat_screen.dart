import 'package:flutter/material.dart';

import '../../../export_feature.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<UserModel>? userList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUsers();

  }
  @override
  Widget build(BuildContext context) {
    return userList!= null ?
      ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index){
        UserModel userModel = userList![index];
        return buildChatItem(context: context,model: userModel);
      },
      separatorBuilder: (context,index)=> buildDivider(),
      itemCount: userList!.length,
    ):getCenterCircularProgress();
  }

  Widget buildChatItem({BuildContext? context,UserModel? model}) => InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: ()=> openNewPage(context!, ChatDetailsScreen(userModel: model,)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 16.0),
      child: Row(
            children:  [
               Hero(
                 tag: '${model!.image}',
                 child: CircleAvatarWidget(
                  radius: 25.0,
                  showBackgroundImage: true,
                  backgroundImageUrl:'${model.image}' ,
              ),
               ),
              const SizedBox(width: 15.0,),
              Text('${model.name}',style: Theme.of(context!).textTheme.bodyText1,),


            ],
          ),
    ),
  );

  buildDivider({double? bottom}) {
    return Padding(
      padding: bottom == null
          ? const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8.0)
          : EdgeInsets.only(bottom: bottom),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Future<void> loadUsers()async{
    userList = await Api.getAllUser();
    setState(() {

    });

  }
}
