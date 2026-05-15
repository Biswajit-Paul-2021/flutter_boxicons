# Flutter Boxicons

[Boxicons](https://boxicons.com) customization for Flutter. You can use 2K+ more Boxicons.

## Installation

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
flutter_boxicons:
  git:
    main: https://github.com/Biswajit-Paul-2021/flutter_boxicons.git
    ref: master
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

Boxicons version: 3.0.8

Thank you very much [Boxicons](https://boxicons.com)

## License

MIT
