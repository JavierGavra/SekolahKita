import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  late stt.SpeechToText _speech;
  bool _isInitialized = false;
  bool isListening = false;

  bool get isAvailable => _isInitialized && _speech.isAvailable;

  Future<void> initialize() async {
    _speech = stt.SpeechToText();
    _isInitialized = await _speech.initialize(
      onError: (error) => print('Speech Error: $error'),
      onStatus: (status) => print('Speech Status: $status'),
    );
  }

  Future<void> startListening({required Function(String) onResult}) async {
    if (_isInitialized && !_speech.isAvailable) {
      throw 'Speech recognition belum tersedia';
    }

    isListening = true;
    await _speech.listen(
      localeId: 'id_ID',
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.confirmation,
      ),
      onResult: (result) {
        if (result.finalResult) {
          onResult(result.recognizedWords);
        }
      },
    );

    Future.delayed(const Duration(seconds: 5), () {
      if (_speech.isListening) stopListening();
    });
  }

  Future<void> stopListening() async {
    if (_speech.isListening) await _speech.stop();
    isListening = false;
  }

  void dispose() => _speech.stop();
}
