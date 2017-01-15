library jaguar_mux.example.simple.client;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:jaguar_mux_techempower_benchmark/common/common.dart';

const String kHostname = 'localhost';

const int kPort = 8080;

final HttpClient _client = new HttpClient();

Future<Null> printHttpClientResponse(HttpClientResponse resp) async {
  StringBuffer contents = new StringBuffer();
  await for (String data in resp.transform(UTF8.decoder)) {
    contents.write(data);
  }

  print('=========================');
  print("body:");
  print(contents.toString());
  print("statusCode:");
  print(resp.statusCode);
  print("headers:");
  print(resp.headers);
  print("cookies:");
  print(resp.cookies);
  print('=========================');
}

Future<Null> execJson() async {
  HttpClientRequest req = await _client.get(kHostname, kPort, '/raw/json');
  HttpClientResponse resp = await req.close();

  printHttpClientResponse(resp);
}

Future<Null> execPlainText() async {
  HttpClientRequest req = await _client.get(kHostname, kPort, '/raw/plaintext');
  HttpClientResponse resp = await req.close();

  printHttpClientResponse(resp);
}

Future<Null> execQuery() async {
  HttpClientRequest req = await _client.get(kHostname, kPort, '/raw/db');
  HttpClientResponse resp = await req.close();

  printHttpClientResponse(resp);
}

Future<Null> execQueries() async {
  final int queries = kRandom.nextInt(kWorldTableSize) + 1;
  HttpClientRequest req =
      await _client.get(kHostname, kPort, '/raw/dbs?queries=$queries');
  HttpClientResponse resp = await req.close();

  printHttpClientResponse(resp);
}

Future<Null> execUpdate() async {
  final int queries = kRandom.nextInt(kWorldTableSize) + 1;
  HttpClientRequest req =
      await _client.get(kHostname, kPort, '/raw/update?queries=$queries');
  HttpClientResponse resp = await req.close();

  printHttpClientResponse(resp);
}

main() async {
  await execJson();
  await execPlainText();
  await execQuery();
  await execQueries();
  await execUpdate();
}
