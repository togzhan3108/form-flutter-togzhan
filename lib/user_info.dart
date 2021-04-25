import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String number;
  final String country;
  final String email;
  UserInfo({this.name, this.number, this.country, this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.person,
              ),
              trailing: Text('$country'),
              title: Text('$name'),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.phone,
              ),
              title: Text(
                '$number',
              ),
            ),
          ),
        ],
      ),
    );
  }
}