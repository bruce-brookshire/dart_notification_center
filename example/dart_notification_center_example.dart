import 'package:dart_notification_center/dart_notification_center.dart';

main() {
  DartNotificationCenter.registerChannel(channel: 'an_event');

  //this is our notification observer object
  int i = 1;

  //This is our channel name
  String CHANNEL_NAME = 'an_event';

  DartNotificationCenter.subscribe(
    channel: CHANNEL_NAME,
    observer: i,
    onNotification: (result) => print('received: $result'),
  );

  // Expected: received: null
  DartNotificationCenter.post(channel: CHANNEL_NAME);

  // Expected: received: with options!!
  DartNotificationCenter.post(
    channel: CHANNEL_NAME,
    options: 'with options!!',
  );

  DartNotificationCenter.unsubscribe(observer: i, channel: CHANNEL_NAME);

  DartNotificationCenter.unregisterChannel(channel: CHANNEL_NAME);
}
