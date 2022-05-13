import 'package:cached_network_image/cached_network_image.dart';
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
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(
              height: 10.0,
            ),
            itemBuilder: (context, index) {
              return buildPostItem(context);
            },
          ),
          const SizedBox(height: 10.0,),

        ],
      ),
    );
  }

  Widget buildPostItem(context) =>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.all(8.0),
    elevation: 6.0,
    child:  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children:  [

          Row(
            children:[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider('https://img.freepik.com/free-photo/natural-beautiful-girl-promoter-demonstrates-discounts-nice-offer-blank-space-upwards-points-index-finger-has-smile-with-dimples-cheeks_273609-38800.jpg?w=740&t=st=1652023741~exp=1652024341~hmac=0967b2bba0bb98956241965e7dacce519b13aab0e75722e8c32f2973fce52fcd'),
                  ),
                ),
              ),
              const SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Row(
                      children: const[
                        Text('Alaa Lahlouh',style: TextStyle(height: 1.4),),
                        SizedBox(width: 6.0,),

                        Icon(Icons.check_circle,color: Colors.blue,size: 18.0,)

                      ],
                    ),
                    Text('January 21, 2022 at 11:00 pm',
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
          Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0,bottom: 10.0),
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
          Container(
            height: 160.0,
            width: double.infinity,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image:const DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider('https://img.freepik.com/free-photo/calm-handsome-bearded-caucasian-man-with-curious-expression-points-thumb-aside-blank-space-demonstrates-good-promo-place-your-advertising-wears-hoodie-poses-yellow-wall_273609-42131.jpg?w=1060&t=st=1652027475~exp=1652028075~hmac=d748afab2e433d0c9d4f52f3e571c59b695b27195276c85d96b11ef406835256'),

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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider('https://img.freepik.com/free-photo/natural-beautiful-girl-promoter-demonstrates-discounts-nice-offer-blank-space-upwards-points-index-finger-has-smile-with-dimples-cheeks_273609-38800.jpg?w=740&t=st=1652023741~exp=1652024341~hmac=0967b2bba0bb98956241965e7dacce519b13aab0e75722e8c32f2973fce52fcd'),
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



