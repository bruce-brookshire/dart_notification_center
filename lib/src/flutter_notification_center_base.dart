import 'package:meta/meta.dart';

typedef void ObserverCallback(dynamic options);

class FlutterNotificationCenter {
  Map<String, Map<dynamic, ObserverCallback>> _channelObservers = {};

  static FlutterNotificationCenter _sharedCenter = FlutterNotificationCenter();

  static void registerChannel({@required String channel}) {
    if (_sharedCenter._channelObservers[channel] == null) {
      _sharedCenter._channelObservers[channel] = {};
    }
  }

  static void unregisterChannel({@required String channel}) {
    assert(
      _sharedCenter._channelObservers[channel] != null,
      'Channel: $channel does not exist',
    );

    _sharedCenter._channelObservers.remove(channel);
  }

  static void subscribe({
    @required String channel,
    @required dynamic observer,
    @required ObserverCallback onNotification,
  }) {
    if (_sharedCenter._channelObservers[channel] == null) {
      _sharedCenter._channelObservers[channel] = {};
    }

    assert(
      _sharedCenter._channelObservers[channel][observer] == null,
      'Observer is already subscribed to the channel $channel',
    );
  }

  static void unsubscribe({String channel, @required observer}) {
    if (channel == null) {
      for (final Map<dynamic, ObserverCallback> observers
          in _sharedCenter._channelObservers.values) {
        observers.remove(observer);
      }
    } else {
      assert(
        _sharedCenter._channelObservers[channel] != null,
        'Channel: $channel does not exist',
      );

      _sharedCenter._channelObservers[channel].remove(observer);
    }
  }

  static void post({@required String channel, dynamic options}) {
    assert(
      _sharedCenter._channelObservers[channel] != null,
      'Channel: $channel does not exist',
    );

    _sharedCenter._channelObservers[channel].values.forEach(
      (callback) => callback(options),
    );
  }
}
