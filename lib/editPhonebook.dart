import 'package:flutter/material.dart';
import 'viewPhonebook.dart';

class EditPhonebook extends StatelessWidget {
  const EditPhonebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Phonebook'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(50), //apply padding to all four sides
              child: Text("I want to...", style: TextStyle(fontSize: 25),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  //Pupup form which consists of user information
                  //Apply adds it to the api
                },
                icon: Image.asset("lib/resources/AddUser.png",
                  height: 100,
                  width: 100,),
                label: Text('Add a new person'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  //Create function to search for specific user
                  //Go to edit
                  //Connect edit from viewPhonebook as well to this page
                  //Upload edit to the api
                },
                icon: Image.asset("lib/resources/EditUser.png",
                  height: 100,
                  width: 100,),
                label: Text('Edit an existing person'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  //Search, then delete from api
                },
                icon: Image.asset("lib/resources/DeleteUser.png",
                  height: 100,
                  width: 100,),
                label: Text('Delete a person'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewPhonebook()),
                  );
                },
                icon: Image.asset("lib/resources/BookClosed.png",
                  height: 100,
                  width: 100,),
                label: Text('View the phonebook'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}