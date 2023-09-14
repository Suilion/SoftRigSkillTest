import 'package:flutter/material.dart';
import 'customer.dart';
import 'constants.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Center(
        // Only allowed to edit name, email, adress and comment
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: myController,
                decoration:  InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: "Name",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.house),
                  labelText: 'Adress',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.mail),
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.comment),
                  labelText: 'Comment',
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: ColorConstants.DarkBlue,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      print(myController.text);
                      //Update variables to the user
                      Navigator.pop(context);
                    },
                    child: const Text('Submit User'),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}