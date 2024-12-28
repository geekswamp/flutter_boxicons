import 'dart:io';

class ExtractedBoxicon {
  final String name;
  final String code;

  const ExtractedBoxicon({
    required this.name,
    required this.code,
  });
}

Future<void> generateIconsFile(String css) async {
  final regularIcons = extractIcons('bx', css);
  final solidIcons = extractIcons('bxs', css);
  final logoIcons = extractIcons('bxl', css);

  final iconsFileContents = generateIconsFileContents(
    solidIcons,
    regularIcons,
    logoIcons,
  );
  final file = File("lib/flutter_boxicons.dart");
  await file.writeAsString(iconsFileContents);

  final definesFileContents = generateDefinesFileContents(
    solidIcons,
    regularIcons,
    logoIcons,
  );
  final definesFile = File("app/lib/defines.dart");
  await definesFile.writeAsString(definesFileContents);
}

List<ExtractedBoxicon> extractIcons(String prefix, String css) {
/*
  Examples of icon data:

  .bx-flickr-square:before {
    content: "\e936";
  }
  .bx-flutter:before {
    content: "\e937";
  }
  .bx-foursquare:before {
    content: "\e938";
  }
*/

  final icons = RegExp(r'\.(' +
          prefix +
          r'-[a-z0-9-]+):before\s*{\s*content:\s*"\\([a-z0-9]+)";\s*}')
      .allMatches(css)
      .map((match) => extractIcon(match))
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  return icons;
}

ExtractedBoxicon extractIcon(RegExpMatch match) {
  final group1 = match.group(1) ?? "";
  final group2 = match.group(2) ?? "";

  final iconName = group1.replaceAll("-", "_");
  final iconCode = group2;
  // final iconCodeInt = int.tryParse(group2, radix: 16) ?? 0;
  // final adjustedCode = (iconCodeInt + 206).toRadixString(16);
  return ExtractedBoxicon(
    name: iconName,
    code: iconCode,
    // code: adjustedCode,
  );
}

String generateIconsFileContents(
  List<ExtractedBoxicon> solidIcons,
  List<ExtractedBoxicon> regularIcons,
  List<ExtractedBoxicon> logoIcons,
) {
  String generateIconsCode(List<ExtractedBoxicon> icons) {
    return icons
        .map((icon) => """
  static const IconData ${icon.name} =
      IconData(0x${icon.code}, fontFamily: _fontFam, fontPackage: _fontPackage);""")
        .join("\n");
  }

  return """
// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

/// Example to use:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_boxicons/flutter_boxicons.dart';
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return IconButton(
///       // Use Boxicons class
///       icon: Icon(Boxicons.bx_message),
///       onPressed: () {
///         print('Congratulations');
///       }
///     );
///   }
/// }
/// ```
///
/// See also:
/// * [Boxicons]
/// * [https://boxicons.com/](https://boxicons.com/)
class Boxicons {
  Boxicons._();

  static const _fontFam = 'Boxicons';
  static const _fontPackage = 'flutter_boxicons';
  
  ${generateIconsCode(solidIcons)}
  ${generateIconsCode(regularIcons)}
  ${generateIconsCode(logoIcons)}
  }
  """;
}

String generateDefinesFileContents(
  List<ExtractedBoxicon> solidIcons,
  List<ExtractedBoxicon> regularIcons,
  List<ExtractedBoxicon> logoIcons,
) {
  String generateIconList(List<ExtractedBoxicon> icons) {
    return icons.map((icon) {
      return '''
  Boxicon(name: "${icon.name}", icon: Boxicons.${icon.name}),''';
    }).join('\n');
  }

  return """
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class Boxicon {
  final String name;
  final IconData icon;

  const Boxicon({
    required this.name,
    required this.icon,
  });
}

const solidIcons = [
${generateIconList(solidIcons)}
];

const regularIcons = [
${generateIconList(regularIcons)}
];

const logoIcons = [
${generateIconList(logoIcons)}
];
  """;
}
