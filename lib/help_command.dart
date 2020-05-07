import 'dart:io';

import 'cli.dart';
import 'command.dart';

String padLeftMultiline(String string, int leftPadding, int width) {
  final availableSpace = width - leftPadding;
  final first = string.substring(0, availableSpace.clamp(0, string.length));

  List<String> chunks = [];
  int end = availableSpace;

  while (end + availableSpace < string.length) {
    chunks.add(string.substring(end, end + availableSpace));
    end += availableSpace;
  }

  if (end < string.length) {
    chunks.add(
      string.substring(
        end,
        (end + availableSpace).clamp(0, string.length),
      ),
    );
  }

  chunks = chunks.map((c) => '${' ' * leftPadding}$c').toList();

  return [first, ...chunks].join('\n');
}

class HelpCommand extends Command<Cli> {
  HelpCommand() : super('help', 'Prints help');

  @override
  Future<void> exec(List<String> args) async {
    final commands = this.cli.commands.values.toList();

    final sorted = commands.sublist(0)
      ..sort((a, b) => b.name.length - a.name.length);
    final maxLength = sorted.first.name.length + 1;

    stdout.writeln('Available commands:');
    stdout.write(commands
        .map((c) =>
            '  ${c.name}${' ' * (maxLength - c.name.length)} ${padLeftMultiline(c.description, maxLength + 3, stdout.terminalColumns)}')
        .join('\n'));

    stdout.writeln();
  }
}
