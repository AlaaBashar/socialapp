import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../export_feature.dart';

class FullImageScreen extends StatefulWidget {
  final PostModel? postModel;
  const FullImageScreen({
    Key? key,
    this.postModel,
  }) : super(key: key);

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      key:scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider('${widget.postModel!.user!.image}'),
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
                            Row(
                              children: [
                                Text(
                                  '${widget.postModel!.user!.name}',
                                  style: const TextStyle(height: 1.4),
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 18.0,
                                )
                              ],
                            ),
                            Text(
                              dataFormat(date: widget.postModel!.date),
                              style:
                              Theme.of(context).textTheme.caption!.copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0,),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16.0,),
                  Text(
                    '${widget.postModel!.postContent}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2,),
            Hero(
              tag: '${widget.postModel!.postImage}',
              child: InteractiveViewer(
                child: ReusableCachedNetworkImage(
                  imageUrl: '${widget.postModel!.postImage}',
                  width: double.infinity,
                ),
              ),
            ),
            const Spacer(flex: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(children: [
                Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(
                            MyFlutterApp.heart,
                            size: 16.0,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                           widget.postModel!.likes!.length.toString(),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    scaffoldKey.currentState!.showBottomSheet((context) => CommentsBottomSheet(postModel: widget.postModel,));
                    setState(() {});
                  },
                  child: Text(
                    '${widget.postModel!.comments!.length} comments',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                const SizedBox(width: 8.0,),
                Text('|',style: Theme.of(context).textTheme.caption,),
               const SizedBox(width: 8.0,),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Text(
                    '0 share',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),



              ],),
            ),
            const Spacer(flex: 1,),
          ],),
      ) ,
    );
  }
}

Future showMyDialogPost({
  required BuildContext context,
}) async =>
    showDialog(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:  Colors.transparent,
          title: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Column(
              children: const [],
            ),
          ),
        );
      },
    );