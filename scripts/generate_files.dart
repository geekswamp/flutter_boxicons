import 'src/css_file.dart';
import 'src/font_file.dart';
import 'src/icons_file.dart';

/*
* Script used to download the latest icons from https://github.com/atisawd/boxicons
*
* Usage: dart scripts/generate_files.dart
*/
Future<void> main() async {
  final fontBytes = await downloadFontFile();
  await storeFontFile(fontBytes);

  final css = await downloadCssFile();
  await generateIconsFile(css);
}
