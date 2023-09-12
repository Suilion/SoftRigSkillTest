import 'package:flutter/material.dart';
import 'viewPhonebook.dart';
import 'editPhonebook.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Image.asset("lib/resources/BookClosed.png"),
              iconSize: 250,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewPhonebook()),
                );
              },
            ),
            Text('View Phonebook'),
            IconButton(
              icon: Image.asset("lib/resources/BookEdit.png"),
              iconSize: 250,
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