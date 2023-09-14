import 'package:flutter/material.dart';
import 'package:skill_test/response.dart';
import 'editPhonebook.dart';
import 'editUser.dart';
import 'constants.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ViewPhonebook extends StatefulWidget {
  const ViewPhonebook({Key? key}) : super(key: key);


  @override
  State<ViewPhonebook> createState() => _ViewPhonebookState();
}

class _ViewPhonebookState extends State<ViewPhonebook> {
  bool hasLoaded = false;
  String apiResponse = 'API data will be shown here';
  String token = UserCredentials.Token;
  CustomModel defaultModel = CustomModel();
  List <CustomModel> customModels = [];

  @override
  Widget build(BuildContext context) {
    //Fetching data from api
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
        title: const Text('View Phonebook'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: IconButton(
                        icon: Image.asset("lib/resources/BookClosed.png"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditPhonebook()),
                          );
                        },
                      ),
                    ),
                    Text("Edit Phonebook"),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: IconButton(
                        icon: Image.asset("lib/resources/Filter.png"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('Filter'),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: ColorConstants.DarkBlue,
                                        padding: const EdgeInsets.all(16.0),
                                        textStyle: const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          customModels.sort((a, b) => (a.role ?? '').compareTo(b.role ?? ''));
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Sort Alphabetically'),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: ColorConstants.DarkBlue,
                                        padding: const EdgeInsets.all(16.0),
                                        textStyle: const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          customModels.sort((a, b) {
                                            int lengthA = a.role?.length ?? 0;
                                            int lengthB = b.role?.length ?? 0;
                                            return lengthB.compareTo(lengthA);
                                          });
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Sort By Role lenght'),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                    Text("Filter"),
                  ],
                ),
              ]
            ),
          ),
          if(hasLoaded)
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: customModels.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text('Role ${customModels[index].role}'),
                    children: <Widget>[
                      ListTile(
                        title: Text('Comment: ${customModels[index].comment}'),
                      ),
                      Column(
                        children: <Widget>[
                          Center(
                            child: Row(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorConstants.DarkBlue,
                                    padding: const EdgeInsets.all(16.0),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditUser(
                                          user: customModels[index],
                                        ),
                                      ),
                                    );

                                  },
                                  child: const Text('Edit User'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorConstants.AttentionRed,
                                    padding: const EdgeInsets.all(16.0),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: Text('Delete User?'),
                                            content: Text('Are you sure you want to delete  ${customModels[index].role} from the Phonebook?'),
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
                                                          for(int i = 0; i < customModels.length; i++){
                                                            if (customModels[i].role == customModels[index].role) {
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
                                                        //delete local instance
                                                        customModels.removeAt(index);
                                                        const snackBar = SnackBar(
                                                          content: Text('User was deleted'),
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
                                  },
                                  child: const Text('Delete User'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
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





