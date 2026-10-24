import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class FlexScreen extends StatefulWidget {
  const FlexScreen({super.key});

  @override
  State<FlexScreen> createState() => _FlexScreenState();
}

class _FlexScreenState extends State<FlexScreen> {
  int _flex1 = 1;
  int _flex2 = 2;
  int _flex3 = 1;
  bool _isTight = true;
  int _spacerFlex = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final totalFlex = _flex1 + _flex2 + _flex3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flex & Spacing Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. Interactive Flex Factors
          SectionHeader(
            title: 'Expanded with Flex Factors',
            subtitle: 'Divide space proportionally among children based on flex ratios',
            badge: 'INTERACTIVE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Expanded Flex Proportions',
                code: '''Row(
  children: [
    Expanded(
      flex: $_flex1, // Takes $_flex1/$totalFlex of space
      child: Container(color: Colors.indigo),
    ),
    Expanded(
      flex: $_flex2, // Takes $_flex2/$totalFlex of space
      child: Container(color: Colors.sky),
    ),
    Expanded(
      flex: $_flex3, // Takes $_flex3/$totalFlex of space
      child: Container(color: Colors.emerald),
    ),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Live proportional bar
                Container(
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      Expanded(
                        flex: _flex1,
                        child: Container(
                          color: const Color(0xFF4F46E5),
                          child: Center(
                            child: Text(
                              'Flex $_flex1\n(${(_flex1 / totalFlex * 100).toStringAsFixed(0)}%)',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: _flex2,
                        child: Container(
                          color: const Color(0xFF0EA5E9),
                          child: Center(
                            child: Text(
                              'Flex $_flex2\n(${(_flex2 / totalFlex * 100).toStringAsFixed(0)}%)',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: _flex3,
                        child: Container(
                          color: const Color(0xFF10B981),
                          child: Center(
                            child: Text(
                              'Flex $_flex3\n(${(_flex3 / totalFlex * 100).toStringAsFixed(0)}%)',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Controls
                Row(
                  children: [
                    const SizedBox(width: 80, child: Text('Child 1 Flex: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(
                      child: Slider(
                        value: _flex1.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: '$_flex1',
                        onChanged: (val) => setState(() => _flex1 = val.round()),
                      ),
                    ),
                    Text('$_flex1', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 80, child: Text('Child 2 Flex: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(
                      child: Slider(
                        value: _flex2.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: '$_flex2',
                        onChanged: (val) => setState(() => _flex2 = val.round()),
                      ),
                    ),
                    Text('$_flex2', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 80, child: Text('Child 3 Flex: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                    Expanded(
                      child: Slider(
                        value: _flex3.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: '$_flex3',
                        onChanged: (val) => setState(() => _flex3 = val.round()),
                      ),
                    ),
                    Text('$_flex3', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          // 2. Expanded vs Flexible (Tight vs Loose)
          SectionHeader(
            title: 'Expanded vs Flexible (Fit Differences)',
            subtitle: 'Expanded forces full stretch (tight), while Flexible allows natural shrink (loose)',
            badge: 'DEEP DIVE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Expanded vs Flexible',
                code: '''// Expanded is identical to:
Flexible(
  fit: FlexFit.tight, // Forces child to fill the space
  child: ...
);

// Flexible default:
Flexible(
  fit: FlexFit.loose, // Child can be smaller than max space
  child: ...
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('FlexFit.tight (Expanded)')),
                    ButtonSegment(value: false, label: Text('FlexFit.loose (Flexible)')),
                  ],
                  selected: {_isTight},
                  onSelectionChanged: (val) => setState(() => _isTight = val.first),
                ),
                const SizedBox(height: 14),
                Container(
                  height: 54,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        color: Colors.amber.shade700,
                        child: const Center(
                          child: Text('Fixed 70px', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        fit: _isTight ? FlexFit.tight : FlexFit.loose,
                        child: Container(
                          color: theme.colorScheme.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Text(
                              _isTight ? 'Tight: forced to fill remainder' : 'Loose: natural content size',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isTight
                      ? 'Notice: Child is stretched to fill the full remaining width.'
                      : 'Notice: Child only occupies as much width as its text requires.',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white60 : Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // 3. Spacer Demonstration
          SectionHeader(
            title: 'Spacer Widget',
            subtitle: 'Creates an adjustable, empty space between widgets in a Row or Column',
            badge: 'CLEAN CODE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Spacer Usage',
                code: '''Row(
  children: [
    Text('Brand Logo'),
    Spacer(), // Pushes action to the far right!
    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.blur_on_rounded, size: 20, color: theme.colorScheme.primary),
                      ),
                      const SizedBox(width: 8),
                      const Text('Item Left', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Spacer(flex: _spacerFlex),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withAlpha(40),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Spacer($_spacerFlex)',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                        ),
                      ),
                      const Spacer(),
                      FilledButton.tonal(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text('Action Right', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Spacer Flex Factor: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    Expanded(
                      child: Slider(
                        value: _spacerFlex.toDouble(),
                        min: 1,
                        max: 4,
                        divisions: 3,
                        label: '$_spacerFlex',
                        onChanged: (val) => setState(() => _spacerFlex = val.round()),
                      ),
                    ),
                    Text('$_spacerFlex', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
