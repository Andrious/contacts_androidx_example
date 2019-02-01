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
///          Created  18 Dec 2018
///
///
import 'dart:async' show Future;

import 'dart:core'
    show Future, List, Map, MapEntry, String, bool, dynamic, int, override;

import 'package:sqflite/sqflite.dart' show Database;

import 'package:dbutils/sqllitedb.dart' show DBInterface;

import '../model.dart' show Contact;

class ContactsService extends DBInterface {
  factory ContactsService() {
    if (_this == null) _this = ContactsService._();
    return _this;
  }

  /// Make only one instance of this class.
  static ContactsService _this;

  /// Allow for easy access to this class throughout the application.
  static ContactsService get mod => _this ?? ContactsService();

  ContactsService._() : super();

  @override
  get name => 'Contacts';

  @override
  get version => 1;

  static initState() {
    ContactsService().init();
  }

  static void dispose() {
    ContactsService().disposed();
  }

  Future onConfigure(Database db) {
    return db.execute("PRAGMA foreign_keys=ON;");
  }

  @override
  Future onCreate(Database db, int version) async {
    await db.execute("""
     CREATE TABLE Contacts(
              id INTEGER PRIMARY KEY
              ,displayName TEXT
              ,givenName TEXT
              ,middleName TEXT
              ,prefix TEXT
              ,suffix TEXT
              ,familyName TEXT
              ,company TEXT
              ,jobTitle TEXT
              ,deleted INTEGER DEFAULT 0
              )
     """);
//               ,FOREIGN KEY (userid) REFERENCES Contacts (id)
    await db.execute("""
     CREATE TABLE Emails(
              id INTEGER PRIMARY KEY
              ,userid INTEGER
              ,label TEXT
              ,email TEXT
              ,deleted INTEGER DEFAULT 0
              ,FOREIGN KEY (userid) REFERENCES Contacts (id)
              )
     """);

    await db.execute("""
     CREATE TABLE Phones(
              id INTEGER PRIMARY KEY
              ,userid INTEGER
              ,label TEXT
              ,phone TEXT
              ,deleted INTEGER DEFAULT 0
              )
     """);

    await db.execute("""
     CREATE TABLE Addresses(
              id INTEGER PRIMARY KEY
              ,userid INTEGER
              ,label TEXT
              ,address TEXT
              ,deleted INTEGER DEFAULT 0
              )
     """);
  }

  static Future<List<Contact>> getContacts() async {
    return listContacts(
        await _this.rawQuery('SELECT * FROM Contacts WHERE deleted = 0'));
  }

  static List<Contact> listContacts(List<Map<String, dynamic>> query) {
    List<Contact> contactList = [];
    for (var contact in query) {
      Map<String, dynamic> map = contact.map((key, value) {
        return MapEntry(key, value is int ? value?.toString() : value);
      });
      contactList.add(Contact.fromMap(map));
    }
    return contactList;
  }

  static Future<bool> addContact(Map contact) async {
//   return _this.runTxn(() async {
    bool add = await _this.saveMap('Contacts', contact);
//       await _this.saveMap('emails', contact['emails']);
//       await _this.saveMap('phones', contact['phones']);
//       await _this.saveMap('addresses', contact['postalAddresses']);
    return add;
//   });
  }

  static Future<int> deleteContact(Map contact) async {
    var id = contact['id'];
    if (id == null) return Future.value(0);
    if (id is String) id = int.parse(id);
    List<Map<String, dynamic>> query =
        await _this.rawQuery('UPDATE Contacts SET deleted = 1 WHERE id = $id');
    return query.length;
//    return _this.delete('Contacts', id);
  }

  static Future<int> undeleteContact(Map contact) async {
    var id = contact['id'];
    if (id == null) return Future.value(0);
    if (id is String) id = int.parse(id);
    List<Map<String, dynamic>> query =
        await _this.rawQuery('UPDATE Contacts SET deleted = 0 WHERE id = $id');
    return query.length;
//    return _this.delete('Contacts', id);
  }
}
