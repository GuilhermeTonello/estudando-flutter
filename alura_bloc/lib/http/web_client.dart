import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

final Uri uri = Uri(
  scheme: 'http',
  host: 'ipaddress',
  port: 8080,
  path: 'transactions',
);

final Client client = InterceptedClient.build(
  interceptors: [
    //LoggingInterceptor(),
  ],
  requestTimeout: const Duration(seconds: 5),
);
