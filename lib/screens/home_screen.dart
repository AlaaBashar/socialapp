import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../export_feature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var homeRead = HomeProvider.read(context);
    var homeWatch = HomeProvider.watch(context);
    return Scaffold(
      drawer:const NavDrawer(),
      appBar: DefaultAppbar(
        titlesList: homeWatch.titles,
        titlesIndex: homeWatch.currentIndex,
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
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 40,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      "${Auth.currentUser!.name}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    IconButton(
                      onPressed: () {
                        ChangeMode.read(context).changeAppMode();
                      },
                      icon: Icon(context.watch<ChangeMode>().modeIcon),
                    ),
                  ],
                ),
                Text(
                  "${Auth.currentUser!.email}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
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