import 'package:flutter/material.dart';

import '../../../export_feature.dart';

class FullChatImageScreen extends StatelessWidget {
  final String? imageUrl;
  const FullChatImageScreen({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
                tag: imageUrl.toString(),
                child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  child: AspectRatio(
                      aspectRatio: 1.0,
                      child: ReusableCachedNetworkImage(
                          width: double.infinity,
                          imageUrl: imageUrl.toString())),
                )),
          ],
        ),
      ),
    );
  }
}
