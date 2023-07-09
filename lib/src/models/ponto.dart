class Ponto {
  String idUsuario;
  String tarefa;
  DateTime data;
  DateTime inicio;
  DateTime? fim;

  Ponto({
    required this.idUsuario,
    required this.tarefa,
    required this.data,
    required this.inicio,
    this.fim,
  });
}
