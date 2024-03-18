// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.

import 'dart:core';

import 'package:pomotimer/common/reflector.dart' as prefix0;
import 'package:pomotimer/states/timer_states.dart' as prefix1;
// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: unused_import

import 'package:reflectable/mirrors.dart' as m;
import 'package:reflectable/reflectable.dart' as r show Reflectable;
import 'package:reflectable/src/reflectable_builder_based.dart' as r;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.Reflector(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'TimerStates',
            r'.TimerStates',
            134217735,
            0,
            const prefix0.Reflector(),
            const <int>[-1],
            null,
            null,
            -1,
            {r'loadFromStorage': () => prefix1.TimerStates.loadFromStorage},
            {},
            {
              r'': (bool b) => (
                      {timerRunning,
                      startTime,
                      customFocusTime,
                      customShortBreakTime,
                      customLongBreakTime,
                      reminderType}) =>
                  b
                      ? prefix1.TimerStates(
                          customFocusTime: customFocusTime,
                          customLongBreakTime: customLongBreakTime,
                          customShortBreakTime: customShortBreakTime,
                          reminderType: reminderType,
                          startTime: startTime,
                          timerRunning: timerRunning)
                      : null,
              r'fromJson': (bool b) =>
                  (json) => b ? prefix1.TimerStates.fromJson(json) : null,
              r'fromJsonText': (bool b) =>
                  (json) => b ? prefix1.TimerStates.fromJsonText(json) : null
            },
            -1,
            -1,
            const <int>[-1],
            null,
            {
              r'==': 0,
              r'toString': 1,
              r'noSuchMethod': 0,
              r'hashCode': 1,
              r'runtimeType': 1,
              r'addListener': 0,
              r'removeListener': 0,
              r'dispose': 1,
              r'notifyListeners': 3,
              r'hasListeners': 1,
              r'fastForward': 0,
              r'checkAndResetTimer': 1,
              r'resetOffsetTime': 1,
              r'setReminderType': 0,
              r'setCustomTime': 2,
              r'setCustomTimes': 0,
              r'calculateCurrentPhase': 1,
              r'startTimer': 1,
              r'stopTimer': 1,
              r'toJson': 1,
              r'toJsonText': 1,
              r'timerRunning': 1,
              r'timerRunning=': 0,
              r'startTime': 1,
              r'startTime=': 0,
              r'offsetTime': 1,
              r'offsetTime=': 0,
              r'customFocusTime': 1,
              r'customFocusTime=': 0,
              r'customShortBreakTime': 1,
              r'customShortBreakTime=': 0,
              r'customLongBreakTime': 1,
              r'customLongBreakTime=': 0,
              r'reminderType': 1,
              r'reminderType=': 0,
              r'customTimes': 1,
              r'elapsedTime': 1,
              r'totalTime': 1,
              r'totalTimeMilliseconds': 1,
              r'loadFromStorage': 1
            })
      ],
      null,
      null,
      <Type>[prefix1.TimerStates],
      1,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'addListener': (dynamic instance) => instance.addListener,
        r'removeListener': (dynamic instance) => instance.removeListener,
        r'dispose': (dynamic instance) => instance.dispose,
        r'notifyListeners': (dynamic instance) => instance.notifyListeners,
        r'hasListeners': (dynamic instance) => instance.hasListeners,
        r'fastForward': (dynamic instance) => instance.fastForward,
        r'checkAndResetTimer': (dynamic instance) =>
            instance._checkAndResetTimer,
        r'resetOffsetTime': (dynamic instance) => instance.resetOffsetTime,
        r'setReminderType': (dynamic instance) => instance.setReminderType,
        r'setCustomTime': (dynamic instance) => instance.setCustomTime,
        r'setCustomTimes': (dynamic instance) => instance.setCustomTimes,
        r'calculateCurrentPhase': (dynamic instance) =>
            instance.getCurrentPhase,
        r'startTimer': (dynamic instance) => instance.startTimer,
        r'stopTimer': (dynamic instance) => instance.stopTimer,
        r'toJson': (dynamic instance) => instance.toJson,
        r'toJsonText': (dynamic instance) => instance.toJsonText,
        r'timerRunning': (dynamic instance) => instance.timerRunning,
        r'startTime': (dynamic instance) => instance.startTime,
        r'offsetTime': (dynamic instance) => instance.offsetTime,
        r'customFocusTime': (dynamic instance) => instance.customFocusTime,
        r'customShortBreakTime': (dynamic instance) =>
            instance.customShortBreakTime,
        r'customLongBreakTime': (dynamic instance) =>
            instance.customLongBreakTime,
        r'reminderType': (dynamic instance) => instance.reminderType,
        r'customTimes': (dynamic instance) => instance.customTimes,
        r'elapsedTime': (dynamic instance) => instance.elapsedTime,
        r'totalTime': (dynamic instance) => instance.totalTime,
        r'totalTimeMilliseconds': (dynamic instance) =>
            instance.totalTimeMilliseconds
      },
      {
        r'timerRunning=': (dynamic instance, value) =>
            instance.timerRunning = value,
        r'startTime=': (dynamic instance, value) => instance.startTime = value,
        r'offsetTime=': (dynamic instance, value) =>
            instance.offsetTime = value,
        r'customFocusTime=': (dynamic instance, value) =>
            instance.customFocusTime = value,
        r'customShortBreakTime=': (dynamic instance, value) =>
            instance.customShortBreakTime = value,
        r'customLongBreakTime=': (dynamic instance, value) =>
            instance.customLongBreakTime = value,
        r'reminderType=': (dynamic instance, value) =>
            instance.reminderType = value
      },
      null,
      [
        const [1, 0, null],
        const [0, 0, null],
        const [2, 0, null],
        const [
          0,
          0,
          const [#saveToStorage]
        ],
        const [
          0,
          0,
          const [
            #timerRunning,
            #startTime,
            #customFocusTime,
            #customShortBreakTime,
            #customLongBreakTime,
            #reminderType
          ]
        ]
      ])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
