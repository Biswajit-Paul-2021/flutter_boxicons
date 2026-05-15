import 'src/css_file.dart';
import 'src/font_file.dart';
import 'src/icons_file.dart';

/// Usage dart scripts/generate_files.dart

Future<void> main() async {
  await Future.wait([
    downloadBasicFontFile().then(
      (value) => storeFontFile(value),
    ),
    downloadBrandsFontFile().then(
      (value) => storeBrandsFontFile(value),
    ),
    downloadFilledFontFile().then(
      (value) => storeFilledFile(value),
    ),
  ]);
  final regularCss = await downloadBasicCssFile();
  final brandsCss = await downloadBrandsCssFile();
  final filledCss = await downloadFilledCssFile();
  final allCss = '$regularCss\n$brandsCss\n$filledCss';
  await generateIconsFile(allCss, 'lib/flutter_boxicons.dart');
}
