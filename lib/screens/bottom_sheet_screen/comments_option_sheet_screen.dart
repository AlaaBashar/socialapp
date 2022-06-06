import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../export_feature.dart';

class CommentsOptionsSheet extends StatefulWidget {
  final PostCommentsModel? postCommentsModel;
  final PostModel? postModel;
  final Function? function;
  const CommentsOptionsSheet({Key? key, this.postCommentsModel, this.postModel, this.function}) : super(key: key);

  @override
  State<CommentsOptionsSheet> createState() => _CommentsOptionsSheetState();
}

class _CommentsOptionsSheetState extends State<CommentsOptionsSheet> {


  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250.0,
      child:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children:  [
            Text('Options',style: Theme.of(context).textTheme.headline3,),
            const SizedBox(height: 10.0,),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            Expanded(
              child: InkWell(
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap:onCopy,
                child: Row(children:  [
                  const Icon(Icons.copy,size: 30.0,),
                  const SizedBox(width: 20.0,),
                  Text('Copy',style: Theme.of(context).textTheme.headline3,),
                ],),
              ),
            ),
            Expanded(
              child: InkWell(
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: onEdit,
                child: Row(children:  [
                  const Icon(Icons.edit_outlined,size: 30.0,),
                  const SizedBox(width: 20.0,),
                  Text('Edit',style: Theme.of(context).textTheme.headline3,),
                ],),
              ),
            ),
            Expanded(
              child: InkWell(
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: onDelete,
                child: Row(children:  [
                  const Icon(Icons.delete_forever,size: 30.0,),
                  const SizedBox(width: 20.0,),
                  Text('Delete',style: Theme.of(context).textTheme.headline3,),
                ],),
              ),
            ),

          ],),
      ),
    );
  }

  void onCopy(){
    Clipboard.setData(ClipboardData(
        text: '${widget.postCommentsModel!.comments}'))
        .then((value) {
      Navigator.pop(context);
      ShowToastSnackBar.displayToast(message: 'Copied');
    });
    setState(() {});
  }

  void onEdit(){
    Navigator.pop(context);
    setState(() {});
  }

  void onDelete()async{
    final shouldPop = await showMyDialog(
      context: context,
      title: 'Warning',
      body: 'Are you sure to deleting a comment',
    );
    if(shouldPop){
      Navigator.pop(context);
      widget.function!();
      setState(() {
      });
    }
    else{
      Navigator.pop(context);
    }

  }


}