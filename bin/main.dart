// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_mux_techempower_benchmark/jaguar_mux_techempower_benchmark.dart';
import "package:args/args.dart";
import "dart:isolate";

main(List<String> args) {
  var parser = new ArgParser();
  parser.addOption('address', abbr: 'a', defaultsTo: '0.0.0.0');
  parser.addOption('port', abbr: 'p', defaultsTo: '8080');
  parser.addOption('dbconnections', abbr: 'd', defaultsTo: '256');
  parser.addOption('isolates', abbr: 'i', defaultsTo: '1');

  final ArgResults arguments = parser.parse(args);

  final int isolates = int.parse(arguments['isolates']);

  final Args options = new Args();
  options.hostname = arguments['address'];
  options.port = int.parse(arguments['port']);
  options.dbConnections = int.parse(arguments['dbconnections']) ~/ isolates;

  for (int i = 1; i < isolates; i++) {
    Isolate.spawn(startServer, options);
  }

  startServer(options);
}
