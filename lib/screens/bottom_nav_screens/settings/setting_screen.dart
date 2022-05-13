import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../export_feature.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserModel? userData = Auth.currentUser;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 230.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 180.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4.0),
                          topLeft: Radius.circular(4.0),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              CachedNetworkImageProvider('${userData!.cover}'),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 55.0,
                      backgroundImage: NetworkImage('${userData!.image}'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text('${userData!.name}',
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(
              height: 5.0,
            ),
            Text('${userData!.bio}', style: Theme.of(context).textTheme.caption),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('100',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Posts',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('265',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Photos',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('10k',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Followers',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('64',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Followings',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Add Photo',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )),
                const SizedBox(
                  width: 16.0,
                ),
                OutlinedButton(
                  onPressed: ()=> onEditSettings(userData: userData),
                  child: const Icon(
                    MyFlutterApp.edit,
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
  void loadUserData() async {
    userData = await Api.getUserFromUid(uid:userData!.uid);
    setState(() {});
  }
  void onEditSettings({UserModel? userData})  {
     openNewPage(context,  EditSettingsScreen(userData: userData!,)).then((value) {
      if(value == true){
        debugPrint(value.toString());
        loadUserData();
      }
    });
  }
}
