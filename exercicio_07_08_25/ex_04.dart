class Laptop {
  int id;
  String nome;
  int ram;
  int clockCpu;
  
  Laptop.Internet(this.id, this.nome, this.ram, this.clockCpu);
  Laptop.Escritorio(this.id, this.nome, this.ram, this.clockCpu);
  Laptop.Programacao(this.id, this.nome, this.ram, this.clockCpu);
}
