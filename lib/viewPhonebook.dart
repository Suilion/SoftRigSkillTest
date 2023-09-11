import 'package:flutter/material.dart';
import 'customer.dart';
import 'editPhonebook.dart';
import 'constants.dart';

class ViewPhonebook extends StatelessWidget {
  const ViewPhonebook({super.key});


  @override
  Widget build(BuildContext context) {
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
                        icon: Image.asset("lib/resources/BookClosed.png"), //NB change icon
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('Filter'),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              icon: Icon(Icons.account_box),
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
                                        //NB Add what happens when you apply the filter
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Apply'),
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
          SizedBox(
            height: 400.0,
            child: ListView.separated(
              padding: const EdgeInsets.all(18),
              itemCount:customers.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildExpandableTile(customers[index]);
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
//This widget is what the list element will look like contracted and expanded
Widget _buildExpandableTile(item) {
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
                      //NB add connection when that page is created
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
                      //Create popup asking if you want to confirm the deletion
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

