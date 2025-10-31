class Login {
  late final String _usuario;
  late final String _senha;

  Login(
    { required String usuario, required String senha }
  ): _usuario = usuario, _senha = senha;
  String get usuario => _usuario;
  String get senha => _senha;
}
