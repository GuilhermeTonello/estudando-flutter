// Mocks generated by Mockito 5.1.0 from annotations
// in alura_bytebank/test/flows/save_contact_flow_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:alura_bytebank/database/daos/contact_dao.dart' as _i3;
import 'package:alura_bytebank/http/webclients/transaction_webclient.dart'
    as _i6;
import 'package:alura_bytebank/models/contact.dart' as _i5;
import 'package:alura_bytebank/models/transaction.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTransaction_0 extends _i1.Fake implements _i2.Transaction {}

/// A class which mocks [ContactDao].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactDao extends _i1.Mock implements _i3.ContactDao {
  MockContactDao() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<int> saveContact(_i5.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#saveContact, [contact]),
          returnValue: Future<int>.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<List<_i5.Contact>> findAllContacts() =>
      (super.noSuchMethod(Invocation.method(#findAllContacts, []),
              returnValue: Future<List<_i5.Contact>>.value(<_i5.Contact>[]))
          as _i4.Future<List<_i5.Contact>>);
}

/// A class which mocks [TransactionWebClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransactionWebClient extends _i1.Mock
    implements _i6.TransactionWebClient {
  MockTransactionWebClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Transaction>> findAllTransactions() =>
      (super.noSuchMethod(Invocation.method(#findAllTransactions, []),
              returnValue:
                  Future<List<_i2.Transaction>>.value(<_i2.Transaction>[]))
          as _i4.Future<List<_i2.Transaction>>);
  @override
  _i4.Future<_i2.Transaction> saveTransaction(
          _i2.Transaction? transaction, String? password) =>
      (super.noSuchMethod(
              Invocation.method(#saveTransaction, [transaction, password]),
              returnValue: Future<_i2.Transaction>.value(_FakeTransaction_0()))
          as _i4.Future<_i2.Transaction>);
}
