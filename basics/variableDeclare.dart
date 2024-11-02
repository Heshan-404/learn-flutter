void main() {
  int intValue = 123;
  print(intValue);

  String stringValue = "abc";
  print(stringValue);

  const constValue = 123; //compile time (cant assign value except const)

  final finalValue = intValue; //runtime ()

  var intList = [1, 2, 3, 4, 5];

  var stringList = {"a", "b", "c", "d"};

  print(stringList);

  stringList.forEach(print);
}
