import 'package:reflectable/reflectable.dart';

const reflector = Reflector();

class Reflector extends Reflectable {
  const Reflector()
      : super(invokingCapability);
}