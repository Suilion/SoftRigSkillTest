import 'package:flutter/material.dart';
import 'customer.dart';
import 'editPhonebook.dart';
import 'editUser.dart';
import 'constants.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:oauth_webauth/oauth_webauth.dart';
import 'package:http/http.dart' as http;

class ViewPhonebook extends StatefulWidget {
  const ViewPhonebook({Key? key}) : super(key: key);


  @override
  State<ViewPhonebook> createState() => _ViewPhonebookState();
}

class _ViewPhonebookState extends State<ViewPhonebook> {
  List SortableCustomerList = customers;
  bool hasLoaded = false;
  String apiResponse = 'API data will be shown here';
  String token = UserCredentials.Token;

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
                                          SortableCustomerList.sort((a, b) => a['Name'].compareTo(b['Name']));
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
                                          print(SortableCustomerList);
                                          SortableCustomerList.sort((a, b) => a['Name'].compareTo(b['Name']));
                                          SortableCustomerList.reversed;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Sort Reverse Alphabetically'),
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
            height: 400.0,
            child: ListView.separated(
              padding: const EdgeInsets.all(18),
              itemCount:SortableCustomerList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildExpandableTile(SortableCustomerList[index], context);
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }

  //This widget is what the list element will look like contracted and expanded
  Widget _buildExpandableTile(item, context) {
    return ExpansionTile(
      title: Text(
        item['Name'],
      ),
      children: <Widget>[
        ListTile(
          title: Text(
            (item['Adress'] + '\n' +  item['Email'] + '\n' +  item['Comment']),
            style: TextStyle(fontWeight: FontWeight.w700),

          ),
          subtitle: Column(
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
                              index: customers.indexOf(item),
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
                                content: Text('Are you sure you want to delete ' + item['Name'] + ' from the Phonebook?'),
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
                                          bool DeletedUser = false;

                                          //NB API Create delete user functionality here
                                          try {
                                            setState(() {

                                              //Delete user from local list
                                              final index = customers.indexOf(item);
                                              customers.removeAt(index);

                                              //API Run check if it worked.
                                              DeletedUser = true;

                                              //Display result to the user
                                            });
                                          } catch (e, s) {
                                            print(s);
                                          }

                                          if(DeletedUser) {
                                            final snackBar = SnackBar(
                                              content: const Text('User was deleted'),
                                            );

                                            // Find the ScaffoldMessenger in the widget tree
                                            // and use it to show a SnackBar.
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
        ),
      ],
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
        // If everything's fine, parse and use the response
        // Tip: Please read the https://developer.softrig.com/wiki/how-to/contacts
        final responseJson = jsonDecode(response.body);
        setState(() {
          apiResponse = responseJson.toString();
        });
      }
    } catch (error) {
      // Handle other errors like network issues, JSON decoding, etc.
      setState(() {
        apiResponse = "An error occurred: $error";
      });
    }
  }
}





