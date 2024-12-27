import 'package:url_launcher/url_launcher.dart';

makingPhoneCall(x) async {
  var url = Uri.parse('tel:$x');
  await launchUrl(url);
}

sendingMails(x) async {
  var url = Uri.parse('mailto:$x');
  await launchUrl(url);
}

sendingSMS(x) async {
  var url = Uri.parse('sms:$x');
  await launchUrl(url);
}
