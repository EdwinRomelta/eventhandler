import 'event_base.dart';

///Event handler that execute multiple callback function.
///
///It is implemented with a Singleton pattern and is called executing its factory constructor.
class EventHandler {
  static EventHandler _singleton;

  EventHandler._internal();

  factory EventHandler() {
    if (_singleton == null) _singleton = EventHandler._internal();
    return _singleton;
  }

  Map<Type, List<Function>> controllers = {};

  ///Subscribe the function to event
  ///
  ///The function must receive an object that inherits from EventBase.
  ///Whenever an event is sent with an object of that type, the function passed by parameter will be called.
  ///
  ///Returns the instance of the eventhandler for multiple subscriptions.
  EventHandler subscribe<T extends EventBase>(void Function(T) callback) {
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

  ///Send a event
  ///
  ///Send an object that inherits from the Base event and that will call all the subscribers of the data type of the object.
  ///
  ///Returns the instance of the eventhandler to send multiple events
  EventHandler send<T extends EventBase>(T data) {
    controllers[T]?.forEach((funcCallback) => funcCallback(data));
    return this;
  }

  ///Unsubscribe to event
  ///
  ///The function passed by parameter must be the same as that sent in the subscription.
  ///
  ///Returns the instance of the eventhandler for multiple unsubscriptions.
  EventHandler unsubscribe<T extends EventBase>(void Function(T) callback) {
    if (controllers.containsKey(T)) controllers[T].remove(callback);
    return this;
  }
}
