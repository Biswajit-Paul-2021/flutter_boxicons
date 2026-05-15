import 'dart:io';

import 'package:flutter/foundation.dart';

class ExtractedBoxicon {
  final String name;
  final String code;
  final String family; // 'Boxicons', 'BoxiconsFilled', or 'BoxiconsBrands'
  const ExtractedBoxicon({
    required this.name,
    required this.code,
    required this.family,
  });
}

Future<void> generateIconsFile(String css, String outputPath) async {
  final regular = <ExtractedBoxicon>[];
  final brands = <ExtractedBoxicon>[];
  final filled = <ExtractedBoxicon>[];

  for (final rule in css.split('}')) {
    final trimmed = rule.trim();
    if (trimmed.isEmpty) continue;

    final brace = trimmed.indexOf('{');
    if (brace == -1) continue;
    final selector = trimmed.substring(0, brace).trim();
    final body = trimmed.substring(brace + 1).trim();

    // Extract content value
    final contentStart = body.indexOf('content:');
    if (contentStart == -1) continue;
    final afterContent = body.substring(contentStart + 8);
    final quoteChar = afterContent.contains('"') ? '"' : "'";
    final startQuote = afterContent.indexOf(quoteChar);
    if (startQuote == -1) continue;
    final endQuote = afterContent.indexOf(quoteChar, startQuote + 1);
    if (endQuote == -1) continue;
    String rawContent = afterContent.substring(startQuote + 1, endQuote);
    if (rawContent.startsWith('\\')) rawContent = rawContent.substring(1);
    final hexCode = rawContent;

    // Determine icon type and family
    if (selector.startsWith('.bx-')) {
      final namePart = selector.substring(4);
      if (namePart.endsWith(':before')) {
        final base =
            namePart.substring(0, namePart.length - 7).replaceAll('-', '_');
        regular.add(ExtractedBoxicon(
          name: 'bx_$base',
          code: hexCode,
          family: 'Boxicons', // regular font family
        ));
      }
    } else if (selector.startsWith('.bxl.bx-')) {
      final namePart = selector.substring(8);
      if (namePart.endsWith(':before')) {
        final base =
            namePart.substring(0, namePart.length - 7).replaceAll('-', '_');
        brands.add(ExtractedBoxicon(
          name: 'bxl_$base',
          code: hexCode,
          family: 'BoxiconsBrands',
        ));
      }
    } else if (selector.startsWith('.bxf.bx-')) {
      final namePart = selector.substring(8);
      if (namePart.endsWith(':before')) {
        final base =
            namePart.substring(0, namePart.length - 7).replaceAll('-', '_');
        filled.add(ExtractedBoxicon(
          name: 'bxf_$base',
          code: hexCode,
          family: 'BoxiconsFilled',
        ));
      }
    }
  }

  regular.sort((a, b) => a.name.compareTo(b.name));
  brands.sort((a, b) => a.name.compareTo(b.name));
  filled.sort((a, b) => a.name.compareTo(b.name));

  final output = _generateDartFile(regular, brands, filled);
  generateDataFile(regular, brands, filled);
  await File(outputPath).writeAsString(output);
  print(
      'Generated $outputPath with ${regular.length} regular, ${brands.length} brand, ${filled.length} filled icons.');
}

String _generateDartFile(
  List<ExtractedBoxicon> regular,
  List<ExtractedBoxicon> brands,
  List<ExtractedBoxicon> filled,
) {
  final buffer = StringBuffer();
  buffer.writeln('// ignore_for_file: constant_identifier_names\n');
  buffer.writeln("import 'package:flutter/widgets.dart';\n");
  buffer.writeln('class Boxicons {');
  buffer.writeln('  Boxicons._();\n');

  void writeIcons(String category, List<ExtractedBoxicon> list) {
    if (list.isEmpty) return;
    buffer.writeln('  // $category');
    for (final icon in list) {
      buffer.writeln(
        '  static const IconData ${icon.name} = IconData(0x${icon.code}, fontFamily: "${icon.family}", fontPackage: "flutter_boxicons");',
      );
    }
    buffer.writeln();
  }

  writeIcons('Regular icons', regular);
  writeIcons('Brand icons', brands);
  writeIcons('Filled icons', filled);

  buffer.writeln('}');
  return buffer.toString();
}

void generateDataFile(
  List<ExtractedBoxicon> regular,
  List<ExtractedBoxicon> brands,
  List<ExtractedBoxicon> filled,
) {
  final buffer = StringBuffer();
  buffer.writeln('// ignore_for_file: constant_identifier_names\n');
  buffer.writeln("import 'package:flutter/widgets.dart';");
  buffer.writeln("import 'package:flutter_boxicons/flutter_boxicons.dart';\n");
  buffer.writeln('class BoxiconItem {');
  buffer.writeln('  final String name;');
  buffer.writeln('  final IconData icon;');
  buffer.writeln('  const BoxiconItem(this.name, this.icon);');
  buffer.writeln('}\n');
  buffer.writeln('const List<BoxiconItem> allBoxicons = [');

  for (final icon in [...regular, ...brands, ...filled]) {
    buffer.writeln('  BoxiconItem("${icon.name}", Boxicons.${icon.name}),');
  }

  buffer.writeln('];');
  File('example/lib/boxicons_data.dart').writeAsStringSync(buffer.toString());
  debugPrint('Generated boxicons_data.dart');
}
