class Laptop {
  int id;
  String nome;
  int ram;
  int clockCpu;
  
  Laptop(this.id, this.nome, this.ram, this.clockCpu);
}

void main() {
  List<Laptop> laptops = [new Laptop(1, "A", 3, 5), new Laptop(2, "B", 5, 5), new Laptop(3, "C", 1, 2)];
  
  laptops.forEach((laptop) => print("Id: ${laptop.id}, nome: ${laptop.nome}, ram: ${laptop.ram}, clockCpu: ${laptop.clockCpu}"));
}
