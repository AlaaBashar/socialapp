import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../export_feature.dart';
class CommentsBottomSheet extends StatefulWidget {
  final PostModel? postModel;
  const CommentsBottomSheet({Key? key, required this.postModel}) : super(key: key);
  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  var commentController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenHeight(context) * 0.8,
      child: Scaffold(
        key: scaffoldKey,
        body: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Form(
          key: _formKey,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading:InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Row(
                    children: [
                      const SizedBox(width: 12.0,),
                      const Icon(
                        MyFlutterApp.heart,
                        size: 16.0,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${widget.postModel!.likes!.length}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined,size: 20.0,),


                    ],
                  ),
                ),
                leadingWidth: 100.0,
                actions: const[
                  Icon(
                    MyFlutterApp.heart_empty,
                    size: 16.0,
                    color: Colors.redAccent,
                  ),
                  SizedBox(width: 12.0,),

                ],

              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child:SizedBox(
                  height: 1 ,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      SingleChildScrollView(
                        physics:const BouncingScrollPhysics() ,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: widget.postModel!.comments != null?
                          Column(
                            children: [
                              ListView.separated(
                                itemCount: widget.postModel!.comments!.length,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index){
                                  PostCommentsModel postComments = widget.postModel!.comments![index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatarWidget(
                                            radius: 22.0,
                                            showBackgroundImage: true,
                                            backgroundImageUrl: '${postComments.user!.image}',
                                          ),
                                          Expanded(
                                                    child: InkWell(
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onLongPress: () {
                                                        if(postComments.userUid == Auth.currentUser!.uid){
                                                          scaffoldKey.currentState!.showBottomSheet((context) => CommentsOptionsSheet(
                                                            postCommentsModel: postComments,
                                                            postModel: widget.postModel,
                                                            function: () {
                                                              removeComments(postCommentsModel: postComments, postModel: widget.postModel);
                                                              setState(() {});
                                                            },

                                                          ));
                                                        }
                                                        else{
                                                          Clipboard.setData(ClipboardData(text: '${postComments.commentsContent}')).then((value) {
                                                            ShowToastSnackBar.displayToast(message: 'Copied');
                                                          });
                                                        }
                                                        setState(() {});
                                                      },
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15.0),
                                                        ),
                                                        margin:
                                                            const EdgeInsets.all(8.0),
                                                        elevation: 6.0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  12.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text('${postComments.user!.name}'),
                                                                  const SizedBox(
                                                                    width: 2.0,
                                                                  ),
                                                                  widget.postModel!.userUid == postComments.userUid?
                                                                  Text('(Author)',style:Theme.of(context).textTheme.caption,):const Text(''),
                                                                ],
                                                              ),

                                                              const SizedBox(
                                                                height: 8.0,
                                                              ),
                                                              Text(
                                                                '${postComments.commentsContent}',
                                                                style:
                                                                    Theme.of(context)
                                                                        .textTheme
                                                                        .caption,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                                        child: Row(
                                          children: [
                                            Text(dataFormat(date: postComments.date),style: Theme.of(context).textTheme.caption,),
                                            const SizedBox(width: 10.0,),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20.0,),
                                    ],
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 10.0,);
                                },
                              ),
                              const SizedBox(height: 50.0,),
                            ],
                          )
                              :getCenterCircularProgress(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFieldApp(
                          showCursor: true,
                          controller: commentController,
                          hintText: 'write your comment here ...',
                          suffixIcon: IconButton(
                            onPressed: () =>  onComment().then((value) => commentController.clear()),
                            icon: const Icon(Icons.send),
                          ),
                          isRTL: false,
                          inputFormatters: [
                            RegExpValidator.beginWhitespace,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              ShowToastSnackBar.displayToast(message: 'Comment Must Be Not Empty');
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
        ),
      ),
    );
  }

  Future<void> onComment()async{
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
    String? postComments = commentController.text;
    PostCommentsModel postCommentsModel = PostCommentsModel();
    postCommentsModel
      ..date = DateTime.now()
      ..user=Auth.currentUser
      ..postUid = widget.postModel!.postUid
      ..commentsContent = postComments
      ..userUid = Auth.currentUser!.uid;
    widget.postModel!.comments!.add(postCommentsModel);
    await Api.setComments(postCommentsModel, widget.postModel!.postUid);
    setState(() {});
  }

  Future<void> removeComments({PostCommentsModel? postCommentsModel , PostModel? postModel,}) async {
    if(Auth.currentUser!.uid == postCommentsModel!.userUid){
      postModel!.comments!.remove(postCommentsModel);
      await Api.removeComments(postCommentsModel, postCommentsModel.postUid);
    }
  }




}
