
import 'event_base.dart';

class EventHandler {
  static EventHandler _singleton;

  EventHandler._internal();

  factory EventHandler() {
    if (_singleton == null) _singleton = EventHandler._internal();
    return _singleton;
  }

  Map<Type, List<Function>> controllers = {};

  EventHandler subscribe<T extends EventBase>(Function(T) callback) {
    if (T == Null) {
      print("Invalid subscribe event type: $T");
      return this;
    }

    if (!controllers.containsKey(T)) {
      controllers[T] = List<Function(T)>();
    }

    if (controllers[T].contains(callback)) {
      print("Already subscribed to the event: $T");
      return this;
    }

    controllers[T].add(callback);

    return this;
  }

  EventHandler send<T extends EventBase>(T data) {
    controllers[T]?.forEach((funcCallback) => funcCallback(data));
    return this;
  }

  EventHandler unsubscribe<T extends EventBase>(Function(T) callback) {
    if (controllers.containsKey(T)) controllers[T].remove(callback);
    return this;
  }
}
