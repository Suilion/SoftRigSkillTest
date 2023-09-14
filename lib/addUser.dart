import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:skill_test/homePage.dart';
import 'package:skill_test/viewPhonebook.dart';
import 'constants.dart';
import 'response.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final myControllerRole = TextEditingController();
  final myControllerComment = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerRole.dispose();
    myControllerComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Center(
        // Only allowed to edit name, email, adress and comment
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: myControllerRole,
                decoration:  InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: "Name",
                ),
              ),
              TextFormField(
                controller: myControllerComment,
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
                      setState(() {
                        AddUser( myControllerRole.text, myControllerComment.text);
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
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
  void AddUser(String role, String comment) async {
    CustomModel user = CustomModel();
    String token = UserCredentials.Token;

    if (comment != null) {
      user.comment = comment;
    }
    if (role != null) {
      user.role = role;
    }
    try {
      final response = await http.post(

        Uri.parse('https://test-api.softrig.com/api/biz/contacts'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "CompanyKey": UserCredentials.companyKey,
          HttpHeaders.accessControlAllowOriginHeader: '*',
        },
        body: jsonEncode(user.toJson()), // Convert CustomModel to JSON
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to upload user.');
      }
    } catch (e) {
      throw();
    }
  }
}