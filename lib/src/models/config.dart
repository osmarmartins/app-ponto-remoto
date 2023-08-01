class Config {
  String nome;
  String projeto;
  String tarefa;

  Config({
    required this.nome,
    required this.projeto,
    required this.tarefa,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'projeto': projeto,
      'tarefa': tarefa,
    };
  }
}
