import 'package:flutter/material.dart';
import 'customer.dart';
import 'constants.dart';

class EditUser extends StatefulWidget {
  final int index;
  const EditUser({Key? key, required this.index}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
                  labelText: customers[widget.index]['Name'],
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.house),
                  labelText: customers[widget.index]['Adress'],
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.mail),
                  labelText: customers[widget.index]['Email'],
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.comment),
                  labelText: customers[widget.index]['Comment'],
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
                    child: const Text('Submit Changes'),
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