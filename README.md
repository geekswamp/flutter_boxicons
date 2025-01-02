# Flutter Boxicons

![build](https://github.com/arifai/flutter_boxicons/workflows/build/badge.svg) ![Pub Version](https://img.shields.io/pub/v/flutter_boxicons)

[Boxicons](https://boxicons.com) customization for Flutter. You can use 2K+ more Boxicons.

## Installation

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
flutter_boxicons: <latest_version>
```

## Usage

You can use it very easily. For example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        // Use Boxicons class
        icon: Icon(Boxicons.bx_message_rounded_dots),
        onPressed: () {
            print('Congratulations');
        }
    );
  }
}
```

## Info

Boxicons version: 2.0.7

Thank you very much [Boxicons](https://boxicons.com)

## License

MIT
