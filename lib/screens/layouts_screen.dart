import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class LayoutsScreen extends StatefulWidget {
  const LayoutsScreen({super.key});

  @override
  State<LayoutsScreen> createState() => _LayoutsScreenState();
}

class _LayoutsScreenState extends State<LayoutsScreen> {
  // Container playground state
  double _borderRadius = 16.0;
  double _borderWidth = 1.0;
  bool _useGradient = true;
  bool _useShadow = true;

  // Row / Column playground state
  bool _isRow = true;
  MainAxisAlignment _mainAxis = MainAxisAlignment.spaceEvenly;
  CrossAxisAlignment _crossAxis = CrossAxisAlignment.center;

  // Wrap state
  final List<String> _tags = [
    'Flutter', 'Widgets', 'Material 3', 'Dart', 'Responsive',
    'Stateful', 'Stateless', 'Animation', 'Cupertino', 'Slivers'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layouts Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. Container Playground
          SectionHeader(
            title: 'Container & BoxDecoration',
            subtitle: 'The foundational canvas for background, borders, radius, gradients, and shadows',
            badge: 'INTERACTIVE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Container & BoxDecoration Code',
                code: '''Container(
  width: double.infinity,
  height: 120,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular($_borderRadius),
    border: Border.all(
      color: Colors.indigo,
      width: $_borderWidth,
    ),
    gradient: ${_useGradient ? 'const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)])' : 'null'},
    boxShadow: [
      ${_useShadow ? 'BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 4))' : ''}
    ],
  ),
  child: const Center(
    child: Text('Styled Container'),
  ),
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Live container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 110,
                  decoration: BoxDecoration(
                    color: _useGradient
                        ? null
                        : (isDark ? const Color(0xFF312E81) : const Color(0xFFEEF2FF)),
                    gradient: _useGradient
                        ? const LinearGradient(
                            colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(_borderRadius),
                    border: Border.all(
                      color: isDark ? const Color(0xFF6366F1) : const Color(0xFF4F46E5),
                      width: _borderWidth,
                    ),
                    boxShadow: _useShadow
                        ? [
                            BoxShadow(
                              color: const Color(0xFF4F46E5).withAlpha(60),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      'Live Interactive Container',
                      style: TextStyle(
                        color: _useGradient ? Colors.white : theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Controls
                Row(
                  children: [
                    Text('Radius: ${_borderRadius.round()}px', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Expanded(
                      child: Slider(
                        value: _borderRadius,
                        min: 0,
                        max: 36,
                        divisions: 18,
                        onChanged: (val) => setState(() => _borderRadius = val),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Border: ${_borderWidth.toStringAsFixed(1)}px', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Expanded(
                      child: Slider(
                        value: _borderWidth,
                        min: 0,
                        max: 6,
                        divisions: 12,
                        onChanged: (val) => setState(() => _borderWidth = val),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 12,
                  children: [
                    FilterChip(
                      label: const Text('Gradient'),
                      selected: _useGradient,
                      onSelected: (val) => setState(() => _useGradient = val),
                    ),
                    FilterChip(
                      label: const Text('Box Shadow'),
                      selected: _useShadow,
                      onSelected: (val) => setState(() => _useShadow = val),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Row & Column Alignment Playground
          SectionHeader(
            title: 'Row & Column Axis Alignment',
            subtitle: 'Visualize how MainAxisAlignment and CrossAxisAlignment distribute children',
            badge: 'FLEXBOX',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Row & Column Alignment Code',
                code: '''${_isRow ? 'Row' : 'Column'}(
  mainAxisAlignment: $_mainAxis,
  crossAxisAlignment: $_crossAxis,
  children: [
    Container(width: 40, height: 40, color: Colors.indigo),
    Container(width: 40, height: 55, color: Colors.cyan),
    Container(width: 40, height: 35, color: Colors.emerald),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Toggle Row vs Column
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Row (Horizontal)')),
                    ButtonSegment(value: false, label: Text('Column (Vertical)')),
                  ],
                  selected: {_isRow},
                  onSelectionChanged: (val) => setState(() => _isRow = val.first),
                ),
                const SizedBox(height: 12),
                // Alignment dropdowns
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    DropdownButton<MainAxisAlignment>(
                      value: _mainAxis,
                      isDense: true,
                      underline: const SizedBox(),
                      items: MainAxisAlignment.values.map((axis) {
                        return DropdownMenuItem(
                          value: axis,
                          child: Text('MainAxis: ${axis.name}', style: const TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _mainAxis = val);
                      },
                    ),
                    DropdownButton<CrossAxisAlignment>(
                      value: _crossAxis,
                      isDense: true,
                      underline: const SizedBox(),
                      items: [
                        CrossAxisAlignment.start,
                        CrossAxisAlignment.center,
                        CrossAxisAlignment.end,
                        CrossAxisAlignment.stretch,
                      ].map((axis) {
                        return DropdownMenuItem(
                          value: axis,
                          child: Text('CrossAxis: ${axis.name}', style: const TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _crossAxis = val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Preview Frame
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: _isRow
                      ? Row(
                          mainAxisAlignment: _mainAxis,
                          crossAxisAlignment: _crossAxis,
                          children: _buildColoredBoxes(),
                        )
                      : Column(
                          mainAxisAlignment: _mainAxis,
                          crossAxisAlignment: _crossAxis,
                          children: _buildColoredBoxes(),
                        ),
                ),
              ],
            ),
          ),

          // 3. Stack & Positioned
          SectionHeader(
            title: 'Stack & Positioned',
            subtitle: 'Layering widgets on top of each other with precise coordinate offsets',
            badge: 'LAYERING',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Stack & Positioned Code',
                code: '''Stack(
  clipBehavior: Clip.none,
  children: [
    Container(width: 80, height: 80, color: Colors.blue),
    Positioned(
      top: -4,
      right: -4,
      child: Badge(child: Icon(Icons.notifications)),
    ),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              children: [
                // Avatar group + badge demo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Stack 1: Overlapping Avatars
                    Column(
                      children: [
                        SizedBox(
                          width: 130,
                          height: 48,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                child: _buildAvatarCircle('A', const Color(0xFF6366F1)),
                              ),
                              Positioned(
                                left: 28,
                                child: _buildAvatarCircle('B', const Color(0xFF0EA5E9)),
                              ),
                              Positioned(
                                left: 56,
                                child: _buildAvatarCircle('C', const Color(0xFF10B981)),
                              ),
                              Positioned(
                                left: 84,
                                child: _buildAvatarCircle('+4', const Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text('Overlapping Avatars', style: TextStyle(fontSize: 11)),
                      ],
                    ),

                    // Stack 2: Icon with Positioned Badge
                    Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.notifications_rounded,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: theme.scaffoldBackgroundColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text('Notification Badge', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 4. Wrap Widget
          SectionHeader(
            title: 'Wrap Widget',
            subtitle: 'Flows children onto multiple horizontal or vertical lines seamlessly',
            badge: 'RESPONSIVE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Wrap Widget Code',
                code: '''Wrap(
  spacing: 8.0, // Gap between adjacent chips
  runSpacing: 8.0, // Gap between lines
  children: [
    Chip(label: Text('Flutter')),
    Chip(label: Text('Dart')),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags.map((tag) {
                return Chip(
                  avatar: CircleAvatar(
                    backgroundColor: theme.colorScheme.primary.withAlpha(40),
                    child: Text(tag[0], style: TextStyle(fontSize: 11, color: theme.colorScheme.primary)),
                  ),
                  label: Text(tag),
                );
              }).toList(),
            ),
          ),

          // 5. Card Variations & Utilities
          SectionHeader(
            title: 'Card Variations & AspectRatio',
            subtitle: 'Outlined, Filled, and Fixed AspectRatio containers',
            badge: 'CONTAINERS',
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.layers_rounded, color: theme.colorScheme.primary),
                        const SizedBox(height: 8),
                        const Text('Elevated Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const Text('Has subtle drop elevation', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.aspect_ratio_rounded, size: 22),
                        SizedBox(height: 4),
                        Text('AspectRatio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('16 : 10 Ratio', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  List<Widget> _buildColoredBoxes() {
    return [
      Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF4F46E5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      Container(
        width: 44,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF0EA5E9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      Container(
        width: 38,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFF10B981),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    ];
  }

  Widget _buildAvatarCircle(String label, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
