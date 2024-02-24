import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomotimer/main.reflectable.dart';
import 'package:pomotimer/states/main_states.dart';

void main() {

  initializeReflectable();

  group('Testing the main state functions', () {
    test('Testing the main state constructor', () {
      var startTime = DateTime.now();

      var states = MainStates(
          timerRunning: true,
          startTime: startTime,
          customFocusTime: 25,
          customShortBreakTime: 5,
          customLongBreakTime: 20
      );

      expect(() {
        if (states.timerRunning == true && states.startTime == startTime && states.customFocusTime == 25 && states.customShortBreakTime == 5 && states.customLongBreakTime == 20) {
          return true;
        }

        return false;
      }(), true);
    });

    test('Testing the main state toJson function', () {
      var startTime = DateTime.now();

      var states = MainStates(
          timerRunning: true,
          startTime: startTime,
          customFocusTime: 25,
          customShortBreakTime: 5,
          customLongBreakTime: 20
      );

      var json = states.toJson();

      expect(() {
        if (json['timerRunning'] == true && json['startTime'] == startTime.toIso8601String() && json['customFocusTime'] == 25 && json['customShortBreakTime'] == 5 && json['customLongBreakTime'] == 20) {
          return true;
        }

        return false;
      }(), true);
    });

    test('Testing the main state fromJson function', () {
      var startTime = DateTime.now();

      var states = MainStates(
          timerRunning: true,
          startTime: startTime,
          customFocusTime: 25,
          customShortBreakTime: 5,
          customLongBreakTime: 20
      );

      var json = states.toJson();

      var newStates = MainStates.fromJson(json);

      expect(() {
        if (newStates.timerRunning == true && newStates.startTime == startTime && newStates.customFocusTime == 25 && newStates.customShortBreakTime == 5 && newStates.customLongBreakTime == 20) {
          return true;
        }

        return false;
      }(), true);
    });

    test('Testing the main state fromJson function with missing data', () {
      var startTime = DateTime.now();

      var states = MainStates(
          timerRunning: true,
          startTime: startTime,
          customFocusTime: 25,
          customShortBreakTime: 5,
          customLongBreakTime: 20
      );

      var json = states.toJson();

      var newStatesJson = Map<String, dynamic>.fromEntries(json.entries.where((element) => element.key != 'customFocusTime'));

      var newStates = MainStates.fromJson(newStatesJson);

      expect(() {
        if (newStates.timerRunning == true && newStates.startTime == startTime && newStates.customFocusTime == 25 * 60 && newStates.customShortBreakTime == 5 && newStates.customLongBreakTime == 20) {
          return true;
        }

        return false;
      }(), true);
    });

  });
}
