import 'package:flutter/material.dart';

@immutable
abstract class TransactionFormState {
  const TransactionFormState();
}

@immutable
class ShowTransactionFormState extends TransactionFormState {
  const ShowTransactionFormState();
}

@immutable
class SendingTransactionFormState extends TransactionFormState {
  const SendingTransactionFormState();
}

@immutable
class SentTransactionFormState extends TransactionFormState {
  const SentTransactionFormState();
}

@immutable
class FatalErrorTransactionFormState extends TransactionFormState {
  final String message;
  
  const FatalErrorTransactionFormState(this.message);
}
