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

import 'package:flutter/material.dart';

import '../controller.dart' show Field, Item;

import '../model.dart' show PostalAddress;

import '../view.dart' show Field, Item;

class Contact<E> {
  Contact();

  Contact.fromMap(Map m) {
    id = m["id"];
    displayName = m["displayName"];
    givenName = m["givenName"];
    middleName = m["middleName"];
    familyName = m["familyName"];
    prefix = m["prefix"];
    suffix = m["suffix"];
    company = m["company"];
    jobTitle = m["jobTitle"];
    emails = (m["emails"] as Iterable)?.map((m) => Item.fromMap(m));
    phones = (m["phones"] as Iterable)?.map((m) => Item.fromMap(m));
    postalAddresses = (m["postalAddresses"] as Iterable)
        ?.map((m) => PostalAddress.fromMap(m));
  }

  String _id,
      _prefix,
      _suffix,
      _company,
      _jobTitle,
      _displayName,
      _givenName,
      _middleName,
      _familyName,
      _phone,
      _email,
      _street,
      _city,
      _region,
      _postcode,
      _country;

  List<Item> emails, phones;
  //  set email(String email) => [Item(label: "work", value: email)];
  List<PostalAddress> _postalAddresses;

  Map get toMap {
    var emailList = [];
    var phoneList = [];

    if (emails == null) {
      emails = [];
      if (_email != null && _email.isNotEmpty) {
        emails.add(Item(label: "home", value: _email));
      }
    }
    for (Item email in emails ?? []) {
      emailList.add(email.toMap);
    }
    if (phones == null) {
      if (_phone != null && _phone.isNotEmpty) {
        phones = [];
        phones.add(Item(label: "home", value: _phone));
      }
    }
    for (Item phone in phones ?? []) {
      phoneList.add(phone.toMap);
    }
    var addressList = [];
    for (PostalAddress address in _postalAddresses ?? []) {
      addressList.add(address.toMap);
    }
    return {
      "id": _id,
      "displayName": _displayName,
      "givenName": _givenName,
      "middleName": _middleName,
      "familyName": _familyName,
      "prefix": _prefix,
      "suffix": _suffix,
      "company": _company,
      "jobTitle": _jobTitle,
      "emails": emailList,
      "phones": phoneList,
      "postalAddresses": addressList,
    };
  }

  String get id => _id;
  set id(String v) {
    if (v == null) v = "";
    _id = v;
  }

  String get displayName => _displayName;
  set displayName(String v) {
    if (v == null) v = "";
    _displayName = v;
  }

  String get givenName => _givenName;
  set givenName(String v) {
    if (v == null) v = "";
    _givenName = v;
    _nameDisplayed();
  }

  String get middleName => _middleName;
  set middleName(String v) {
    if (v == null) v = "";
    _middleName = v;
  }

  String get familyName => _familyName;
  set familyName(String v) {
    if (v == null) v = "";
    _familyName = v;
    _nameDisplayed();
  }

  void _nameDisplayed() {
    _displayName = givenName ?? " " + ' ' + familyName ?? " ";
  }

  String get prefix => _prefix;
  set prefix(String v) {
    if (v == null) v = "";
    _prefix = v;
  }

  String get suffix => _suffix;
  set suffix(String v) {
    if (v == null) v = "";
    _suffix = v;
  }

  String get company => _company;
  set company(String v) {
    if (v == null) v = "";
    _company = v;
  }

  String get jobTitle => _jobTitle;
  set jobTitle(String v) {
    if (v == null) v = "";
    _jobTitle = v;
  }

  String get phone => _phone;
  set phone(String v) {
    if (v == null) v = "";
    _phone = v;
  }

  String get email => _email;
  set email(String v) {
    if (v == null) v = "";
    _email = v;
  }

  List<PostalAddress> get postalAddresses => _postalAddresses;
  set postalAddresses(List<PostalAddress> address) {
    if (address == null) return;
    _postalAddresses = address;
  }

  String get street => _street;
  set street(String v) {
    if (v == null) v = "";
    _street = v;
  }

  String get city => _city;
  set city(String v) {
    if (v == null) v = "";
    _city = v;
  }

  String get region => _region;
  set region(String v) {
    if (v == null) v = "";
    _region = v;
  }

