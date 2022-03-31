import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../export_feature.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Counter.read(context).changeAppMode();
            },
            icon: Icon(context.watch<Counter>().modeIcon),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => Counter.read(context).decrement(),
                  child: const Icon(Icons.minimize),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text('${Counter.watch(context).count}'),
                const SizedBox(
                  width: 20.0,
                ),
                FloatingActionButton(
                  onPressed: () => Counter.read(context).increment(),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
