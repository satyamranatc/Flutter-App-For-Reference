import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  bool _switchVal = true;
  int _selectedTileIndex = 0;

  // Dismissible items
  final List<String> _dismissibleItems = [
    'Design review with mobile team',
    'Deploy Flutter production build',
    'Update API authentication tokens',
    'Refactor state management provider',
  ];

  // Reorderable items
  final List<String> _reorderableItems = [
    '1. Architecture Planning',
    '2. Design System Tokens',
    '3. Component Library',
    '4. Screen Assemblies',
    '5. Quality Assurance & Testing',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. Horizontal Scrolling List
          SectionHeader(
            title: 'Horizontal Scrolling List',
            subtitle: 'Story circles and horizontal category feeds with ListView.builder',
            badge: 'HORIZONTAL',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Horizontal ListView Code',
                code: '''SizedBox(
  height: 90,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 10,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(...),
      );
    },
  ),
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: SizedBox(
              height: 84,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  final colors = [
                    const Color(0xFF4F46E5),
                    const Color(0xFF0EA5E9),
                    const Color(0xFF10B981),
                    const Color(0xFFF59E0B),
                    const Color(0xFF8B5CF6),
                    const Color(0xFFEC4899),
                    const Color(0xFF14B8A6),
                    const Color(0xFF6366F1),
                  ];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: colors[index % colors.length], width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: colors[index % colors.length].withAlpha(40),
                            child: Icon(
                              Icons.category_rounded,
                              size: 20,
                              color: colors[index % colors.length],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Topic ${index + 1}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // 2. ListTile Anatomy
          SectionHeader(
            title: 'ListTile Anatomy & States',
            subtitle: 'Standardized item with leading icon, title, subtitle, and trailing action',
            badge: 'LIST TILE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'ListTile Structure',
                code: '''ListTile(
  leading: Icon(Icons.notifications),
  title: Text('Push Notifications'),
  subtitle: Text('Receive alerts for new updates'),
  trailing: Switch(value: true, onChanged: (v) {}),
  onTap: () {},
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.notifications_active_rounded, color: theme.colorScheme.primary, size: 20),
                  ),
                  title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Instant updates on critical tasks', style: TextStyle(fontSize: 12)),
                  trailing: Switch(
                    value: _switchVal,
                    onChanged: (val) => setState(() => _switchVal = val),
                  ),
                ),
                const Divider(),
                ListTile(
                  selected: _selectedTileIndex == 1,
                  selectedTileColor: theme.colorScheme.primaryContainer.withAlpha(80),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.security_rounded, color: Color(0xFF10B981), size: 20),
                  ),
                  title: const Text('Two-Factor Authentication', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Tap to toggle selected highlight', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.chevron_right_rounded, size: 20),
                  onTap: () => setState(() => _selectedTileIndex = _selectedTileIndex == 1 ? 0 : 1),
                ),
                const Divider(),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0EA5E9).withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.cloud_sync_rounded, color: Color(0xFF0EA5E9), size: 20),
                  ),
                  title: const Text('Cloud Synchronization', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Last synced 2 minutes ago', style: TextStyle(fontSize: 12)),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withAlpha(30),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('SYNCED', style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          // 3. ExpansionTile (Accordion)
          SectionHeader(
            title: 'ExpansionTile (Accordion)',
            subtitle: 'Smooth collapsible panels for FAQ and nested information',
            badge: 'COLLAPSIBLE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'ExpansionTile Code',
                code: '''ExpansionTile(
  leading: Icon(Icons.help_outline),
  title: Text('Frequently Asked Question'),
  children: [
    Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Detailed answer content goes here...'),
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
              child: ExpansionTile(
                shape: const Border(),
                collapsedShape: const Border(),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.psychology_rounded, color: Color(0xFF8B5CF6), size: 20),
                ),
                title: const Text('How does Flutter render widgets?', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                subtitle: const Text('Tap to expand deep dive', style: TextStyle(fontSize: 11)),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'Flutter builds an Element Tree from your Widget blueprints, and creates RenderObjects that handle layout constraints and paint directly to the Skia or Impeller graphics engine at 60 or 120 FPS.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Dismissible (Swipe to Delete / Action)
          SectionHeader(
            title: 'Dismissible (Swipe Actions)',
            subtitle: 'Swipe horizontally to delete or archive items with animated dismiss',
            badge: 'GESTURES',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Dismissible Swipe Code',
                code: '''Dismissible(
  key: Key(item),
  background: Container(
    color: Colors.red,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 20),
    child: Icon(Icons.delete, color: Colors.white),
  ),
  onDismissed: (direction) {
    // Remove item and notify
  },
  child: ListTile(...),
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: EdgeInsets.zero,
            child: _dismissibleItems.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.done_all_rounded, size: 36, color: Color(0xFF10B981)),
                          const SizedBox(height: 8),
                          const Text('All items dismissed!', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          FilledButton.tonal(
                            onPressed: () {
                              setState(() {
                                _dismissibleItems.addAll([
                                  'Design review with mobile team',
                                  'Deploy Flutter production build',
                                  'Update API authentication tokens',
                                ]);
                              });
                            },
                            child: const Text('Reset Items'),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: _dismissibleItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;

                      return Column(
                        children: [
                          Dismissible(
                            key: Key(item),
                            background: Container(
                              color: Colors.red.shade600,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Row(
                                children: [
                                  Icon(Icons.delete_outline_rounded, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              color: const Color(0xFF10B981),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Archive', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 8),
                                  Icon(Icons.archive_outlined, color: Colors.white),
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              final removed = _dismissibleItems.removeAt(index);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Removed "$removed"'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      setState(() => _dismissibleItems.insert(index, removed));
                                    },
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: const Icon(Icons.swipe_rounded, size: 20, color: Colors.grey),
                              title: Text(item, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                              subtitle: const Text('Swipe left or right', style: TextStyle(fontSize: 11, color: Colors.grey)),
                            ),
                          ),
                          if (index < _dismissibleItems.length - 1) const Divider(),
                        ],
                      );
                    }).toList(),
                  ),
          ),

          // 5. ReorderableListView (Drag & Drop)
          SectionHeader(
            title: 'ReorderableListView (Drag & Drop)',
            subtitle: 'Grab any item handle to reorder list items interactively',
            badge: 'DRAG & DROP',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'ReorderableListView Code',
                code: '''ReorderableListView(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  onReorder: (oldIndex, newIndex) {
    setState(() {
      if (oldIndex < newIndex) newIndex -= 1;
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  },
  children: items.map(...).toList(),
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorderItem: (oldIndex, newIndex) {
                setState(() {
                  final item = _reorderableItems.removeAt(oldIndex);
                  _reorderableItems.insert(newIndex, item);
                });
              },
              children: [
                for (int i = 0; i < _reorderableItems.length; i++)
                  ListTile(
                    key: Key('reorder_${_reorderableItems[i]}'),
                    dense: true,
                    leading: Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Text('${i + 1}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                    ),
                    title: Text(_reorderableItems[i], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.drag_indicator_rounded, size: 20, color: Colors.grey),
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
