import 'package:flutter_notification_center/flutter_notification_center.dart';

main() {
  FlutterNotificationCenter.registerChannel(channel: 'an_event');

  //this is our notification observer object
  int i = 1;

  //This is our channel name
  String CHANNEL_NAME = 'an_event';

  FlutterNotificationCenter.subscribe(
    channel: CHANNEL_NAME,
    observer: i,
    onNotification: (result) => print('received: $result'),
  );

  // Expected: received: null
  FlutterNotificationCenter.post(channel: CHANNEL_NAME);

  // Expected: received: with options!!
  FlutterNotificationCenter.post(
    channel: CHANNEL_NAME,
    options: 'with options!!',
  );

  FlutterNotificationCenter.unsubscribe(observer: i, channel: CHANNEL_NAME);

  FlutterNotificationCenter.unregisterChannel(channel: CHANNEL_NAME);
}
