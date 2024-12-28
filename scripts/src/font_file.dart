import 'dart:io';

import 'package:http/http.dart';

Future<List<int>> downloadFontFile() async {
  const uri =
      "https://github.com/atisawd/boxicons/blob/master/fonts/boxicons.ttf?raw=true";
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
  final file = File("fonts/Boxicons.ttf");
  await file.writeAsBytes(fontBytes);
}
