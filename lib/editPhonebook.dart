import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:skill_test/response.dart';
import 'editUser.dart';
import 'constants.dart';
import 'addUser.dart';
import 'viewPhonebook.dart';

class EditPhonebook extends StatefulWidget {
  const EditPhonebook({Key? key}) : super(key: key);

  @override
  _EditPhonebookState createState() => _EditPhonebookState();
}

class _EditPhonebookState extends State<EditPhonebook> {
  bool hasLoaded = false;
  bool deleteUser = false;
  String apiResponse = 'API data will be shown here';
  String token = UserCredentials.Token;

  CustomModel defaultModel = CustomModel();
  List <CustomModel> customModels = [];

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Fetching data from the api
    if(!hasLoaded){
      goApiFetch();
      if (!apiResponse.contains("Error")){
        setState(() {
          hasLoaded = true;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Phonebook'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(50),
              child: Text("I want to...", style: TextStyle(fontSize: 25),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddUser()),
                  );
                },
                icon: Image.asset("lib/resources/AddUser.png",
                  height: 100,
                  width: 100,),
                label: Text(' Add a new person'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text('Enter role of User you want to edit'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: myController,
                                  decoration: InputDecoration(
                                    labelText: 'Role',
                                    icon: Icon(Icons.person),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: ColorConstants.DarkBlue,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              setState(() {

                                //Searching to locate the user
                                var index = -1;

                                for(int i = 0; i < customModels.length; i++){
                                  if (customModels[i].role == myController.text) {
                                    index = i;
                                  }
                                }
                                //If user was found
                                if (index != -1) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditUser(
                                        user: customModels[index],
                                      ),
                                    ),
                                  );

                                } else {
                                  final snackBar = SnackBar(
                                    content: const Text('Could not find user'),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: const Text('Search'),
                          ),
                        ],
                      );
                    });
                },
                icon: Image.asset("lib/resources/EditUser.png",
                  height: 100,
                  width: 100,),
                label: Text('Edit existing person'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('Enter role of the User you want to delete'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: myController,
                                    decoration: InputDecoration(
                                      labelText: 'Role',
                                      icon: Icon(Icons.person),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: ColorConstants.DarkBlue,
                                padding: const EdgeInsets.all(16.0),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                //Searching for user
                                var index = -1;

                                for(int i = 0; i < customModels.length; i++){
                                  if (customModels[i].role == myController.text) {
                                    index = i;
                                  }
                                }
                                //If user was found
                                if (index != -1) {
                                  Navigator.pop(context);

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: Text('Delete User?'),
                                          content: Text('Are you sure you want to delete ' + myController.text + ' from the Phonebook?'),
                                          actions: [
                                            Row(
                                              children: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: ColorConstants.DarkBlue,
                                                    padding: const EdgeInsets.all(16.0),
                                                    textStyle: const TextStyle(fontSize: 20),
                                                  ),
                                                  onPressed: () {
                                                    //Does not want to delete user after all
                                                    deleteUser = false;
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('No'),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: ColorConstants.AttentionRed,
                                                    padding: const EdgeInsets.all(16.0),
                                                    textStyle: const TextStyle(fontSize: 20),
                                                  ),
                                                  onPressed: () {
                                                    bool userWasDeleted = false;

                                                    try {
                                                      setState(() {
                                                        //Find the one to delete, and remove it from api
                                                        for(int i = 0; i < customModels.length; i++){
                                                          if (customModels[i].role == myController.text) {
                                                            DeleteUser(customModels[i]);
                                                            userWasDeleted = true;
                                                            break;
                                                          }
                                                        }
                                                      });
                                                    } catch (e, s) {
                                                      print(s);
                                                    }

                                                    if(userWasDeleted) {
                                                      final snackBar = SnackBar(
                                                        content: const Text('User was deleted'),
                                                      );

                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  final snackBar = SnackBar(
                                    content: const Text('Could not find user'),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Search'),
                            ),
                          ],
                        );
                      });



                },
                icon: Image.asset("lib/resources/DeleteUser.png",
                  height: 100,
                  width: 100,),
                label: Text('    Delete a person'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
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
  void goApiFetch() async {
    try {
      final response = await http.get(
        Uri.parse('https://test-api.softrig.com/api/biz/contacts?expand=Info,Info.InvoiceAddress,Info.DefaultPhone,Info.DefaultEmail,Info.DefaultAddress&hateoas=false'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json, text/plain, */*',
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "CompanyKey": UserCredentials.companyKey,
          HttpHeaders.accessControlAllowOriginHeader: '*',
        },
      );


      // Check for error status codes
      if (response.statusCode == 401) {
        // Handle unauthorized error
        // For simplicity, we're just setting the state. You might want to show an alert or navigate the user.
        setState(() {
          apiResponse = "Error 401: Unauthorized. Check your credentials.";
        });

      } else if (response.statusCode == 403) {
        // Handle forbidden error
        setState(() {
          apiResponse = "Error 403: Forbidden. You don't have permission.";
        });

      } else if (response.statusCode != 200) {
        // Handle other status codes
        setState(() {
          apiResponse = "Error ${response.statusCode}: ${response.reasonPhrase}";
        });

      } else {
        setState(() {
          List responseJson = jsonDecode(response.body);
          for (int i = 0; i < responseJson.length; i++){
            defaultModel = CustomModel.fromJson(responseJson[i]);
            customModels.add(defaultModel);
          }
          apiResponse = "Data fetched";
        });
      }
    } catch (error) {
      // Handle other errors like network issues, JSON decoding, etc.
      setState(() {
        apiResponse = "An error occurred: $error";
      });
    }
  }

  void DeleteUser(CustomModel user) async {
    String token = UserCredentials.Token;
    int? userId = user.id;
    try {
      final response = await http.delete(

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
        throw Exception('Failed to update user.');
      }
    } catch (e) {
      throw();
    }
  }
}