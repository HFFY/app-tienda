import 'package:url_launcher/url_launcher.dart';

/// Abre un chat de WhatsApp con el número dado.
///
/// Normaliza el teléfono (quita espacios, guiones y paréntesis) y, si no
/// empieza con `+`, antepone el código de país configurado en la tienda.
/// No usa `canLaunchUrl` para evitar declarar `<queries>` en el manifest.
abstract final class WhatsAppLauncher {
  static String normalize(String phone, String countryCode) {
    var digits = phone.replaceAll(RegExp(r'[\s\-\(\)\.]'), '');
    if (digits.startsWith('+')) {
      digits = digits.substring(1);
    } else if (digits.startsWith('00')) {
      digits = digits.substring(2);
    } else {
      final cc = countryCode.replaceAll(RegExp(r'\D'), '');
      if (cc.isNotEmpty && !digits.startsWith(cc)) digits = '$cc$digits';
    }
    return digits.replaceAll(RegExp(r'\D'), '');
  }

  static Future<bool> open(String phone, {required String countryCode, String? text}) {
    final digits = normalize(phone, countryCode);
    final uri = Uri.https('wa.me', '/$digits', text == null ? null : {'text': text});
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
