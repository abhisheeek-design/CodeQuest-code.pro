import 'package:flutter/material.dart';

void main() {
  runApp(const CodeQuestApp());
}

class CodeQuestApp extends StatelessWidget {
  const CodeQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        fontFamily: 'PressStart2P',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          secondary: Color(0xFF00B0FF),
          error: Color(0xFFFF5252),
          surface: Color(0xFF1A1A1A),
        ),
        useMaterial3: true,
      ),
      home: const LevelSelectScreen(),
    );
  }
}

class Track {
  const Track({
    required this.name,
    required this.icon,
    required this.progress,
    required this.levels,
    required this.accent,
  });

  final String name;
  final String icon;
  final double progress;
  final List<String> levels;
  final Color accent;
}

const tracks = [
  Track(
    name: 'HTML',
    icon: '</>',
    progress: 0.72,
    levels: ['Beginner', 'Intermediate', 'Locked'],
    accent: Color(0xFF00E676),
  ),
  Track(
    name: 'Java',
    icon: 'JV',
    progress: 0.36,
    levels: ['Beginner', 'Locked', 'Locked'],
    accent: Color(0xFF00B0FF),
  ),
  Track(
    name: 'Python',
    icon: 'PY',
    progress: 0.54,
    levels: ['Beginner', 'Intermediate', 'Locked'],
    accent: Color(0xFFFFD166),
  ),
];

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeQuest', style: TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF0D0D0D),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () {},
            icon: const Icon(Icons.light_mode_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'LEVEL SELECT',
              style: TextStyle(color: Color(0xFF00E676), fontSize: 12),
            ),
            const SizedBox(height: 12),
            const Text(
              'Choose a coding track and clear each node to unlock the next challenge.',
              style: TextStyle(
                color: Color(0xFFA0A0A0),
                fontSize: 11,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 20),
            for (final track in tracks) TrackCard(track: track),
          ],
        ),
      ),
    );
  }
}

class TrackCard extends StatelessWidget {
  const TrackCard({required this.track, super.key});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: const Color(0xFF2E2E2E), width: 4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(5, 5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PixelIcon(label: track.icon, color: track.accent),
              const SizedBox(width: 14),
              Expanded(
                child: Text(track.name, style: const TextStyle(fontSize: 18)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: LinearProgressIndicator(
              value: track.progress,
              minHeight: 14,
              color: track.accent,
              backgroundColor: const Color(0xFF242424),
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < track.levels.length; i++)
            LevelRow(index: i + 1, label: track.levels[i]),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                foregroundColor: const Color(0xFF061006),
                shape: const BeveledRectangleBorder(),
                side: const BorderSide(color: Color(0xFFF5F5F5), width: 3),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Text('START', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

class PixelIcon extends StatelessWidget {
  const PixelIcon({required this.label, required this.color, super.key});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        border: Border.all(color: const Color(0xFF2E2E2E), width: 4),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12)),
    );
  }
}

class LevelRow extends StatelessWidget {
  const LevelRow({required this.index, required this.label, super.key});

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    final locked = label == 'Locked';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF242424),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'LEVEL $index',
              style: TextStyle(
                color: locked ? const Color(0xFFA0A0A0) : Colors.white,
                fontSize: 10,
              ),
            ),
          ),
          Text(
            locked ? 'LOCKED' : label.toUpperCase(),
            style: TextStyle(
              color: locked ? const Color(0xFFFF5252) : const Color(0xFF00E676),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
