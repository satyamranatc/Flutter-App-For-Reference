import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  int _crossAxisCount = 2;
  double _spacing = 12.0;
  double _aspectRatio = 0.9;
  final Set<int> _favoriteIndexes = {0, 2};

  final List<Map<String, dynamic>> _items = [
    {
      'title': 'ElevatedButton',
      'category': 'Actions',
      'icon': Icons.smart_button_rounded,
      'color': const Color(0xFF4F46E5),
      'rating': 4.9,
    },
    {
      'title': 'CustomScrollView',
      'category': 'Scrolling',
      'icon': Icons.swap_vert_circle_rounded,
      'color': const Color(0xFF0EA5E9),
      'rating': 4.8,
    },
    {
      'title': 'GridView.builder',
      'category': 'Layout',
      'icon': Icons.grid_view_rounded,
      'color': const Color(0xFF10B981),
      'rating': 5.0,
    },
    {
      'title': 'BackdropFilter',
      'category': 'Effects',
      'icon': Icons.blur_on_rounded,
      'color': const Color(0xFF8B5CF6),
      'rating': 4.7,
    },
    {
      'title': 'SegmentedButton',
      'category': 'Selection',
      'icon': Icons.view_week_rounded,
      'color': const Color(0xFFF59E0B),
      'rating': 4.6,
    },
    {
      'title': 'Hero Animation',
      'category': 'Motion',
      'icon': Icons.flight_takeoff_rounded,
      'color': const Color(0xFFEC4899),
      'rating': 4.9,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. Interactive Control Panel
          SectionHeader(
            title: 'GridView Dynamic Controls',
            subtitle: 'Fine-tune column counts, axis spacing, and aspect ratio in real-time',
            badge: 'INTERACTIVE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'GridView.builder Parameters',
                code: '''GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: $_crossAxisCount,
    crossAxisSpacing: $_spacing,
    mainAxisSpacing: $_spacing,
    childAspectRatio: $_aspectRatio,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Card(...);
  },
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Column count segmented
                Row(
                  children: [
                    const Text('Columns: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 2, label: Text('2 Cols')),
                          ButtonSegment(value: 3, label: Text('3 Cols')),
                          ButtonSegment(value: 4, label: Text('4 Cols')),
                        ],
                        selected: {_crossAxisCount},
                        onSelectionChanged: (val) => setState(() => _crossAxisCount = val.first),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Spacing slider
                Row(
                  children: [
                    SizedBox(width: 90, child: Text('Spacing: ${_spacing.round()}px', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(
                      child: Slider(
                        value: _spacing,
                        min: 4,
                        max: 24,
                        divisions: 10,
                        onChanged: (val) => setState(() => _spacing = val),
                      ),
                    ),
                  ],
                ),
                // Aspect Ratio slider
                Row(
                  children: [
                    SizedBox(width: 90, child: Text('Aspect: ${_aspectRatio.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(
                      child: Slider(
                        value: _aspectRatio,
                        min: 0.7,
                        max: 1.4,
                        divisions: 14,
                        onChanged: (val) => setState(() => _aspectRatio = val),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 2. The Live Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
              crossAxisSpacing: _spacing,
              mainAxisSpacing: _spacing,
              childAspectRatio: _aspectRatio,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              final isFav = _favoriteIndexes.contains(index);
              final color = item['color'] as Color;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: color.withAlpha(30),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(item['icon'] as IconData, color: color, size: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFav) {
                                  _favoriteIndexes.remove(index);
                                } else {
                                  _favoriteIndexes.add(index);
                                }
                              });
                            },
                            child: Icon(
                              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              size: 18,
                              color: isFav ? Colors.red : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer.withAlpha(90),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item['category'] as String,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['title'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                              const SizedBox(width: 3),
                              Text(
                                '${item['rating']}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
