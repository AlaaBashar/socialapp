
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../export_feature.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static HomeProvider watch(context) => Provider.of(context,); ///watch-function ///get variables
  static HomeProvider read(context)  => Provider.of(context,listen: false); ///read-function ///Implement functions

  int currentIndex = 0;
  List<String> titles = [
   'Home',
   'Chats',
   'New Post',
   'Users',
   'Settings',
  ];
  List<Widget> bottomNav = [
    const FeedsScreen(),
    const ChatScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];
  void onChangeIndexOfNav({int? index, context}) {

    if(index == 2){
      openNewPage(context, const NewPostScreen());
    }
    else{
      currentIndex = index!;

    }
    notifyListeners();
  }


}














