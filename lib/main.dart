import 'package:flutter/material.dart';
import 'constants.dart';
import 'viewPhonebook.dart';
import 'editPhonebook.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.DarkBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Phonebook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Image.asset("lib/resources/BookClosed.png"),
              iconSize: 500,
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewPhonebook()),
              );
              },
            ),
            Text('View Phonebook'),
            IconButton(
              icon: Image.asset("lib/resources/BookEdit.png"),
              iconSize: 500,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPhonebook()),
                );
              },
            ),
            Text('Edit Phonebook'),
          ],
        ),
      ),
    );
  }
}
