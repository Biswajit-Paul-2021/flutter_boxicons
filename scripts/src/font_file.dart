import 'dart:io';

import 'package:http/http.dart';

Future<List<int>> downloadBasicFontFile() async {
  const uri =
      "https://github.com/box-icons/boxicons-core/blob/main/fonts/basic/boxicons.ttf?raw=true";
  final response = await get(Uri.parse(uri));
  if (response.statusCode != 200) {
    print('Failed to download font file: ${response.statusCode}');
    return [];
  } else {
    return response.bodyBytes;
  }
}

Future<void> storeFontFile(List<int> fontBytes) async {
  if (fontBytes.isEmpty) return;
  final file = File("fonts/basic/boxicons.ttf");
  await file.writeAsBytes(fontBytes);
}

Future<List<int>> downloadFilledFontFile() async {
  const uri =
      "https://github.com/box-icons/boxicons-core/blob/main/fonts/filled/boxicons-filled.ttf?raw=true";
  final response = await get(Uri.parse(uri));
  if (response.statusCode != 200) {
    print('Failed to download font file: ${response.statusCode}');
    return [];
  } else {
    return response.bodyBytes;
  }
}

Future<void> storeFilledFile(List<int> fontBytes) async {
  if (fontBytes.isEmpty) return;
  final file = File("fonts/filled/boxicons-filled.ttf");
  await file.writeAsBytes(fontBytes);
}

Future<List<int>> downloadBrandsFontFile() async {
  const uri =
      "https://github.com/box-icons/boxicons-core/blob/main/fonts/brands/boxicons-brands.ttf?raw=true";
  final response = await get(Uri.parse(uri));
  if (response.statusCode != 200) {
    print('Failed to download font file: ${response.statusCode}');
    return [];
  } else {
    return response.bodyBytes;
  }
}

Future<void> storeBrandsFontFile(List<int> fontBytes) async {
  if (fontBytes.isEmpty) return;
  final file = File("fonts/brands/boxicons-brands.ttf");
  await file.writeAsBytes(fontBytes);
}
