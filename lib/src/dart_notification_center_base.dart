import 'package:meta/meta.dart';

/// The type of callback that is called when a notification is
/// posted to a channel
typedef void ObserverCallback(dynamic options);

/// An observer pattern oriented tool to facilitate cross application
/// communication. When an observer is subscribed to an channel, its callback
/// is notified with available options when a notification is posted.
class DartNotificationCenter {
  /// The map of channels to subscribed observers.
  Map<String, Map<dynamic, ObserverCallback>> _channelObservers = {};

  /// The singleton instance for the Notification Center.
  static DartNotificationCenter _sharedCenter = DartNotificationCenter._();

  DartNotificationCenter._();

  ///
  /// Create a notification channel for posting and subscribing.
  ///
  /// This is particularly useful for when a [channel] intends on posting
  /// but is unsure if there are any observers already subscribed.
  ///
  static void registerChannel({required String channel}) {
    if (_sharedCenter._channelObservers[channel] == null) {
      _sharedCenter._channelObservers[channel] = {};
    }
  }

  ///
  /// Destroy a notification [channel] and remove any observers that subscribed.
  ///
  /// This is particularly useful for when a poster knows when it is permanently
  /// done communicating with its subscribers on a specific channel.
  ///
  /// Throws if the [channel] does not exist.
  ///
  static void unregisterChannel({required String channel}) {
    assert(
      _sharedCenter._channelObservers[channel] != null,
      'Channel: $channel does not exist',
    );

    _sharedCenter._channelObservers.remove(channel);
  }

  ///
  /// Subscribe a callback to a specific notification channel.
  ///
  /// When an [observer] subscribes to a [channel], its [onNotification] callback will be
  /// called with options when a poster posts to a [channel]. This is the core functionality of
  /// this library.
  ///
  /// Throws if the [observer] is already subscribed to the [channel].
  ///
  static void subscribe({
    required String channel,
    required dynamic observer,
    required ObserverCallback onNotification,
  }) {
    if (_sharedCenter._channelObservers[channel] == null) {
      _sharedCenter._channelObservers[channel] = {};
    }

    assert(
      _sharedCenter._channelObservers[channel]![observer] == null,
      'Observer is already subscribed to the channel $channel',
    );

    _sharedCenter._channelObservers[channel]![observer] = onNotification;
  }

  ///
  /// Unsubscribe the [observer] from listening on a notification [channel].
  ///
  /// When the [observer] unsubscribes, its onNotification callback will not be
  /// called when a poster posts. This must be called when an object is to be disposed of
  /// or else a retain cycle will occur.
  ///
  /// Throws if the [observer] is not subscribed to the [channel].
  ///
  static void unsubscribe({String? channel, required observer}) {
    if (channel == null) {
      for (final Map<dynamic, ObserverCallback> observers
          in _sharedCenter._channelObservers.values) {
        observers.remove(observer);
      }
    } else {
      if (_sharedCenter._channelObservers[channel] != null) {
        assert(
          _sharedCenter._channelObservers[channel]![observer] != null,
          'Observer is not subscribed to $channel',
        );

        _sharedCenter._channelObservers[channel]!.remove(observer);
      }
    }
  }

  ///
  /// Post a notification to the [channel] with optional [options].
  ///
  /// When a post is sent to a channel, all observers that are subscribed will
  /// get notified via their callbacks. If options are supplied, they will be sent
  /// to the callback.
  ///
  static void post({required String channel, dynamic options}) {
    if (_sharedCenter._channelObservers[channel] != null) {
      _sharedCenter._channelObservers[channel]!.values.forEach(
        (callback) => Future(() => callback(options)),
      );
    }
  }
}
