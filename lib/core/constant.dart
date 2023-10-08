import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void forwardToWhatsApp(String encryptedText, {bool isDecrypt = false}) async {
  final formattedMessage = Uri.encodeComponent(
      isDecrypt ? encryptedText : 'Pesan Enkripsi: $encryptedText');
  final url = 'whatsapp://send?text=$formattedMessage';

  await launchUrl(Uri.parse(url));
}

void forwardToEmail(String encryptedText, {bool isDecrypt = false}) async {
  String query = isDecrypt
      ? 'subject=${Uri.encodeComponent('Pesan')}&body=${Uri.encodeComponent('Pesan: $encryptedText')}'
      : 'subject=${Uri.encodeComponent('Pesan Enkripsi')}&body=${Uri.encodeComponent('Pesan Enkripsi: $encryptedText')}';
  final Uri params = Uri(
    scheme: 'mailto',
    path: encryptedText,
    query: query,
  );

  String url = params.toString();

  await launchUrl(Uri.parse(url));
}

void copyText(String text, context) {
  Clipboard.setData(ClipboardData(text: text));
  const snackBar = SnackBar(
    content: Text('Teks berhasil disalin!'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
