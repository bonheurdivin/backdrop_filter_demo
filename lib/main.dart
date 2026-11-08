import 'dart:ui'; // ImageFilter
import 'package:flutter/material.dart';

void main() => runApp(const GlassDemoApp());

/// Frosted-glass "Now Playing" card over a colorful background.
class GlassDemoApp extends StatefulWidget {
  const GlassDemoApp({super.key});
  @override
  State<GlassDemoApp> createState() => _GlassDemoAppState();
}

class _GlassDemoAppState extends State<GlassDemoApp> {
  double sigma = 10;
  BlendMode blend = BlendMode.srcOver;
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    const white = TextStyle(color: Colors.white);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2), Color(0xFFFF6A88)],
            ),
          ),
          child: Stack(alignment: Alignment.center, children: [
            // Colorful shapes + big text so the blur is easy to see
            for (final b in const [
              (-0.8, -0.6, Colors.cyanAccent),
              (0.9, -0.2, Colors.yellowAccent),
              (-0.7, 0.7, Colors.pinkAccent),
              (0.8, 0.8, Colors.greenAccent),
            ])
              Align(
                alignment: Alignment(b.$1, b.$2),
                child: CircleAvatar(radius: 70, backgroundColor: b.$3),
              ),
            const Text('GLASS',
                style: TextStyle(
                    fontSize: 110,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),

            // THE WIDGET: ClipRRect keeps the blur inside the rounded card
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                blendMode: blend,
                enabled: enabled,
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.all(24),
                  color: Colors.white.withValues(alpha: 0.18),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.album, size: 64, color: Colors.white),
                    const Text('Midnight Drive',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    const Text('Neon Waves',
                        style: TextStyle(color: Colors.white70)),
                    const Divider(color: Colors.white38, height: 32),
                    Slider(
                      value: sigma,
                      max: 20,
                      activeColor: Colors.white,
                      onChanged: (v) => setState(() => sigma = v),
                    ),
                    DropdownButton<BlendMode>(
                      value: blend,
                      isExpanded: true,
                      dropdownColor: Colors.deepPurple,
                      style: white,
                      items: [
                        for (final m in const [
                          BlendMode.srcOver,
                          BlendMode.multiply,
                          BlendMode.screen,
                        ])
                          DropdownMenuItem(
                              value: m, child: Text('blendMode: ${m.name}')),
                      ],
                      onChanged: (m) => setState(() => blend = m!),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('enabled: $enabled', style: white),
                      value: enabled,
                      onChanged: (v) => setState(() => enabled = v),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}