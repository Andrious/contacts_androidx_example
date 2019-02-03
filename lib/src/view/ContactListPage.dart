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

import 'package:flutter/material.dart'
    show
        AppBar,
        Border,
        BorderSide,
        BoxDecoration,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Container,
        DismissDirection,
        FloatingActionButton,
        Icon,
        Icons,
        Key,
        ListTile,
        ListView,
        MaterialPageRoute,
        Navigator,
        SafeArea,
        Scaffold,
        SnackBar,
        SnackBarAction,
        State,
        StatefulWidget,
        Text,
        ThemeData,
        Widget;

import '../model.dart' show Contact;

import '../view.dart' show ContactDetailsPage, StateMVC;

import '../controller.dart' show Controller;

class ContactListPage extends StatefulWidget {
  ContactListPage({Key key}) : super(key: key);

  State createState() => _ContactListState();
}

class _ContactListState extends StateMVC<ContactListPage> {
  _ContactListState() : super(con);
  static final Controller con = Controller();
  
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = App.theme;
    return Scaffold(
      key: con.list.scaffoldKey,
      appBar: AppBar(title: Text('Contacts Plugin Example')),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("/add").then((_) {
              con.list.refresh();
            });
          }),
      body: SafeArea(
        child: con.list.items == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: con.list.items?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Contact c = con.list.items?.elementAt(index);
                  con.list.init(c);
                  return con.list.displayName.onDismissible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: _theme.canvasColor,
                          border: Border(
                              bottom: BorderSide(color: _theme.dividerColor))),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ContactDetailsPage(contact: c)));
                        },
                        leading: con.list.displayName.circleAvatar,
                        title: con.list.displayName.text,
                      ),
                    ),
                    dismissed: (DismissDirection direction) {
                      Controller.edit.delete(c);
                      con.list.refresh();
                      final String action =
                          (direction == DismissDirection.endToStart)
                              ? 'deleted'
                              : 'archived';
                      con.list.scaffoldKey.currentState
                          ?.showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 8000),
                              content: Text('You $action an item.'),
                              action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    Controller.edit.undelete(c);
                                    con.list.refresh();
                                  })));
                    },
                  );
                },
              ),
      ),
    );
  }
}
