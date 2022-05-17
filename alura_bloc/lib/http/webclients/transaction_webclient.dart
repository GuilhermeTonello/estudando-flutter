import 'dart:convert';
import 'package:alura_bloc/http/http_exception.dart';
import 'package:alura_bloc/http/web_client.dart';
import 'package:alura_bloc/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {

  Future<List<Transaction>> findAllTransactions() async {
    final Response response =
        await client.get(uri);

    List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
      .map((json) => Transaction.fromJson(json))
      .toList();
  }

  Future<Transaction> saveTransaction(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    //await Future.delayed(const Duration(seconds: 2));

    final Response response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    _verifyResponseStatusCode(response.statusCode);

    return Transaction.fromJson(jsonDecode(response.body));
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error when submitting transaction.',
    401: 'Authentication failed.',
    409: 'Transaction already exists.',
  };

  void _verifyResponseStatusCode(int statusCode) {
    bool isErrorStatusCode = statusCode >= 400 && statusCode <= 599;
    if (isErrorStatusCode) {
      throw HttpException(_statusCodeResponses[statusCode] ?? 'HttpException - Status code: $statusCode');
    }
  }

}
