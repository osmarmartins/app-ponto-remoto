class Usuario {
  String nome;
  String projeto;
  String tarefa;

  Usuario({
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
