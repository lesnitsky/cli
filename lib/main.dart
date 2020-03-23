import 'dart:math';

import 'package:cli/cli.dart';
import 'package:cli/command.dart';

class RandomIntCommand extends Command {
  Random random;

  RandomIntCommand() : super('int', 'Generates random integer in 0..100 range');

  @override
  Future<void> exec(List<String> args) async {
    random ??= Random();
    print(random.nextInt(100));
  }
}

void main(List<String> args) async {
  final cli = new Cli();

  cli.add(RandomIntCommand());
  cli.exec(args);
}
