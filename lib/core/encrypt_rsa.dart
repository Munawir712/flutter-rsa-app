import 'dart:math';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/export.dart';
// import 'package:pointycastle/pointycastle.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

class RSAEncrypta {
  static final parser = encrypt.RSAKeyParser();
  static late AsymmetricKeyPair<PublicKey, PrivateKey> keyPair;

  static Future<RSAPublicKey> getPublicKey() async {
    RSAPublicKey key = parser.parse(await _loadPublicKey()) as RSAPublicKey;
    return key;
  }

  static Future<RSAPrivateKey> getPrivateKey() async {
    RSAPrivateKey key = parser.parse(await _loadPrivateKey()) as RSAPrivateKey;
    return key;
  }

  static instace() {
    keyPair = generateRSAKeyPair(getSecureRandom());
  }

  static Future<String> encryptText(String text) async {
    RSAPublicKey publicKey = await getPublicKey();
    RSAPrivateKey privateKey = await getPrivateKey();
    // RSAPublicKey publicKey = keyPair.publicKey as RSAPublicKey;
    // RSAPrivateKey privateKey = keyPair.privateKey as RSAPrivateKey;
    final encrypter = encrypt.Encrypter(
        encrypt.RSA(publicKey: publicKey, privateKey: privateKey));
    return encrypter.encrypt(text).base64.toString();
  }

  static Future<String> decryptText(String text) async {
    RSAPrivateKey privateKey = await getPrivateKey();
    // RSAPrivateKey privateKey = keyPair.privateKey as RSAPrivateKey;
    final encrypter = encrypt.Encrypter(encrypt.RSA(privateKey: privateKey));
    return encrypter.decrypt64(text);
  }

  static Future<String> _loadPrivateKey() async {
    return await rootBundle.loadString('private.pem');
  }

  static Future<String> _loadPublicKey() async {
    return await rootBundle.loadString('public.pem');
  }

  static SecureRandom getSecureRandom() {
    final secureRandom = FortunaRandom(); // Get directly

    final seedSource = Random.secure();
    final seeds = <int>[];
    for (int i = 0; i < 32; i++) {
      seeds.add(seedSource.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    return secureRandom;
  }

  static AsymmetricKeyPair<PublicKey, PrivateKey> generateRSAKeyPair(
      SecureRandom secureRandom,
      {int keyLength = 2048}) {
    final keyGen = RSAKeyGenerator()
      ..init(
        ParametersWithRandom(
          RSAKeyGeneratorParameters(
            BigInt.parse('65537'),
            keyLength,
            64,
          ),
          secureRandom,
        ),
      );

    final keyPair = keyGen.generateKeyPair();
    return AsymmetricKeyPair<PublicKey, PrivateKey>(
        keyPair.publicKey, keyPair.privateKey);
  }
}
