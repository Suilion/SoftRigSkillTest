import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:skill_test/response.dart';
import 'constants.dart';
import 'viewPhonebook.dart';

class EditUser extends StatefulWidget {
  final CustomModel user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
        title: const Text('Edit User'),
      ),
      body: Center(
        // Only allowed to edit role and comment.
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  controller: myControllerRole,
                  decoration:  InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: widget.user.role,
                ),
              ),
              TextFormField(
                controller: myControllerComment,
                decoration: InputDecoration(
                  icon: const Icon(Icons.comment),
                  labelText: widget.user.comment,
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
                        updateUser(widget.user, myControllerRole.text, myControllerComment.text);
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ViewPhonebook()),
                      );
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

void updateUser(CustomModel user, String role, String comment) async {
  String token = UserCredentials.Token;
  int? userId = user.id;
  if(comment != null){
    user.comment = comment;
  }
  if(role != null){
    user.role = role;
  }
  try{
    final response = await http.put(

      Uri.parse('https://test-api.softrig.com/api/biz/contacts/$userId'),
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
      throw Exception('Failed to update album.');
    }
  } catch (e){
    throw();
  }

}