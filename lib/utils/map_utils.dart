import 'package:maps_launcher/maps_launcher.dart';

class MapUtils {

  MapUtils._();

  static void openMap(double ?latitude, double ?longitude, String ?address) async {
    if (address != null) {
      MapsLauncher.launchQuery(address);
    } else if (latitude != null && longitude != null) {
      MapsLauncher.launchCoordinates(latitude, longitude);
    }
  }
}