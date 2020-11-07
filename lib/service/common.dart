import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:paroont_realty_mobile/constant/url_const.dart';

class CommonService {
  static final CommonService _instance = CommonService._internal();
  factory CommonService() {
    return _instance;
  }

  CommonService._internal();

  void sendWhatsApp({String number, String msg}) async {
    String url = URL_WHATS_APP;
    if (notBlankStr(number)) {
      url = '$url${_makeWhatsAppNo(number)}';
    }
    if (notBlankStr(msg)) {
      url = '$url?text=${Uri.parse(msg)}';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _makeWhatsAppNo(String number) {
    return number.replaceAll(RegExp(r'\D'), '').replaceAll(RegExp('^0+'), '');
  }
}
