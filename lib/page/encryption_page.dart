import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/pointycastle.dart';

import '../core/constant.dart';
import '../core/encrypt_rsa.dart';
import 'decrypt_rsa_page.dart';
import 'encrypt_rsa_page.dart';

class EncryptionPage extends StatefulWidget {
  const EncryptionPage({super.key});

  @override
  _EncryptionPageState createState() => _EncryptionPageState();
}

class _EncryptionPageState extends State<EncryptionPage>
    with TickerProviderStateMixin {
  late TabController _tabbarController;
  int currentIndex = 0;
  final TextEditingController _textEditingController = TextEditingController();
  String _encryptedText = '';
  String _decryptedText = '';
  // late AsymmetricKeyPair<PublicKey, PrivateKey> keyPair;

  @override
  void initState() {
    super.initState();
    _tabbarController =
        TabController(length: 3, initialIndex: currentIndex, vsync: this);
    // keyPair = RSAEncrypta.generateRSAKeyPair(RSAEncrypta.getSecureRandom(),
    //     keyLength: 4096);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSA Encryption'),
        bottom: TabBar(
          controller: _tabbarController,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          tabs: const [
            Tab(text: 'Encrypt/Decrypt'),
            Tab(text: 'Encrypt'),
            Tab(text: 'Decrypt'),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IndexedStack(
          index: currentIndex,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Encrypt or Decrypt',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Teks',
                      hintText: 'Masukkan teks',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                      suffixIcon: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              _textEditingController.text = '';
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          IconButton(
                            onPressed: () {
                              Clipboard.getData(Clipboard.kTextPlain)
                                  .then((value) {
                                _textEditingController.text = value?.text ?? '';
                              });
                            },
                            icon: const Icon(Icons.paste),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final text = _textEditingController.text;
                            try {
                              // _encryptedText =
                              //     await RSAEncrypta.encryptText(text, keyPair);
                              _encryptedText =
                                  await RSAEncrypta.encryptText(text);
                              setState(() {});
                            } catch (e) {
                              log(e.toString());
                              log('Input already encrypted');
                            }
                            // final text = _textEditingController.text;

                            // if (text == _encryptedText) {
                            //   log('Input already encrypted');
                            //   return;
                            // }
                            // final encryptedData =
                            //     await RSAEncrypta.encryptText(text);
                            // setState(() {
                            //   _encryptedText = encryptedData;
                            // });
                          },
                          child: const Text('Encrypt'),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            // if (isBase64(_textEditingController.text) ==
                            //     _textEditingController.text.isNotEmpty) {
                            //   _decryptedText = await RSAEncrypta.decryptText(
                            //       _textEditingController.text, keyPair);
                            //   setState(() {});
                            // }
                            final text = _textEditingController.text;
                            try {
                              // _decryptedText =
                              //     await RSAEncrypta.decryptText(text, keyPair);
                              _decryptedText =
                                  await RSAEncrypta.decryptText(text);
                              setState(() {});
                            } catch (e) {
                              log(e.toString());
                              log('Input already decrypted');
                            }
                          },
                          child: const Text('Decrypt'),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _textEditingController.clear();
                      setState(() {
                        _encryptedText = '';
                        _decryptedText = '';
                      });
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text('Clear'),
                  ),
                  const SizedBox(height: 16.0),
                  if (_encryptedText.isNotEmpty) ...[
                    const Text("Hasil Enkripsi:"),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 5),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blue.shade600, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_encryptedText),
                          if (_encryptedText.isNotEmpty)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                width: 50,
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    copyText(_encryptedText, context);
                                  },
                                  child: const Icon(Icons.copy),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (_decryptedText.isNotEmpty) ...[
                    const Text("Hasil Dekripsi:"),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 5),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blue.shade600, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_decryptedText),
                          if (_decryptedText.isNotEmpty)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                width: 50,
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    copyText(_decryptedText, context);
                                  },
                                  child: const Icon(Icons.copy),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Image.asset(
                            'assets/wa.png',
                            width: 50,
                            height: 50,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ec95b),
                          ),
                          onPressed: () {
                            forwardToWhatsApp(_encryptedText);
                          },
                          label: const Text('Kirim ke WhatsApp'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Image.asset(
                            'assets/gmail.png',
                            width: 50,
                            height: 50,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400),
                          onPressed: () {
                            forwardToEmail(_encryptedText);
                          },
                          label: const Text('Kirim ke Email'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            const EncryptRSAPage(),
            const DecryptRSAPage()
          ],
        ),
      ),
    );
  }
}
