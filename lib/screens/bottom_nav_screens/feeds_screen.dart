import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../export_feature.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

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
              children:  [
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
          StreamBuilder<QuerySnapshot>(
            stream: Api.db.collection(CollectionsFireStoreKeys.POSTS).snapshots(),
            builder: (context,snapshot) {
              if(!snapshot.hasData){
                return getCenterCircularProgress();
              }
              List<QueryDocumentSnapshot<Object?>> postList = snapshot.data!.docs;
              return ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount:postList.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10.0,
                ),
                itemBuilder: (context, index) {
                  return buildPostItem(context,postList[index]);
                },
              );
            },
          ),
          // ListView.separated(
          //   physics: const ScrollPhysics(),
          //   shrinkWrap: true,
          //   itemCount: 10,
          //   separatorBuilder: (context, index) => const SizedBox(
          //     height: 10.0,
          //   ),
          //   itemBuilder: (context, index) {
          //     return buildPostItem(context);
          //   },
          // ),
          const SizedBox(height: 10.0,),

        ],
      ),
    );
  }

  Widget buildPostItem(context, QueryDocumentSnapshot? postList) =>Card(

    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.all(8.0),
    elevation: 6.0,
    child:  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            children:[
              Container(
                width: 50.0,
                height: 50.0,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider('${postList!['user']['image']}'),
                  ),
                ),
              ),
              const SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Row(
                      children: [
                        Text('${postList['user']['name']}',style: const TextStyle(height: 1.4),),
                        const SizedBox(width: 6.0,),
                        const Icon(Icons.check_circle,color: Colors.blue,size: 18.0,)

                      ],
                    ),
                    Text('${postList['date']}',
                      style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4),
                    ),

                  ],
                ),
              ),
              const SizedBox(width: 10.0,),
              IconButton(onPressed: (){}, icon: const Icon(MyFlutterApp.more_horiz,size: 18.0,),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text('${postList['postContent']}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0,),
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
                        child:  Text('#software',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.blue),),
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
                        child:  Text('#software',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.blue),),
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
                        child:  Text('#software',style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.blue),),
                      ),
                    ),
                  ),

                ],),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              height: 160.0,
              width: double.infinity,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider('${postList['postImage']}'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(children: [
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(children:  [
                      const Icon(MyFlutterApp.heart,size: 16.0,color: Colors.redAccent,),
                      const SizedBox(width: 5.0,),
                      Text('1200',style: Theme.of(context).textTheme.caption,),

                    ],),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(MyFlutterApp.comment,size: 16.0,color: Colors.amber,),
                        const SizedBox(width: 5.0,),
                        Text('1200 comments',style: Theme.of(context).textTheme.caption,),

                      ],),
                  ),
                ),
              ),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:[
              Expanded(
                child: InkWell(
                  onTap:(){},
                  child: Row(
                    children: [
                      Container(
                        width: 35.0,
                        height: 35.0,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider('${postList['user']['image']}'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0,),
                      Text('write a comment ...',
                        style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Row(children:  [
                  const Icon(MyFlutterApp.heart,size: 16.0,color: Colors.redAccent,),
                  const SizedBox(width: 5.0,),
                  Text('Like',style: Theme.of(context).textTheme.caption,),

                ],),
              ),
              const SizedBox(width: 8.0,),
              InkWell(
                onTap: (){},
                child: Row(children:  [
                  const Icon(MyFlutterApp.share,size: 16.0,color: Colors.greenAccent,),
                  const SizedBox(width: 5.0,),
                  Text('Share',style: Theme.of(context).textTheme.caption,),

                ],),
              ),




            ],
          ),
        ],
      ),
    ),
  );

}



