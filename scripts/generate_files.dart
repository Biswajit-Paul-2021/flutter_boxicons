import 'dart:io';

import 'src/icons_file.dart';

/*
* Script used to download the latest icons from https://github.com/atisawd/boxicons
*
* Usage: dart scripts/generate_files.dart
*/
Future<void> main() async {
  final regularCss =
      await File('scripts/css/basic/boxicons.css').readAsString();
  final brandsCss =
      await File('scripts/css/brands/boxicons-brands.css').readAsString();
  final filledCss =
      await File('scripts/css/filled/boxicons-filled.css').readAsString();
  final allCss = '$regularCss\n$brandsCss\n$filledCss';
  await generateIconsFile(allCss, 'lib/flutter_boxicons.dart');
}
