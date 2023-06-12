import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:flutter/services.dart' show rootBundle;

class RSAEncrypta {
  static final parser = RSAKeyParser();

  static Future<RSAPublicKey> getPublicKey() async {
    RSAPublicKey key = parser.parse(await _loadPublicKey()) as RSAPublicKey;
    return key;
  }

  static Future<RSAPrivateKey> getPrivateKey() async {
    RSAPrivateKey key = parser.parse(await _loadPrivateKey()) as RSAPrivateKey;
    return key;
  }

  static Future<String> encryptText(String text) async {
    RSAPublicKey publicKey = await getPublicKey();
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(text).base64.toString();
  }

  static Future<String> decryptText(String text) async {
    RSAPrivateKey privateKey = await getPrivateKey();
    final encrypter = Encrypter(RSA(privateKey: privateKey));
    return encrypter.decrypt64(text);
  }

  static Future<String> _loadPrivateKey() async {
    return await rootBundle.loadString('private.pem');
  }

  static Future<String> _loadPublicKey() async {
    return await rootBundle.loadString('public.pem');
  }
}
