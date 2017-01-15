library mux_benchmark.models;

import 'package:jaguar/src/http/json/json.dart';

class Fortune implements ToJsonable {
  int id;

  String message;

  Map toMap() => {
        'id': id,
        'message': message,
      };

  void fromMap(Map map) {
    {
      dynamic id = map['id'];
      if (id is int) {
        this.id = id;
      }
    }

    {
      dynamic message = map['message'];
      if (message is String) {
        this.message = message;
      }
    }
  }

  Map toJson() => toMap();
}

class World implements ToJsonable {
  int id;

  int randomnumber;

  Map toMap() => {
        'id': id,
        'randomnumber': randomnumber,
      };

  void fromMap(Map map) {
    {
      dynamic id = map['id'];
      if (id is int) {
        this.id = id;
      }
    }

    {
      dynamic randomnumber = map['randomnumber'];
      if (randomnumber is int) {
        this.randomnumber = randomnumber;
      }
    }
  }

  Map toJson() => toMap();
}
