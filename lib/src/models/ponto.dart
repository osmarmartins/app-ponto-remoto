import 'package:ponto_remoto/src/helpers/date_time_helper.dart';

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

  duracao() {
    return DateTimeHelper.formatarDuration(fim!.difference(inicio));
  }

  tempo() {
    return fim!.difference(inicio);
  }

  @override
  String toString() {
    return 'ponto: { usuario: $usuario, projeto: $projeto, atividade: $atividade, inicio: $inicio, fim: $fim }';
  }

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'projeto': projeto,
      'atividade': atividade,
      'inicio': inicio.toString(),
      'fim': fim.toString(),
    };
  }
}
