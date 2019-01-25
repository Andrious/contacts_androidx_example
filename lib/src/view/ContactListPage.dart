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

  State createState() => _ContactListState();
}

class _ContactListState extends StateMVC<ContactListPage> {
  _ContactListState() : super(Contacts());

  @override
  void initState() {
    super.initState();
    Contacts.init();
    Contacts.list.refresh();
  }

  @override
  void dispose() {
    Contacts.disposed();
    super.dispose();
  }

  @override
  void onError(FlutterErrorDetails details) =>
      FlutterError.dumpErrorToConsole(details);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = App.theme;
    return Scaffold(
      key: Contacts.list.scaffoldKey,
      appBar: AppBar(title: Text('Contacts Plugin Example')),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("/add").then((_) {
              Contacts.list.refresh();
            });
          }),
      body: SafeArea(
        child: Contacts.list.items == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: Contacts.list.items?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Contact c = Contacts.list.items?.elementAt(index);
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
                      Contacts.list.refresh();
                      final String action =
                          (direction == DismissDirection.endToStart)
                              ? 'deleted'
                              : 'archived';
                      Contacts.list.scaffoldKey.currentState
                          ?.showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 8000),
                              content: Text('You $action an item.'),
                              action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    Contacts.edit.undelete(c);
                                    Contacts.list.refresh();
                                  })));
                    },
                  );
                },
              ),
      ),
    );
  }
}
