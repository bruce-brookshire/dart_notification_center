![Pub](https://img.shields.io/pub/v/dropdown_banner.svg?style=flat-square)

A lightweight and intuitive observer pattern manager for Dart/Flutter in the style of the iOS Notification Center

## Installation
To use this plugin, add `dart_notification_center` as a dependency in your pubspec.yaml file.

Import the package using:
```dart
import 'package:dart_notification_center/dart_notification_center.dart';
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
