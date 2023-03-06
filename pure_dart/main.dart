import './game.dart';
import 'dart:io';
import 'dart:math';

main() {
  var game = Game();
  RandomGenerator randomGen = RandomMock();

  int _numberOfFrame = 1;

  for (_numberOfFrame; _numberOfFrame <= 26; _numberOfFrame++) {
    while (game.initalRange == -1 || game.initalRange > 10) {
      print("Enter the inital value of range $_numberOfFrame");

      game.initalRange = int.parse(stdin.readLineSync()!);
    }

    while (game.finalRange == -1 || game.finalRange > 10) {
      print("Enter the final value of range $_numberOfFrame");

      game.finalRange = int.parse(stdin.readLineSync()!);
    }

    var playerSortedValue =
        game.initalRange + Random().nextInt(game.finalRange - game.initalRange);
    var systemSortedValue =
        game.initalRange + Random().nextInt(game.finalRange - game.initalRange);
    print(
        "The range of frame #$_numberOfFrame will be between ${game.initalRange} and ${game.finalRange}.\nYour sorted value was: $playerSortedValue\nSystem's sorted value was: $systemSortedValue");

    game.play(playerSortedValue, systemSortedValue);

    game.initalRange = -1;
    game.finalRange = -1;
  }

  var results = game.finish();

  if (results[0].total > results[1].total) {
    print("${results[0].name} has won!");
  } else if (results[0].total < results[1].total) {
    print("${results[1].name} has won!");
  } else {
    print("Empate");
  }
}

class RandomGenerator {
  int randomInt({int? seed = null, required int max}) {
    return Random(seed).nextInt(max);
  }
}

class RandomMock implements RandomGenerator {
  int mockInt = 0;

  @override
  int randomInt({int? seed = null, required int max}) {
    return mockInt;
  }
}
