import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void forwardToWhatsApp(String encryptedText) async {
  final formattedMessage =
      Uri.encodeComponent('Pesan Enkripsi: $encryptedText');
  final url = 'whatsapp://send?text=$formattedMessage';

  await launchUrl(Uri.parse(url));
}

void forwardToEmail(String encryptedText) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: encryptedText,
    query:
        'subject=${Uri.encodeComponent('Pesan Enkripsi')}&body=${Uri.encodeComponent('Pesan Enkripsi: $encryptedText')}',
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

bool isBase64(String input) {
  try {
    final decodedBytes = base64.decode(input);
    final decodedText = Uint8List.fromList(decodedBytes);
    final encodedText = base64.encode(decodedText);
    log((encodedText == input).toString());
    return encodedText == input;
  } catch (e) {
    return false;
  }
}
