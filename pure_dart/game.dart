import './player.dart';

class Game {
  int initalRange = -1;
  int finalRange = -1;
  var player = Player();
  var system = Player(name: "System");

  Game();

  play(int playerSortedValue, int systemSortedValue) {
    if (playerSortedValue > systemSortedValue) {
      player.updatePontuation();
    } else {
      system.updatePontuation();
    }
  }

  List<Player> finish() {
    return [this.player, this.system];
  }
}
