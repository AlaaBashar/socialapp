import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../export_feature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin  {

  late final AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      vsync:this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var homeRead = HomeProvider.read(context);
    var homeWatch = HomeProvider.watch(context);
    bool expanded = true;

    return Scaffold(
      drawer:const NavDrawer(),
      onDrawerChanged: (onDrawerChanged){
        debugPrint('onDrawerChanged? $onDrawerChanged');
        onDrawerChanged ? controller.forward(): controller.reverse();
        setState(() {});

      },
      appBar: DefaultAppbar(
        titlesList: homeWatch.titles,
        titlesIndex: homeWatch.currentIndex,
        leading: Builder(builder: (context){
          return IconButton(
              icon: AnimatedIcon(

                icon: AnimatedIcons.menu_home,
                progress: controller,
                semanticLabel: 'Show menu',
              ),
              onPressed: () {
                expanded ? controller.forward() : controller.reverse();
                expanded = !expanded;
                Scaffold.of(context).openDrawer();
            },
          );
        },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(MyFlutterApp.notifications),
          ),
          IconButton(
          onPressed: () {
          },
          icon: const Icon(MyFlutterApp.search),
        ),
          IconButton(
            onPressed: () {
              ChangeMode.read(context).changeAppMode();
            },
            icon: Icon(context.watch<ChangeMode>().modeIcon),
          ),
        ],),
      body:homeWatch.bottomNav[homeWatch.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => homeRead.onChangeIndexOfNav(index: index,context: context),
        currentIndex: homeWatch.currentIndex,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.home_2),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.chat_1),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.upload),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.user),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(

        children: [
          DrawerHeader(
            decoration:Auth.currentUser!.cover!.isNotEmpty
            ?BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider('${Auth.currentUser!.cover}'),
              ),
            )
            :const BoxDecoration(
              color: Colors.blue,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage('${Auth.currentUser!.image}'),
                    ),
                  ),
                  Text(
                    "${Auth.currentUser!.name}",
                    style:  TextStyle(color: Colors.grey.shade300,fontSize: 16.0,
                      fontWeight: FontWeight.bold,),
                  ),
                  Text(
                    "${Auth.currentUser!.email}",
                    style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey.shade300),
                  ),

                ],
              ),
            ),
          ),

          ListTile(
            title: const Text("Log Out"),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
            onTap: onLogout,
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  void onLogout() async {
    ProgressCircleDialog.show(context);
    await Auth.logout();
    ProgressCircleDialog.dismiss(context);
    openNewPage(context, const SplashScreen());
  }
}