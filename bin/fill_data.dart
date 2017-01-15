library bin.fill_data;

import "dart:async" show Future;
import 'package:jaguar_query_postgresql/jaguar_query_postgresql.dart';

import 'package:jaguar_mux_techempower_benchmark/beans/beans.dart';
import 'package:jaguar_mux_techempower_benchmark/models/models.dart';

import 'package:jaguar_mux_techempower_benchmark/common/common.dart';

Future<Null> fillWorld(PgAdapter adapter) async {
  final WorldBean bean = new WorldBean(adapter);

  // Clear old data
  await bean.deleteAll();

  for(int idx = 0; idx < kWorldTableSize; idx++) {
    final World w = new World();
    w.id = idx+1;
    w.randomnumber = kRandom.nextInt(kWorldTableSize) + 1;
    await bean.create(w);
  }
}

Future<Null> fillFortune(PgAdapter adapter) async {
  final FortuneBean bean = new FortuneBean(adapter);

  // Clear old data
  await bean.deleteAll();

  for(int idx = 0; idx < kWorldTableSize; idx++) {
    final Fortune w = new Fortune();
    w.id = idx+1;
    w.message = kFortunes[kRandom.nextInt(kFortunes.length)];
    await bean.create(w);
  }
}

main() async {
  PgAdapter adapter = new PgAdapter(kPgUrl);
  await adapter.connect();

  await fillWorld(adapter);
  await fillFortune(adapter);
}