import 'dart:io';

import 'command.dart';

class Cli {
  Map<String, Command> commands = {};

  constructor() {
    this.commands = new Map();
  }

  void add(Command command) {
    command.cli = this;

    if (this.commands.containsKey(command.name)) {
      throw new Exception('Command "${command.name}" already exists');
    }

    this.commands[command.name] = command;
  }

  Future<void> exec(List<String> args) async {
    String name;
    List<String> arguments;

    if (args.length == 0) {
      name = 'main';

      if (!this.commands.containsKey(name)) {
        exit(0);
      }
    } else {
      arguments = args.sublist(0);
      name = arguments.removeAt(0);
    }

    if (this.commands.containsKey(name)) {
      await this.commands[name].exec(arguments);
    } else if (this.commands.containsKey('main')) {
      await this.commands['main'].exec(args);
    } else {
      throw new Exception('Unknown command "${name}"');
    }
  }
}
