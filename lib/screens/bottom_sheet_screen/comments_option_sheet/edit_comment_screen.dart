import 'package:flutter/material.dart';
import '../../../export_feature.dart';

class EditCommentScreen extends StatefulWidget {
  final PostCommentsModel? postCommentsModel;
  final PostModel? postModel;
  const EditCommentScreen({Key? key, this.postCommentsModel, this.postModel}) : super(key: key);

  @override
  State<EditCommentScreen> createState() => _EditCommentScreenState();
}

class _EditCommentScreenState extends State<EditCommentScreen> {
  var updateController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateController.text = widget.postCommentsModel!.commentsContent.toString();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children:  [
                const CircleAvatarWidget(
                  radius: 22.0,
                  showBackgroundImage: true,
                  backgroundImageUrl: 'https://img.freepik.com/free-photo/calm-handsome-bearded-caucasian-man-with-curious-expression-points-thumb-aside-blank-space-demonstrates-good-promo-place-your-advertising-wears-hoodie-poses-yellow-wall_273609-42131.jpg?w=1060&t=st=1652027475~exp=1652028075~hmac=d748afab2e433d0c9d4f52f3e571c59b695b27195276c85d96b11ef406835256',
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                    child: TextFieldApp(
                  controller: updateController,
                  maxLines: 2,
                  hintText: 'Write your update comment here...',
                  isRTL: false,
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(onPressed: (){
                  Navigator.pop(context);
                },color: Theme.of(context).scaffoldBackgroundColor,child: const Text('Cancel')),
                const SizedBox(width: 20.0,),
                MaterialButton(onPressed: ()=> onEdit(postModel: widget.postModel,postCommentsModel: widget.postCommentsModel),color: Colors.blue,child:Text('Update'),),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> onEdit({PostCommentsModel? postCommentsModel,PostModel? postModel,})async{
    if(Auth.currentUser!.uid == postCommentsModel!.userUid){
      final shouldPop = await showMyDialog(
        context: context,
        title: 'Warning',
        body: 'Are you sure to edit a comment',
      );
      if(shouldPop){
        postCommentsModel.commentsContent = updateController.text;
        postCommentsModel.user = Auth.currentUser;
        postModel!.comments![postModel.comments!.indexWhere((element) => element.commentUid == postCommentsModel.commentUid)]= postCommentsModel;
        await Api.updateComments(postModel.postUid,postModel.comments!.toList());
        Navigator.pop(context,true);
        setState(() {});
      }
      else{
        Navigator.pop(context,true);
      }
    }


  }

}
