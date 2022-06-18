import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../export_feature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    var homeRead = HomeProvider.read(context);
    var homeWatch = HomeProvider.watch(context);
    return Scaffold(
      drawer:const NavDrawer(),
      appBar: DefaultAppbar(
        titlesList: homeWatch.titles,
        titlesIndex: homeWatch.currentIndex,
        leading: Builder(builder: (context){
          return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {

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
      body: WillPopScope(

        onWillPop: (){
          setState(() {
            homeWatch.currentIndex = 0;
          });
          return onWillPop();
        },
        child: homeWatch.bottomNav[homeWatch.currentIndex],
      ),
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
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if ( currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ShowToastSnackBar.displayToast(message: 'Double tap the back button\nto close the app');
      return Future.value(false);
    }
    return Future.value(true);
  }

}

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
    HomeProvider.read(context).currentIndex = 0;
    await Auth.logout();
    ProgressCircleDialog.dismiss(context);
    openNewPage(context, const SplashScreen());
  }
}