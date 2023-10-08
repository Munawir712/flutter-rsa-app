import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsa_app/page/encryption_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // rsaExample();
  // RSAEncrypta.instace();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSA APP',
      debugShowCheckedModeBanner: false,
      home: const EncryptionPage(),
      theme: ThemeData(
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: const Color(0xFF00AA97)),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Color(0xFF00AA97)),
        ),
      ),
    );
  }
}

// Future<String> loadAsset() async {
//   return await rootBundle.loadString('private.pem');
// }

// Future<String> loadAsset1() async {
//   return await rootBundle.loadString('public.pem');
// }

// void rsaExample() async {
//   final parser = RSAKeyParser();
//   RSAPublicKey public = parser.parse(await loadAsset1()) as RSAPublicKey;
//   RSAPrivateKey private = parser.parse(await loadAsset()) as RSAPrivateKey;
//   // final publicKey = await parseKeyFromFile<RSAPublicKey>('assets/public.pem');
//   // final privKey = await parseKeyFromFile<RSAPrivateKey>('assets/private.pem');
//   final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
//   Encrypter encrypter;
//   Encrypted encrypted;
//   String decrypted;

//   // PKCS1 (Default)
//   encrypter = Encrypter(RSA(publicKey: public, privateKey: private));
//   encrypted = encrypter.encrypt(plainText);
//   decrypted = encrypter.decrypt(encrypted);

//   log('PKCS1 (Default)');
//   log(decrypted);
//   log(encrypted.bytes.toString());
//   log(encrypted.base16);
//   log(encrypted.base64);

//   // OAEP (SHA1)
//   encrypter = Encrypter(
//     RSA(publicKey: public, privateKey: private, encoding: RSAEncoding.OAEP),
//   );
//   encrypted = encrypter.encrypt(plainText);
//   decrypted = encrypter.decrypt(encrypted);

//   log('\nOAEP (SHA1)');
//   log(decrypted);
//   log(encrypted.bytes.toString());
//   log(encrypted.base16);
//   log(encrypted.base64);

//   // OAEP (SHA256)
//   encrypter = Encrypter(RSA(
//     publicKey: public,
//     privateKey: private,
//     encoding: RSAEncoding.OAEP,
//   ));
//   encrypted = encrypter.encrypt(plainText);
//   decrypted = encrypter.decrypt(encrypted);

//   log('\nOAEP (SHA256)');
//   log(decrypted);
//   log(encrypted.bytes.toString());
//   log(encrypted.base16);
//   log(encrypted.base64);
// }
