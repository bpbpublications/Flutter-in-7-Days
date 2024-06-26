void main() {
  final person1 = Person(name: "Alice", age: 30);
  final person2 = person1.copyWith(name: "Bob");

  print(person1.name); // Output: Alice
  print(person2.name); // Output: Bob
  print(person2.age); // Output: 30 (age is not changed)
}

class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  Person copyWith({String? name, int? age}) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}
