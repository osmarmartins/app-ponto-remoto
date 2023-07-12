class Ponto {
  String usuario;
  String projeto;
  String atividade;
  DateTime inicio;
  DateTime? fim;

  Ponto({
    required this.usuario,
    required this.projeto,
    required this.atividade,
    required this.inicio,
    this.fim,
  });

  @override
  String toString() {
    return 'ponto: { usuario: $usuario, projeto: $projeto, atividade: $atividade, inicio: $inicio, fim: $fim }';
  }
}
