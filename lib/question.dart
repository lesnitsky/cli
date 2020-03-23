import 'dart:io';

Future<String> question(String text) async {
  stdout.write('$text: ');
  return stdin.readLineSync();
}
