///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  16 Dec 2018
///
///

import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Colors,
        Container,
        EdgeInsets,
        FlatButton,
        Form,
        Icon,
        Icons,
        Key,
        ListView,
        Navigator,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Widget;

import '../Controller.dart' show Contact, Contacts, PostalAddress;

class AddContactPage extends StatefulWidget {
  AddContactPage({this.contact, Key key}) : super(key: key);
  final Contact contact;
  @override
  State<StatefulWidget> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  PostalAddress address = PostalAddress(label: "Home");

  @override
  void initState() {
    super.initState();
    Contacts.add.init(widget.contact);
    //   _address = PostalAddress(label: "Home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a contact"),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Contacts.add.onPressed();
                Navigator.of(context).pop();
              },
              child: Icon(Icons.save, color: Colors.white))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: Contacts.add.formKey,
            child: ListView(
              children: [
                Contacts.add.givenName.textFormField,
                Contacts.add.middleName.textFormField,
                Contacts.add.familyName.textFormField,
                Contacts.add.prefix.textFormField,
                Contacts.add.suffix.textFormField,
                Contacts.add.phone.textFormField,
                Contacts.add.email.textFormField,
                Contacts.add.company.textFormField,
                Contacts.add.jobTitle.textFormField,
                Contacts.add.street.textFormField,
                Contacts.add.city.textFormField,
                Contacts.add.region.textFormField,
                Contacts.add.postcode.textFormField,
                Contacts.add.country.textFormField,
              ],
            )),
      ),
    );
  }
}