  String get postcode => _postcode;
  set postcode(String v) {
    if (v == null) v = "";
    _postcode = v;
  }

  String get country => _country;
  set country(String v) {
    if (v == null) v = "";
    _country = v;
  }
}

class Id extends Field {
  Id([Contact contact])
      : super(object: contact, label: 'Identifier', value: contact?.id);

  void onSaved(v) => object?.id = value = v;
}

class DisplayName extends Field {
  DisplayName([Contact contact])
      : super(
          object: contact,
          label: 'Display Name',
          value: contact?.displayName,
        );

  void onSaved(v) => object?.displayName = value = v;

  @override
  CircleAvatar get circleAvatar =>
      CircleAvatar(child: Text(value.length > 1 ? value?.substring(0, 2) : ""));
}

class GivenName extends Field {
  GivenName([Contact contact])
      : super(object: contact, label: 'First Name', value: contact?.givenName);

  void onSaved(v) => object?.givenName = value = v;
}

class MiddleName extends Field {
  MiddleName([Contact contact])
      : super(
            object: contact, label: 'Middle Name', value: contact?.middleName);

  void onSaved(v) => object?.middleName = value = v;
}

class FamilyName extends Field {
  FamilyName([Contact contact])
      : super(object: contact, label: 'Last Name', value: contact?.familyName);

  void onSaved(v) => object?.familyName = value = v;
}

class Prefix extends Field {
  Prefix([Contact contact])
      : super(object: contact, label: 'Prefix', value: contact?.prefix);

  void onSaved(v) => object?.prefix = value = v;
}

class Suffix extends Field {
  Suffix([Contact contact])
      : super(object: contact, label: 'Suffix', value: contact?.suffix);

  void onSaved(v) => object?.suffix = value = v;
}

class Company extends Field {
  Company([Contact contact])
      : super(object: contact, label: 'Company', value: contact?.company);

  void onSaved(v) => object?.company = value = v;
}

class JobTitle extends Field {
  JobTitle([Contact contact])
      : super(object: contact, label: 'Job', value: contact?.jobTitle);

  void onSaved(v) => object?.jobTitle = value = v;
}

class Phone extends Field {
  Phone([Contact contact])
      : super(object: contact, label: 'Phone', value: contact?.phones);

  Phone.single([Contact contact])
      : super(object: contact, label: 'Phone', value: contact?.phone);

  void onSaved(v) {
    if (v == null) return;
    if (v is List<Item>) {
      object?.phones = v;
      return;
    }
    if (v is String) {
      object?.phone = v;
      return;
    }
  }

  @override
  TextFormField get textFormField => TextFormField(
      decoration: InputDecoration(labelText: label),
      onSaved: (v) => onSaved(v),
      keyboardType: TextInputType.phone);
}

class Email extends Field {
  Email([Contact contact])
      : super(object: contact, label: 'E-mail', value: contact?.emails);

  Email.single([Contact contact])
      : super(object: contact, label: 'E-mail', value: contact?.email);

  void onSaved(v) {
    if (v == null) return;
    if (v is List<Item>) {
      object?.emails = v;
      return;
    }
    if (v is String) {
      object?.email = v;
      return;
    }
  }

  @override
  TextFormField get textFormField => TextFormField(
      decoration: InputDecoration(labelText: label),
      onSaved: (v) => onSaved(v),
      keyboardType: TextInputType.emailAddress);
}

class Street extends Field {
  Street([Contact contact])
      : super(object: contact, label: 'Street', value: contact?.company);

  void onSaved(v) => object?.street = value = v;
}

class City extends Field {
  City([Contact contact])
      : super(object: contact, label: 'City', value: contact?.company);

  void onSaved(v) => object?.city = value = v;
}

class Region extends Field {
  Region([Contact contact])
      : super(object: contact, label: 'Region', value: contact?.company);

  void onSaved(v) => object?.region = value = v;
}

class Postcode extends Field {
  Postcode([Contact contact])
      : super(object: contact, label: 'Postal code', value: contact?.company);

  void onSaved(v) => object?.postcode = value = v;
}

class Country extends Field {
  Country([Contact contact])
      : super(object: contact, label: 'Country', value: contact?.company);

  void onSaved(v) => object?.country = value = v;
}
