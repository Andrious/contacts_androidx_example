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

import 'package:flutter/material.dart' show FlutterError, FlutterErrorDetails;

/// The Controller talks to the Model
import '../model.dart'
    show Contact, ContactsService, ContactAdd, ContactEdit, ContactList;

import '../controller.dart' show ControllerMVC;

class Controller extends ControllerMVC {
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }
  static Controller _this;

  Controller._() : super();

  @override
  void initState() {
    init();
    list.refresh();
  }

  @override
  void dispose() {
    disposed();
    super.dispose();
  }

  static void init() => ContactsService.initState();

  static void disposed() => ContactsService.dispose();

  @override
  void onError(FlutterErrorDetails details) =>
      FlutterError.dumpErrorToConsole(details);

  static void rebuild() => _this.refresh();

  static Future<List<Contact>> getContacts() => ContactsService.getContacts();

  static ContactAdd get add => _addContacts;
  static ContactAdd _addContacts = ContactAdd();

  static ContactEdit get edit => _editContacts;
  static ContactEdit _editContacts = ContactEdit();

  ContactList get list => _listContacts;
  static ContactList _listContacts = ContactList();
}
