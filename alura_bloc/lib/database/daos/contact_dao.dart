import 'package:sqflite/sqflite.dart';

import 'package:alura_bloc/database/app_database.dart';
import 'package:alura_bloc/models/contact.dart';

class ContactDao {

  static const String _tableName = 'contacts';

  static const String tableSql = ' CREATE TABLE $_tableName ( '
        ' id INTEGER PRIMARY KEY, '
        ' name TEXT, '
        ' account_number INTEGER) ';

  Future<int> saveContact(Contact contact) async {
    final Database db = await getDatabase();
    return db.insert(_tableName, _toMap(contact));
  }

  Future<List<Contact>> findAllContacts() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    return _toList(results);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    return {
      'name': contact.name,
      'account_number': contact.accountNumber
    };
  }

  List<Contact> _toList(List<Map<String, dynamic>> results) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> result in results) {
      final Contact contact =
          Contact(result['id'], result['name'], result['account_number']);
      contacts.add(contact);
    }
    return contacts;
  }

}
