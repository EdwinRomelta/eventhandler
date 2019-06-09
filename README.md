# EventHandler for dart
EventHandler Singleton for Dart

## Examples

### Implement custom event

```dart
    class CustomEvent extends EventBase {}
```

### Create a method that receives the custom event type
```dart
    void _onCustomEventCallback(CustomEvent event) {
        print("CustomEvent received");
    }
```

### Subscribe to the event
```dart
  @override
  void initState() {
    EventHandler()
        .subscribe(_onCustomEventCallback);
    super.initState();
  }
```

### Send event
```dart
    RaisedButton(
        onPressed: () =>
            EventHandler().send(CustomEvent())              
    )
```            
            
### Eemember to subscribe to the event
```dart
    @override
    void dispose() {
        EventHandler()
            .unsubscribe(_decreaseCounter);
        super.dispose();
    }
```   

## License
This library is licensed under MIT.