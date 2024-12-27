import 'package:http/http.dart';

Future<String> downloadCssFile() async {
  const uri =
      "https://github.com/atisawd/boxicons/blob/master/css/boxicons.css?raw=true";
  final response = await get(Uri.parse(uri));
  if (response.statusCode != 200) {
    print('Failed to download CSS file');
    return "";
  } else {
    return response.body;
  }
}
