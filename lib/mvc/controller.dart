import 'package:ex_architectures/mvc/model.dart';

/// https://github.com/flutter-devs/Flutter_MVC
class Controller {
  int get counter => Model.counter;

  void incrementCounter() {
    /// The Controller knows how to 'talk to' the Model. It knows the name, but Model does the work.
    Model.incrementCounter();
  }

  void decrementCounter() {
    /// The Controller knows how to 'talk to' the Model. It knows the name, but Model does the work.
    Model.decrementCounter();
  }
}
