import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../export_feature.dart';

class FeedsScreen extends StatefulWidget {

   const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<PostModel>? postList= [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
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
                      );
                    },
                  )
                : getCenterCircularProgress(),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostItem(context, PostModel? postModel,) {
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
            buildPostImage(postModel: postModel),
            buildLikesAndShareButtons(image: Auth.currentUser!.image, postModel: postModel,),
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

  buildPostImage({PostModel? postModel}) {
    return postModel!.postImage.toString().isNotEmpty
        ? InkWell(

            onTap: () => openNewPage(context,  FullImageScreen(postModel: postModel,)),
            child: Hero(
              tag: '${postModel.postImage}',
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  height: 160.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider('${postModel.postImage}'),
                    ),
                  ),
                ),
              ),
            ),
        )
        : const SizedBox();
  }

  buildLikesAndShareButtons({String? image,PostModel? postModel}) {
    bool? isLiked = false;
    PostLikes? userLikesData;
    if (postModel!.likes!.isNotEmpty) {
      for (int x = 0; x <= postModel.likes!.length - 1; x++) {
        userLikesData = postModel.likes![x];
        if (userLikesData.uId.toString() == Auth.currentUser!.uid.toString() &&
            userLikesData.postUid.toString() == postModel.postUid.toString()) {
          isLiked = userLikesData.isLiked;
        }
      }
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
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
                          postModel.likes!.length.toString(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    scaffoldKey.currentState!.showBottomSheet((context) => const CommentsBottomSheet());

                  },
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
                          '0 comments',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        buildDivider(bottom: 8.0),
        Row(
          children: [
            Expanded(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
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
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: ()async{
                await onLike(postUid: postModel.postUid, isLike: isLiked,postModel: postModel);
              },
              child: Row(
                children: [
                  isLiked!?
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
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap:() async => await onShare(postModel: postModel),
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
        ),
      ],
    );
  }

  Future<void> onLike({String? postUid,bool? isLike,PostModel? postModel}) async {

    PostLikes postLikes = PostLikes();
    postLikes
      ..postUid = postUid
      ..isLiked = isLike
      ..uId = Auth.currentUser!.uid;
    if(isLike!){
      debugPrint('disliked');
      debugPrint('$isLike');
      postModel!.likes!.removeWhere((element) => element.uId == Auth.currentUser!.uid);
      await Api.removePostLike(postLikes, postUid);
      setState(() {});
    }
    else{
      debugPrint('liked');
      debugPrint('$isLike');
      postModel!.likes!.add(postLikes);
      await Api.setPostLike(postLikes, postUid);
      setState(() {});

    }

  }

  Future<void> onShare({PostModel? postModel}) async{

    await Share.shareWithResult('Share Image');
    ///Share.share();

  }

  void onComment(){}

  Future<void> loadPosts() async {
    postList = await Api.getPosts();
    setState(() {});
  }

}

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({Key? key}) : super(key: key);

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  var commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: getScreenHeight(context) * 0.8,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
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
                    '1200',
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
              child: SingleChildScrollView(
                physics:const BouncingScrollPhysics() ,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatarWidget(
                            radius: 22.0,
                            showBackgroundImage: true,
                            backgroundImageUrl: 'https://img.freepik.com/free-photo/calm-handsome-bearded-caucasian-man-with-curious-expression-points-thumb-aside-blank-space-demonstrates-good-promo-place-your-advertising-wears-hoodie-poses-yellow-wall_273609-42131.jpg?w=1060&t=st%3D1652027475~exp%3D1652028075~hmac%3Dd748afab2e433d0c9d4f52f3e571c59b695b27195276c85d96b11ef406835256',
                          ),
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin:  const EdgeInsets.all(8.0),
                              elevation: 6.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Name'),
                                    SizedBox(height: 16.0,),
                                    Text('NameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeeNameNameNameme '),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10.0,);
                    },
                    itemCount: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ssdssa extends StatelessWidget {
  const ssdssa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
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
                  '1200',
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
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics() ,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatarWidget(
                          radius: 22.0,
                          showBackgroundImage: true,
                          backgroundImageUrl: 'https://img.freepik.com/free-photo/calm-handsome-bearded-caucasian-man-with-curious-expression-points-thumb-aside-blank-space-demonstrates-good-promo-place-your-advertising-wears-hoodie-poses-yellow-wall_273609-42131.jpg?w=1060&t=st%3D1652027475~exp%3D1652028075~hmac%3Dd748afab2e433d0c9d4f52f3e571c59b695b27195276c85d96b11ef406835256',
                        ),
                        Expanded(
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin:  const EdgeInsets.all(8.0),
                            elevation: 6.0,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Name'),
                                  SizedBox(height: 16.0,),
                                  Text('NameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeNameNameNaNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNameNamemeeNameNameNameme '),

                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10.0,);
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


