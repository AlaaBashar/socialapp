import 'package:flutter/material.dart';

import '../../export_feature.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppbar(
        title: 'Add Post',
      ),
      body: Center(child: Text('Add Post')),
    );
  }
}
