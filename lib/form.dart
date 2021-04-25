import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_flutter_togzhan/user_info.dart';
import 'dart:io' show Platform;
import 'package:form_field_validator/form_field_validator.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String name;
  String phoneNumber;
  String email;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  List<Text> countryList = [
    Text('Russia'),
    Text('USA'),
    Text('Kazakhstan'),
    Text('Germany'),
    Text('France'),
  ];
  Text selectedCountry = Text('Kazakhstan');

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      hint: Text('Country'),
      value: selectedCountry.toString(),
      items: countryList.map((Text country) {
        return DropdownMenuItem<String>(
          value: country.toString(),
          child: country,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCountry = Text(value);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCountry = countryList[selectedIndex];
        });
      },
      children: countryList,
    );
  }

  void _openCupertinoDialog(ctx) {
    showCupertinoDialog(
      context: ctx,
      builder: (_) => CupertinoAlertDialog(
        title: Text("Registration Succesfull"),
        content: Text("$name is now verified account!"),
        actions: [
          CupertinoButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(ctx).pop();
              }),
          CupertinoButton(
            child: Text('Verified'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfo(
                    name: name,
                    number: phoneNumber,
                    country: selectedCountry.data,
                    email: email,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: true,
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Full Name *',
                    hintText: 'What do people call you?',
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(
                      onPressed: () {
                        nameController.clear();
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  validator: RequiredValidator(errorText: "* Required"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Phone Number *',
                    hintText: 'Phone format(xxx)-xxx-xxxx',
                    prefixIcon: Icon(Icons.phone),
                    suffixIcon: IconButton(
                      onPressed: () {
                        phoneController.clear();
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                  validator: RequiredValidator(errorText: "* Required"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    prefixIcon: Icon(Icons.email),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                child: Platform.isIOS ? iOSPicker() : androidDropdown(),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 20),
                width: double.infinity,
                height: 40,
                color: Colors.green[300],
                child: TextButton(
                  onPressed: () {
                    _openCupertinoDialog(context);
                  },
                  child: Text(
                    'Submit Form',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}