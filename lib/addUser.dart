import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:skill_test/homePage.dart';
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
    myControllerRole.dispose();
    myControllerComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //need a key to get the results from the form and send them onwards
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: myControllerRole,
                decoration:  InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: "Role",
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
    String token = UserCredentials.Token;

    //Empty user
    CustomModel user = CustomModel();

    //Make sure that the user wrote something, if not, it will create a user with default everything
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