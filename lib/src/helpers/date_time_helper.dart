import 'package:ponto_remoto/src/helpers/utils_helper.dart';

class DateTimeHelper {
  static String formatarDuration(Duration duration) {
    String hora = UtilsHelper.twoDigits(duration.inHours);
    String minuto = UtilsHelper.twoDigits(duration.inMinutes.remainder(60));
    String segundo = UtilsHelper.twoDigits(duration.inSeconds.remainder(60));
    return '$hora:$minuto:$segundo';
  }

  static String formatarHora(DateTime dateTime) {
    String hora = UtilsHelper.twoDigits(dateTime.hour);
    String minuto = UtilsHelper.twoDigits(dateTime.minute);
    String segundo = UtilsHelper.twoDigits(dateTime.second);
    return '$hora:$minuto:$segundo';
  }

  static String formatarData(DateTime dateTime) {
    String dia = UtilsHelper.twoDigits(dateTime.day);
    String mes = UtilsHelper.twoDigits(dateTime.month);
    String ano = UtilsHelper.twoDigits(dateTime.year);
    return '$dia/$mes/$ano';
  }
}
