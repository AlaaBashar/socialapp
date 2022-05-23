import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../export_feature.dart';

class FeedsScreen extends StatefulWidget {

   const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<PostModel>? postList= [];
  List<PostLikes>? userLikesList= [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPosts();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(8.0),
            elevation: 6.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const ReusableCachedNetworkImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                  imageUrl:
                      'https://img.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg?w=1380&t=st=1652021694~exp=1652022294~hmac=57105b5913f6f258038929b9e66b123856838325f075f311b42d0a8d42af8cc6',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'communicat with friends',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          postList != null
              ? ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: postList!.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    PostModel postModel = postList![index];
                    return buildPostItem(
                      context,
                      postModel,
                      index
                    );
                  },
                )
              : getCenterCircularProgress(),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget buildPostItem(context, PostModel? postModel,int? index) {

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 6.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPostHeader(image:postModel!.user!.image,name:postModel.user!.name ,dateTime:postModel.date),
            buildDivider(),
            buildPostContent(postContent: postModel.postContent),
            buildPostTags(),
            buildPostImage(postImage: postModel.postImage),
            buildLikesCount(likesNo: postModel.likes!.length,),
            buildDivider(bottom: 8.0),
            buildLikesAndShareButtons(image: postModel.user!.image,postUid: postModel.postUid,list: postModel.likes),
          ],
        ),
      ),
    );
  }

  buildPostHeader({String? image, String? name, DateTime? dateTime}) {
    return Row(
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider('$image'),
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
                    '$name',
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
                dataFormat(date: dateTime),
                style:
                    Theme.of(context).textTheme.caption!.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            MyFlutterApp.more_horiz,
            size: 18.0,
          ),
        ),
      ],
    );
  }

  buildDivider({double? bottom}) {
    return Padding(
      padding: bottom == null
          ? const EdgeInsets.symmetric(vertical: 15.0)
          : EdgeInsets.only(bottom: bottom),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  buildPostContent({String? postContent}) {
    return Text(
      '$postContent',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  buildPostTags() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 4.0),
              child: SizedBox(
                height: 25.0,
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 1.0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    '#software',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 4.0),
              child: SizedBox(
                height: 25.0,
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 1.0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    '#software',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 4.0),
              child: SizedBox(
                height: 25.0,
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 1.0,
                  padding: EdgeInsets.zero,
                  child: Text(
                    '#software',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildPostImage({String? postImage}) {
    return postImage.toString().isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              height: 160.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider('$postImage'),
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  buildLikesCount({int? likesNo = 0, int? commentNo = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
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
                      likesNo.toString(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      MyFlutterApp.comment,
                      size: 16.0,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${commentNo.toString()} comments',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildLikesAndShareButtons({String? image, String? postUid,List<PostLikes>? list}) {
    bool? isLiked = false;
    PostLikes? userLikesData;
    if (list!.isNotEmpty) {
      for (int x = 0; x <= list.length - 1; x++) {
        userLikesData = list[x];
        if (userLikesData.uId.toString() == Auth.currentUser!.uid.toString() &&
            userLikesData.postUid.toString() == postUid.toString()) {
          isLiked = true;
        }
      }
    }
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('$image'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  'write a comment ...',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => onLike(postUid: postUid,isLike: isLiked),
          child: Row(
            children: [
              isLiked! ?
              const Icon(
                MyFlutterApp.heart,
                size: 16.0,
                color: Colors.redAccent,
              )
                  :const Icon(
                MyFlutterApp.heart_empty,
                size: 16.0,
                color: Colors.redAccent,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                'Like',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        InkWell(
          onTap:onShare,
          child: Row(
            children: [
              const Icon(
                MyFlutterApp.share,
                size: 16.0,
                color: Colors.greenAccent,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                'Share',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> onLike({String? postUid,bool? isLike}) async {
    PostLikes postLikes = PostLikes();
    postLikes
      ..postUid = postUid
      ..uId = Auth.currentUser!.uid;
    if(isLike!){
      debugPrint('liked');
      await Api.removePostLike(postLikes, postUid).then((value) => loadPosts());
      setState(() {});
    }
    else{
      debugPrint('disliked');
      await Api.setPostLike(postLikes, postUid).then((value) => loadPosts());
      setState(() {});
    }

  }

  void onShare(){}

  Future<void> loadPosts() async {
    postList = await Api.getPosts();
    setState(() {});
  }




}



