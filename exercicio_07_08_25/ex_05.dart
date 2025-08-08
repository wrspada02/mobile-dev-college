import 'dart:io';

class House {
  int id;
  String name;
  double price;

  House(this.id, this.name, this.price);
}

void main() {
  List<House> houses = [];
  int id = int.parse(stdin.readLineSync() ?? "");
  String name = stdin.readLineSync();
  double price = double.parse(stdin.readLineSync() ?? "");

  House house = new House(id, name, price);
  houses.add(house);
 
  house
  ..name = "Cadastrado";

  for (var house in houses) {
    print("Id: ${house.id}, name: ${house.name}, price: ${house.price}");
  }
}
