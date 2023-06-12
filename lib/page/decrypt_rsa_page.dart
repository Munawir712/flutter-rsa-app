import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constant.dart';
import '../core/encrypt_rsa.dart';

class DecryptRSAPage extends StatefulWidget {
  const DecryptRSAPage({super.key});

  @override
  State<DecryptRSAPage> createState() => _DecryptRSAPageState();
}

class _DecryptRSAPageState extends State<DecryptRSAPage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _decryptedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Decrypt',
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
                        Clipboard.getData(Clipboard.kTextPlain).then((value) {
                          _textEditingController.text = value?.text ?? '';
                        });
                      },
                      icon: const Icon(Icons.paste),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (isBase64(_textEditingController.text) ==
                    _textEditingController.text.isNotEmpty) {
                  _decryptedText = await RSAEncrypta.decryptText(
                      _textEditingController.text);
                  setState(() {});
                }
              },
              child: const Text('Dekripsi'),
            ),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                _textEditingController.clear();
                setState(() {
                  _decryptedText = '';
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Clear'),
            ),
            const SizedBox(height: 16.0),
            if (_decryptedText.isNotEmpty) ...[
              const Text("Hasil Dekripsi:"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade600, width: 2),
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
                      forwardToWhatsApp(_decryptedText);
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
                      forwardToEmail(_decryptedText);
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
    );
  }
}
