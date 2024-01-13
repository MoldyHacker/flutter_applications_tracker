import 'package:url_launcher/url_launcher.dart';

class UrlUtils {
  static Future<void> launchWebUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchEmail(String email) async {
    if (!await launchUrl(Uri(scheme: 'mailto', path: email))) {
      throw Exception('Could not launch $email');
    }
  }
}
