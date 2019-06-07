// TODO: Put public facing types in this file.
import 'package:meta/meta.dart';

typedef void ObserverCallback(dynamic options);

class FlutterNotificationCenter {
  Map<String, Map<dynamic, ObserverCallback>> _channelObservers = {};

  void registerChannel({@required String channel}) {
    if (_channelObservers[channel] == null) {
      _channelObservers[channel] = {};
    }
  }

  void unregisterChannel({@required String channel}) {
    assert(
      _channelObservers[channel] != null,
      'Channel: $channel does not exist',
    );

    _channelObservers.remove(channel);
  }

  void subscribe({
    @required String channel,
    @required dynamic observer,
    @required ObserverCallback onNotification,
  }) {
    if (_channelObservers[channel] == null) {
      _channelObservers[channel] = {};
    }

    assert(
      _channelObservers[channel][observer] == null,
      'Observer is already subscribed to the channel $channel',
    );
  }

  void unsubscribe({String channel, @required observer}) {
    if (channel == null) {
      for (final Map<dynamic, ObserverCallback> observers
          in _channelObservers.values) {
        observers.remove(observer);
      }
    } else {
      assert(
        _channelObservers[channel] != null,
        'Channel: $channel does not exist',
      );

      _channelObservers[channel].remove(observer);
    }
  }

  void post({@required String channel, dynamic options}) {
    assert(
      _channelObservers[channel] != null,
      'Channel: $channel does not exist',
    );

    _channelObservers[channel].values.forEach(
          (callback) => callback(options),
        );
  }
}
