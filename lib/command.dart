import 'cli.dart';

abstract class Command<T extends Cli> {
  T cli;
  String name;
  String description;

  Command(this.name, this.description);

  Future<void> exec(List<String> args);
}
