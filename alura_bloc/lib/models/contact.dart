class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(this.id, this.name, this.accountNumber);

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0, // não possui id no servidor
        name = json['name'],
        accountNumber = json['accountNumber'];
  
  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
    };

  @override
  String toString() => 'Contact: (name: $name, account number: $accountNumber)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          accountNumber == other.accountNumber;

  @override
  int get hashCode => name.hashCode ^ accountNumber.hashCode;
}
