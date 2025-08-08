void main() {
  cadastrarFuncionario({String nome = "Julia", String? cargo}) {
    if (cargo != null) {
      print("Olá seja bem-vindo ${nome} com cargo ${cargo}");
    } else {
      print("Olá seja bem-vindo ${nome}");
    }
  }
  
  cadastrarFuncionario(nome: "William", cargo: "Desenvolvedor");
  cadastrarFuncionario(nome: "Josilene");
}
