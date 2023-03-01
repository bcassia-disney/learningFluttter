class Player {
  String _name;
  int _points = 0;

  get total => _points;
  get name => _name;

  Player({String name = "Unknown"}) : _name = name;

  void updatePontuation() {
    _points += 1;
  }
}
