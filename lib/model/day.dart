class MyClass {
  String title;
  bool value;
  MyClass(this.title, this.value);
  @override
  String toString() {
    return 'MyClass{title: $title, value: $value}';
  }
}