library mux_benchmark.beans;

import 'dart:async';
import 'package:jaguar_mux_techempower_benchmark/models/models.dart';
import 'package:jaguar_query/jaguar_query.dart';

class FortuneBean {
  Adapter _adapter;

  FortuneBean(this._adapter);

  final IntField id = new IntField('id');

  final StrField message = new StrField('message');

  static const String tableName = 'fortune';

  Future<Null> create(final Fortune f) async {
    final InsertStatement st = new InsertStatement();

    st.into(tableName);
    st.set(id.set(f.id));
    st.set(message.set(f.message));

    await _adapter.insert(st);
  }

  Future<List<Fortune>> getAll() async {
    final FindStatement st = new FindStatement();

    st.from(tableName);

    final List<Map> maps = await (await _adapter.find(st)).toList();

    final List<Fortune> ret = [];

    for (Map map in maps) {
      final Fortune w = new Fortune();
      w.fromMap(map);
      ret.add(w);
    }

    return ret;
  }

  Future<Null> deleteAll() async {
    final DeleteStatement st = new DeleteStatement();
    st.from(tableName);
    await _adapter.delete(st);
  }
}

class WorldBean {
  Adapter _adapter;

  WorldBean(this._adapter);

  final IntField id = new IntField('id');

  final IntField randomnumber = new IntField('randomnumber');

  static const String tableName = 'world';

  Future<Null> create(final World w) async {
    final InsertStatement st = new InsertStatement();

    st.into(tableName);
    st.set(id.set(w.id));
    st.set(randomnumber.set(w.randomnumber));

    await _adapter.insert(st);
  }

  Future<World> getById(final int id) async {
    final FindStatement st = new FindStatement();

    st.from(tableName).where(this.id.eq(id));

    final Map map = await _adapter.findOne(st);

    final World ret = new World();
    ret.fromMap(map);

    return ret;
  }

  Future<List<World>> getAll(final int limit) async {
    final FindStatement st = new FindStatement();

    st.from(tableName).limit(limit);

    final List<Map> maps = await (await _adapter.find(st)).toList();

    final List<World> ret = [];

    for (Map map in maps) {
      final World w = new World();
      w.fromMap(map);
      ret.add(w);
    }

    return ret;
  }

  Future<Null> updateById(final World world) async {
    final UpdateStatement st = new UpdateStatement();

    st.into(tableName).set(randomnumber.set(world.randomnumber));

    st.where(id.eq(world.id));

    await _adapter.update(st);
  }

  Future<Null> deleteAll() async {
    final DeleteStatement st = new DeleteStatement();
    st.from(tableName);
    await _adapter.delete(st);
  }
}
