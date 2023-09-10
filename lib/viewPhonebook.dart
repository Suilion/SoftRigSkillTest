import 'package:flutter/material.dart';
import 'customer.dart';

class ViewPhonebook extends StatelessWidget {
  const ViewPhonebook({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Phonebook'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount:customers.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildExpandableTile(customers[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
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
      )
    ],
  );
}

