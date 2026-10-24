import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  BoxFit _selectedFit = BoxFit.cover;
  double _imageRadius = 16.0;
  double _blurSigma = 8.0;

  // Reliable high quality image URLs from Unsplash
  final String _sampleImageUrl =
      'https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?w=800&auto=format&fit=crop&q=80';
  final String _avatarUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&auto=format&fit=crop&q=80';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Images & Media Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. BoxFit Visual Playground
          SectionHeader(
            title: 'BoxFit Playground',
            subtitle: 'Observe how different BoxFit modes scale an image into a fixed container',
            badge: 'ESSENTIAL',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'BoxFit Code',
                code: '''Image.network(
  imageUrl,
  fit: $_selectedFit,
  loadingBuilder: (context, child, progress) {
    if (progress == null) return child;
    return Center(child: CircularProgressIndicator());
  },
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container with fixed dimensions to clearly show fit behavior
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    _sampleImageUrl,
                    fit: _selectedFit,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.broken_image_rounded, size: 36, color: Colors.grey),
                            SizedBox(height: 6),
                            Text('Image failed to load', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
                // BoxFit Selector Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    BoxFit.cover,
                    BoxFit.contain,
                    BoxFit.fill,
                    BoxFit.fitWidth,
                    BoxFit.fitHeight,
                    BoxFit.none,
                  ].map((fit) {
                    final isSelected = _selectedFit == fit;
                    return ChoiceChip(
                      label: Text(fit.name, style: const TextStyle(fontSize: 12)),
                      selected: isSelected,
                      onSelected: (val) {
                        if (val) setState(() => _selectedFit = fit);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // 2. Shape Clipping (ClipRRect & CircleAvatar)
          SectionHeader(
            title: 'Shape Clipping & Avatars',
            subtitle: 'ClipRRect for rounded cards and CircleAvatar for profile photos',
            badge: 'CLIPPING',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Clipping Widgets',
                code: '''// Rounded Image
ClipRRect(
  borderRadius: BorderRadius.circular($_imageRadius),
  child: Image.network(url, width: 100, height: 100, fit: BoxFit.cover),
);

// Circular Avatar with online indicator
CircleAvatar(
  radius: 28,
  backgroundImage: NetworkImage(url),
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ClipRRect item
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(_imageRadius),
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              _sampleImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('ClipRRect (${_imageRadius.round()}px)', style: const TextStyle(fontSize: 11)),
                      ],
                    ),

                    // CircleAvatar item with online badge
                    Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(_avatarUrl),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('CircleAvatar (Online)', style: TextStyle(fontSize: 11)),
                      ],
                    ),

                    // ClipOval
                    Column(
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 80,
                            height: 60,
                            child: Image.network(
                              _sampleImageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('ClipOval', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Corner Radius: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Expanded(
                      child: Slider(
                        value: _imageRadius,
                        min: 0,
                        max: 40,
                        divisions: 8,
                        onChanged: (val) => setState(() => _imageRadius = val),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. Editorial Hero Card with Gradient Overlay
          SectionHeader(
            title: 'Image Gradient Overlay',
            subtitle: 'Rich magazine hero style with dark gradient scrim and legible typography',
            badge: 'PREMIUM',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Gradient Overlay on Image',
                code: '''Stack(
  children: [
    Image.network(url, fit: BoxFit.cover),
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black87],
        ),
      ),
    ),
    Positioned(
      bottom: 16,
      left: 16,
      child: Text('Editorial Title', style: TextStyle(color: Colors.white)),
    ),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      _sampleImageUrl,
                      fit: BoxFit.cover,
                    ),
                    // Gradient scrim
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0x60000000),
                            Color(0xDF000000),
                          ],
                          stops: [0.3, 0.6, 1.0],
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'FEATURED',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Visual Precision in Flutter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Combining Stack, Image, and LinearGradient for cinematic visuals.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. BackdropFilter (Frosted Glass / Glassmorphism)
          SectionHeader(
            title: 'BackdropFilter (Frosted Glass)',
            subtitle: 'Apply Gaussian blur to background pixels for a modern blur effect',
            badge: 'GLASS',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'BackdropFilter Glassmorphism',
                code: '''ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      color: Colors.white.withOpacity(0.15),
      child: Text('Glass Card'),
    ),
  ),
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 180,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(_sampleImageUrl, fit: BoxFit.cover),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: _blurSigma,
                            sigmaY: _blurSigma,
                          ),
                          child: Container(
                            width: 260,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.black.withAlpha(120)
                                  : Colors.white.withAlpha(180),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? Colors.white24 : Colors.white60,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.blur_on_rounded, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Frosted Glass Card',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Live Blur Sigma: ${_blurSigma.round()}',
                                  style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                const Text('Blur Intensity: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Expanded(
                  child: Slider(
                    value: _blurSigma,
                    min: 1,
                    max: 20,
                    divisions: 19,
                    onChanged: (val) => setState(() => _blurSigma = val),
                  ),
                ),
              ],
            ),
          ),

          // 5. Icons Family Showcase
          SectionHeader(
            title: 'Material & Cupertino Icons',
            subtitle: 'Standard iconography designed for cross-platform apps',
            badge: 'ICONS',
          ),
          ShowcaseCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconDemo('Search', Icons.search_rounded, CupertinoIcons.search),
                _buildIconDemo('Favorite', Icons.favorite_rounded, CupertinoIcons.heart_fill),
                _buildIconDemo('Share', Icons.share_rounded, CupertinoIcons.share),
                _buildIconDemo('Settings', Icons.settings_rounded, CupertinoIcons.gear),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildIconDemo(String label, IconData materialIcon, IconData cupertinoIcon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(materialIcon, size: 22),
            const SizedBox(width: 6),
            Icon(cupertinoIcon, size: 20),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
