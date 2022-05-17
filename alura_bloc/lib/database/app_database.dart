import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:alura_bloc/database/daos/contact_dao.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'alura_bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDao.tableSql);
  }, version: 1);
}

/*
Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'alura_bytebank_persistencia.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(' CREATE TABLE $_contactsTable ( '
          ' id INTEGER PRIMARY KEY, '
          ' name TEXT, '
          ' account_number INTEGER) ');
    }, version: 1);
  });
}
*/

/*
Future<int> saveContact(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = {
      'name': contact.name,
      'account_number': contact.accountNumber
    };

    return db.insert(_contactsTable, contactMap);
  });
}
*/

/*
Future<List<Contact>> findAllContacts() {
  return createDatabase().then((db) {
    return db.query(_contactsTable).then((maps) {
      final List<Contact> contacts = [];

      for (Map<String, dynamic> map in maps) {
        final Contact contact =
            Contact(map['id'], map['name'], map['account_number']);

        contacts.add(contact);
      }

      return contacts;
    });
  });
}
*/
