import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final _instance = TtsService._internal();
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  TtsService._internal();
  factory TtsService() => _instance;

  Future<void> _init() async {
    if (_initialized) return;

    await _tts.setLanguage('id-ID');
    await _tts.setSpeechRate(0.45); // cocok untuk anak-anak
    await _tts.setPitch(1.1);
    await _tts.setVolume(1.0);

    _initialized = true;
  }

  /// =========================
  /// Core Controls
  /// =========================

  Future<void> speak(String text) async {
    await _init();
    await _tts.stop(); // prevent overlap
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  Future<void> pause() async {
    await _tts.pause();
  }

  /// =========================
  /// Voice & Config
  /// =========================

  Future<void> setLanguage(String languageCode) async {
    await _tts.setLanguage(languageCode);
  }

  Future<void> setRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  Future<void> setPitch(double pitch) async {
    await _tts.setPitch(pitch);
  }

  /// Ganti voice (jika tersedia di device)
  Future<void> setVoice({required String name, required String locale}) async {
    await _tts.setVoice({'name': name, 'locale': locale});
  }

  /// =========================
  /// Helpers
  /// =========================

  /// Debug: lihat semua voice di device
  Future<List<dynamic>> getAvailableVoices() async {
    return await _tts.getVoices;
  }

  /// Preset voice Indonesia (fallback-safe)
  Future<void> useIndonesianFemale() async {
    await setVoice(name: 'id-id-x-idc-local', locale: 'id-ID');
  }

  Future<void> useIndonesianMale() async {
    await setVoice(name: 'id-id-x-idd-local', locale: 'id-ID');
  }
}
