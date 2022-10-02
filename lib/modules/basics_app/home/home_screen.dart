import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  List<Widget> i = [
    const Text('h'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text(
          'first app',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_alert_sharp,
            ),
            onPressed: onNot,
          ),
          IconButton(
            onPressed: () {
              print("pi");
            },
            icon: const Icon(
              Icons.add_call,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const Text("hi shrouk",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void onNot() {
    print('hi');
  }
}
