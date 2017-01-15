library jaguar_mux.example.simple.client;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

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

main() async {
  await execJson();
  await execPlainText();
  await execQuery();
}
