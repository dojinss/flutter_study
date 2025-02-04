class Animal {
  void makeSound() {
    print('으르렁');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('멍멍!');
  }
}

void main() {
  var dog = Dog();
  dog.makeSound(); // 출력: Woof! Woof!
}
