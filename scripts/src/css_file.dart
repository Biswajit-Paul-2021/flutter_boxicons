import 'package:http/http.dart';

Future<String> downloadBasicCssFile() async {
  const uri =
      "https://raw.githubusercontent.com/box-icons/boxicons-core/refs/heads/main/fonts/basic/boxicons.css?raw=true";
  final response = await get(Uri.parse(uri));
  if (response.statusCode != 200) {
    print('Failed to download CSS file');
    return "";
  } else {
    return response.body;
  }
}

Future<String> downloadFilledCssFile() async {
  const uri =
      "https://raw.githubusercontent.com/box-icons/boxicons-core/refs/heads/main/fonts/filled/boxicons-filled.css?raw=true";
  final response = await get(Uri.parse(uri));
  if (response.statusCode != 200) {
    print('Failed to download CSS file');
    return "";
  } else {
    return response.body;
  }
}

Future<String> downloadBrandsCssFile() async {
  const uri =
      "https://raw.githubusercontent.com/box-icons/boxicons-core/refs/heads/main/fonts/brands/boxicons-brands.css?raw=true";
  final response = await get(Uri.parse(uri));
  if (response.statusCode != 200) {
    print('Failed to download CSS file');
    return "";
  } else {
    return response.body;
  }
}
