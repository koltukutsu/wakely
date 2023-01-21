import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  color: Colors.purple,
                )),
            Expanded(
              flex: 3,
                child: TextButton(
                    onPressed: () {}, child: const Text("Take the Data")))
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
