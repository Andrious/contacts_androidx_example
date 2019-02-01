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


import '../model.dart' show Contact;

import '../controller.dart' show Controller;


class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage(this._contact, {Key key}) : super(key: key) {
    Controller.edit.init(_contact);
  }
  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Controller.edit.displayName.text, actions: <Widget>[
          FlatButton(
              child: Icon(Icons.delete),
              onPressed: () {
                Controller.edit.delete(_contact);
                Controller.rebuild();
                Navigator.of(context).pop();
              })
        ]),
        body: SafeArea(
          child: ListView(
            children: [
              Controller.edit.givenName.listTile,
              Controller.edit.middleName.listTile,
              Controller.edit.familyName.listTile,
              Controller.edit.prefix.listTile,
              Controller.edit.suffix.listTile,
              Controller.edit.company.listTile,
              Controller.edit.jobTitle.listTile,
              Controller.edit.phone.listItems,
              Controller.edit.email.listItems,
            ],
          ),
        ));
  }
}
