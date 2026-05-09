import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceCommandScreen extends StatefulWidget {
  const VoiceCommandScreen({super.key});

  @override
  State<VoiceCommandScreen> createState() => _VoiceCommandScreenState();
}

class _VoiceCommandScreenState extends State<VoiceCommandScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _enabled = false;
  bool _listening = false;
  String _recognized = 'Say: Help me, Emergency, Save me';

  Future<void> _toggleListen() async {
    if (!_enabled) {
      _enabled = await _speech.initialize(onError: (e) {});
    }
    if (!_enabled) return;

    if (_listening) {
      await _speech.stop();
      setState(() => _listening = false);
    } else {
      setState(() => _listening = true);
      await _speech.listen(onResult: (res) {
        setState(() => _recognized = res.recognizedWords);
        final lower = res.recognizedWords.toLowerCase();
        if (lower.contains('help me') || lower.contains('emergency') || lower.contains('save me')) {
          // Trigger emergency routing / navigator could go to SOS in future.
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Command')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _listening ? 180 : 140,
              height: _listening ? 180 : 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _listening ? Colors.cyanAccent.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                boxShadow: [BoxShadow(color: Colors.cyanAccent.withOpacity(_listening ? 0.35 : 0.08), blurRadius: 32)],
              ),
              child: const Icon(Icons.mic, size: 56),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(_recognized, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _toggleListen, child: Text(_listening ? 'Stop Listening' : 'Start Listening')),
          ],
        ),
      ),
    );
  }
}
