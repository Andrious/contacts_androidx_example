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

import 'package:mvc_application/app.dart' show App;

import 'package:flutter/material.dart';

import '../Controller.dart' show Contact, Contacts;

import '../View.dart' show AddContactPage, StateMVC;

class ContactListPage extends StatefulWidget {
  ContactListPage({Key key}) : super(key: key);
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends StateMVC {
  _ContactListPageState() : super(Contacts());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ThemeData _theme = App.theme;

  List<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    Contacts.init();
    refreshContacts();
  }

  @override
  void dispose() {
    Contacts.disposed();
    super.dispose();
  }

  @override
  void onError(FlutterErrorDetails details) =>
      FlutterError.dumpErrorToConsole(details);

  refreshContacts() async {
    var contacts = await Contacts.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    Contacts.list.build(context, refreshContacts);
    return Scaffold(
      key: Contacts.list.scaffoldKey,
      appBar: AppBar(title: Text('Contacts Plugin Example')),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("/add").then((_) {
              refreshContacts();
            });
          }),
      body: SafeArea(
        child: _contacts != null
            ? ListView.builder(
                itemCount: _contacts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Contact c = _contacts?.elementAt(index);
                  Contacts.list.init(c);
                  return Contacts.list.displayName.dismissible;
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}