import 'package:alura_bloc/models/contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction(this.id, this.value, this.contact) : assert(value > 0);

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        contact = Contact.fromJson(json['contact']);
      
  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'value': value,
      'contact': contact.toJson(),
    };

  @override
  String toString() =>
      'Transaction: (value: $value, to: ${contact.name}/${contact.accountNumber})';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          contact == other.contact;

  @override
  int get hashCode => value.hashCode ^ contact.hashCode;
}
