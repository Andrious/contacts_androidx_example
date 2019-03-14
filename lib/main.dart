// https://github.com/fluttercommunity/flutter_contacts/tree/master/example
// https://pub.dartlang.org/packages/contacts_service#-readme-tab-

import 'package:flutter/material.dart' show runApp;

import 'package:mxc_application/mvc.dart' show MVC;

import 'package:contacts_androidx_example/view.dart' show ContactsExampleApp;

void main() => runApp(MVC(ContactsExampleApp()));
