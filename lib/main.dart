import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XylophonePage(),
    );
  }
}

class XylophonePage extends StatefulWidget {
  const XylophonePage({super.key});

  @override
  State<XylophonePage> createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  final List<XyloKeyData> _keys = const [
    XyloKeyData(1, Colors.red, 'C', 'ĐÔ'),
    XyloKeyData(2, Colors.orange, 'D', 'RÊ'),
    XyloKeyData(3, Colors.amber, 'E', 'MI'),
    XyloKeyData(4, Colors.green, 'F', 'PHA'),
    XyloKeyData(5, Colors.teal, 'G', 'SON'),
    XyloKeyData(6, Colors.blue, 'A', 'LA'),
    XyloKeyData(7, Colors.purple, 'B', 'SI'),
  ];

  int? _activeKeyIndex;

  void _playSound(int noteIndex) {
    HapticFeedback.lightImpact();
    setState(() {
      _activeKeyIndex = noteIndex;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          if (_activeKeyIndex == noteIndex) {
            _activeKeyIndex = null;
          }
        });
      }
    });
  }

  Widget _buildKey(int index, XyloKeyData keyData) {
    final isActive = _activeKeyIndex == index;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        child: Material(
          color: isActive
              ? keyData.color.withValues(alpha: 0.8)
              : keyData.color,
          borderRadius: BorderRadius.circular(12),
          elevation: isActive ? 2 : 5,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: Colors.white54,
            onTap: () => _playSound(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        keyData.solfege,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${keyData.noteName})',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Xylophone',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 6),
            ...List.generate(_keys.length, (index) => _buildKey(index, _keys[index])),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

class XyloKeyData {
  final int noteNumber;
  final Color color;
  final String noteName;
  final String solfege;

  const XyloKeyData(
    this.noteNumber,
    this.color,
    this.noteName,
    this.solfege,
  );
}
