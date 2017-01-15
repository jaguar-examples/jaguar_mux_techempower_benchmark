library mux_benchmark.api;

import 'dart:async' show Future;
import "package:jaguar/jaguar.dart";
import "package:jaguar/interceptors.dart";
import "package:jaguar_mux/jaguar_mux.dart" as mux;
import 'package:jaguar_mustache/jaguar_mustache.dart';
import 'package:jaguar_query_postgresql/jaguar_query_postgresql.dart';
import 'package:jaguar_postgresql/jaguar_postgresql.dart';
import 'package:postgresql/postgresql.dart' as pg;

import 'package:jaguar_mux_techempower_benchmark/beans/beans.dart';
import 'package:jaguar_mux_techempower_benchmark/models/models.dart';

import 'package:jaguar_mux_techempower_benchmark/common/common.dart';

const String kFortuneTemplate = """
<!DOCTYPE html>
<html>
  <head>
    <title>Fortunes</title>
  </head>
  <body>
    <table>
      <tr>
        <th>id</th>
        <th>message</th>
      </tr>
      {{#fortunes}}
      <tr>
        <td>{{id}}</td>
        <td>{{message}}</td>
      </tr>
      {{/fortunes}}
    </table>
  </body>
</html>
""";

int clampNumQueries(int queries) => queries.clamp(1, 500);

void groupRaw(mux.Group group) {
  group.get('/plaintext', () => 'Hello, World!');

  group
      .get('/json', () => {'message': 'Hello, World!'})
      .wrap(const WrapEncodeMapToJson());

  group.get('/db', (@Input(PostgresDb) pg.Connection db) async {
    final adapter = new PgAdapter.FromConnection(db);
    final WorldBean bean = new WorldBean(adapter);
    return await bean.getById(kRandom.nextInt(kWorldTableSize) + 1);
  }).wrap(new WrapPostgresDb(kPgUrl));

  group.get('/dbs', (@Input(PostgresDb) pg.Connection db,
      {int queries: 1}) async {
    queries = clampNumQueries(queries);
    final adapter = new PgAdapter.FromConnection(db);
    final WorldBean bean = new WorldBean(adapter);
    return await bean.getAll(queries);
  }).wrap(new WrapPostgresDb(kPgUrl));

  group
      .get('/fortune', (@Input(PostgresDb) pg.Connection db) async {
        final adapter = new PgAdapter.FromConnection(db);
        final FortuneBean bean = new FortuneBean(adapter);
        final List<Fortune> fortunes = await bean.getAll();
        return {
          'fortunes':
              fortunes.map((Fortune fortune) => fortune.toMap()).toList(),
        };
      })
      .wrap(new WrapPostgresDb(kPgUrl))
      .wrap(new WrapMustacheStrRender(kFortuneTemplate));

  group.get('/update', (@Input(PostgresDb) pg.Connection db,
      {int queries: 1}) async {
    queries = clampNumQueries(queries);
    final adapter = new PgAdapter.FromConnection(db);
    final WorldBean bean = new WorldBean(adapter);
    final List<World> ret = [];

    for (int count = 0; count < queries; count++) {
      World w = await bean.getById(kRandom.nextInt(kWorldTableSize)+1);
      w.randomnumber = kRandom.nextInt(kWorldTableSize) + 1;
      await bean.updateById(w);
      ret.add(w);
    }

    return ret;
  }).wrap(new WrapPostgresDb(kPgUrl));
}

class Args {
  Args();

  String hostname;

  int port;

  int dbConnections;
}

Future<Null> startServer(Args args) async {
  final builder = new mux.MuxBuilder();

  groupRaw(builder.group(pathPrefix: '/raw'));

  mux.Mux muxer = builder.build();

  Configuration configuration = new Configuration();
  configuration.addApi(muxer);

  await serve(configuration);
}
