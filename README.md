A lightweight and intuitive observer pattern manager for Dart/Flutter

## License
Published under a BSD-style [license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Installation
To use this plugin, add `flutter_notification_center` as a dependency in your pubspec.yaml file.

Import the package using:
```dart
import 'package:flutter_notification_center/flutter_notification_center.dart';
```


## Usage

A simple example:

```dart
...

FlutterNotificationCenter.subscribe(
  channel: 'examples',
  observer: this,
  onNotification: (options) {
    print('Notified: ${options}');
  },
);

FlutterNotificationCenter.post(channel: 'examples', options: 'Congrats you did it!');

FlutterNotificationCenter.unsubscribe(channel: 'examples', observer: this);

...
```
