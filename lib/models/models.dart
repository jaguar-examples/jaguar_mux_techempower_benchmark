library mux_benchmark.models;

class Fortune {
  int id;

  String message;

  Map toMap() => {
    'id': id,
    'message': message,
  };

  void fromMap(Map map) {
    {
      dynamic id = map['id'];
      if(id is int) {
        this.id = id;
      }
    }

    {
      dynamic message = map['message'];
      if(message is String) {
        this.message = message;
      }
    }
  }
}

class World {
  int id;

  int randomnumber;

  Map toMap() => {
    'id': id,
    'randomnumber': randomnumber,
  };

  void fromMap(Map map) {
    {
      dynamic id = map['id'];
      if(id is int) {
        this.id = id;
      }
    }

    {
      dynamic randomnumber = map['randomnumber'];
      if(randomnumber is int) {
        this.randomnumber = randomnumber;
      }
    }
  }
}
