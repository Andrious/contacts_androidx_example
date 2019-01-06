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
    return Scaffold(
      key: _scaffoldKey,
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
                  return Contacts.list.displayName.onDismissible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: _theme.canvasColor,
                          border: Border(
                              bottom: BorderSide(color: _theme.dividerColor))),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddContactPage(contact: c)));
                        },
                        leading: Contacts.list.displayName.circleAvatar,
                        title: Contacts.list.displayName.text,
                      ),
                    ),
                    dismissed: (DismissDirection direction) {
                      Contacts.edit.delete(c);
                      refreshContacts();
                      final String action =
                          (direction == DismissDirection.endToStart)
                              ? 'deleted'
                              : 'archived';
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 8000),
                          content: Text('You $action an item.'),
                          action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                Contacts.edit.undelete(c);
                                refreshContacts();
                              })));
                    },
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

//Dismissible(
//key: ObjectKey(c.id),
//direction: DismissDirection.endToStart,
//onDismissed: (DismissDirection direction) {
//Contacts.edit.delete(c);
//refreshContacts();
//final String action =
//(direction == DismissDirection.endToStart)
//? 'deleted'
//    : 'archived';
//_scaffoldKey.currentState?.showSnackBar(SnackBar(
//duration: Duration(milliseconds: 8000),
//content: Text('You $action an item.'),
//action: SnackBarAction(
//label: 'UNDO',
//onPressed: () {
//Contacts.edit.undelete(c);
//refreshContacts();
//})));
//},
//background: Container(
//color: Colors.red,
//child: const ListTile(
//trailing: const Icon(Icons.delete,
//color: Colors.white, size: 36.0))),
//child: Container(
//decoration: BoxDecoration(
//color: _theme.canvasColor,
//border: Border(
//bottom: BorderSide(color: _theme.dividerColor))),
//child: ListTile(
//onTap: () {
//Navigator.of(context).push(MaterialPageRoute(
//builder: (BuildContext context) =>
//AddContactPage(contact: c)));
//},
//leading: Contacts.list.displayName.circleAvatar,
//title: Contacts.list.displayName.textField,
//),
//),
//);

//Contacts.list.displayName.onDismissible(
//dismissed: (DismissDirection direction) {
//Contacts.edit.delete(Contacts.list.displayName.object);
//refreshContacts();
//final String action =
//(direction == DismissDirection.endToStart)
//? 'deleted'
//    : 'archived';
//_scaffoldKey.currentState?.showSnackBar(SnackBar(
//duration: Duration(milliseconds: 8000),
//content: Text('You $action an item.'),
//action: SnackBarAction(
//label: 'UNDO',
//onPressed: () {
//Contacts.edit.undelete(c);
//refreshContacts();
//})));
//});
