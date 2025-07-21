import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

abstract class Animal {
  static const String kingdom = 'Animalia';
  late String name;
  int? age;

  Animal(this.name, [this.age]);

  void makeSound();
  String get species;
}

enum PetType { dog, cat, bird, fish }

mixin Flyable {
  bool canFly = true;
  void fly() => print('Flying...');
}

class Dog extends Animal with Flyable implements Comparable<Dog> {
  final String breed;
  bool _isGoodBoy = true;

  Dog(super.name, this.breed, {super.age}) : assert(breed.isNotEmpty);

  Dog.puppy(String name, String breed) : this(name, breed, age: 0);

  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(map['name'], map['breed'], age: map['age']);
  }

  @override
  void makeSound() {
    print('Woof! My name is $name');
  }

  @override
  String get species => 'Canis lupus';

  set isGoodBoy(bool value) => _isGoodBoy = value;
  bool get isGoodBoy => _isGoodBoy;

  @override
  int compareTo(Dog other) => name.compareTo(other.name);

  Dog operator +(Dog other) {
    return Dog('${name} & ${other.name}', '$breed-${other.breed} mix');
  }

  static List<Dog> createPack(int count) {
    return List.generate(count, (i) => Dog('Dog$i', 'Mixed'));
  }
}

class Container<T> {
  T _value;

  Container(this._value);

  T get value => _value;
  set value(T newValue) => _value = newValue;

  R transform<R>(R Function(T) transformer) => transformer(_value);
}

extension StringExtensions on String {
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

Future<void> demonstrateControlFlow() async {
  var numbers = <int>[1, 2, 3, 4, 5];

  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] % 2 == 0) {
      print('Even: ${numbers[i]}');
      continue;
    } else {
      print('Odd: ${numbers[i]}');
    }
  }

  for (final number in numbers) {
    print('Processing: $number');
  }

  int counter = 0;
  while (counter < 3) {
    print('Counter: $counter');
    counter++;
  }

  do {
    counter--;
    print('Countdown: $counter');
  } while (counter > 0);

  String result = switch (numbers.first) {
    1 => 'One',
    2 => 'Two',
    3 => 'Three',
    _ => 'Other',
  };
  print(result);

  try {
    await riskyOperation();
  } on FileSystemException catch (e) {
    print('File error: $e');
    rethrow;
  } catch (e, stackTrace) {
    print('General error: $e');
    print('Stack: $stackTrace');
  } finally {
    print('Cleanup complete');
  }
}

void demonstrateFunctions({
  required String mandatory,
  String optional = 'default',
  String? nullable,
}) {
  String localFunction(String input) {
    return input.toUpperCase();
  }

  var anonymousFunction = (String x) => x.toLowerCase();

  void executeFunction(Function(String) fn) {
    fn('test');
  }

  executeFunction(localFunction);
}

Future<String> riskyOperation() async {
  await Future.delayed(Duration(seconds: 1));
  throw Exception('Something went wrong');
}

void main() async {
  const int constantValue = 42;
  final String finalValue = 'Hello';
  var dynamicValue = 'World';
  late String lateValue;

  String? nullableString;
  String nonNullString = nullableString ?? 'Default';
  nullableString?.length;

  List<String> stringList = ['a', 'b', 'c'];
  Set<int> numberSet = {1, 2, 3};
  Map<String, int> scoreMap = {'Alice': 100, 'Bob': 85};

  var record = ('first', second: 42, true);
  print('Record: ${record.$1}, ${record.second}, ${record.$3}');

  switch (record) {
    case (String first, :int second, bool third) when second > 40:
      print('Matched pattern with $first, $second, $third');
    default:
      print('No match');
  }

  Dog myDog = Dog('Buddy', 'Golden Retriever', age: 5);
  Dog puppy = Dog.puppy('Max', 'Labrador');

  myDog
    ..makeSound()
    ..isGoodBoy = true
    ..fly();

  List<Dog> moreDogs = [...Dog.createPack(2), myDog];

  List<String> conditionalList = [
    'Always included',
    if (myDog.isGoodBoy) 'Good boy item',
    for (int i = 0; i < 3; i++) 'Item $i',
  ];

  Animal animal = myDog as Animal;
  print('It is an animal!');

  try {
    await demonstrateControlFlow();
  } catch (e) {
    print('Caught: $e');
  }

  lateValue = 'Initialized later';
  print(lateValue);
}
