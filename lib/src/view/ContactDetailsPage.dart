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
        FlatButton,
        Icon,
        Icons,
        Key,
        ListView,
        Navigator,
        SafeArea,
        Scaffold,
        StatelessWidget,
        Widget;

import '../Controller.dart' show Contact, Contacts;

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage(this._contact, {Key key}) : super(key: key) {
    Contacts.edit.init(_contact);
  }
  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Contacts.edit.displayName.text,
            actions: <Widget>[
              FlatButton(
                  child: Icon(Icons.delete),
                  onPressed: () {
                    Contacts.edit.delete(_contact);
                    Contacts.rebuild();
                    Navigator.of(context).pop();
                  })
            ]),
        body: SafeArea(
          child: ListView(
            children: [
              Contacts.edit.givenName.listTile,
              Contacts.edit.middleName.listTile,
              Contacts.edit.familyName.listTile,
              Contacts.edit.prefix.listTile,
              Contacts.edit.suffix.listTile,
              Contacts.edit.company.listTile,
              Contacts.edit.jobTitle.listTile,
              Contacts.edit.phone.listItems,
              Contacts.edit.email.listItems,
            ],
          ),
        ));
  }
}
