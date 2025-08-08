void main() {
  var equipamento = "Impressora 3D";
  String local = "Lab de Protótipos";
  dynamic numPatrimonio = 12345;

  numPatrimonio = "12345-A";
  
  print("${equipamento} de tipo ${equipamento is String}");
  print("${local} de tipo ${local is String}");
  print("${numPatrimonio} de tipo ${numPatrimonio is String}");
  
  // permite mudar o tipo de numPatrimonio pois é type dynamic 
}
