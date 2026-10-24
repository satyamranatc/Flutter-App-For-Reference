import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  int _clickCount = 0;
  bool _isDisabled = false;
  bool _isLoading = false;
  String _selectedView = 'Month';
  final Set<String> _selectedFormats = {'Bold'};
  String _selectedMenuItem = 'Option 1';

  void _onButtonPressed(String name) {
    if (_isDisabled || _isLoading) return;
    setState(() => _clickCount++);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name clicked! Total interactions: $_clickCount'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Showcase'),
        actions: [
          IconButton(
            tooltip: 'Reset counter',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => setState(() => _clickCount = 0),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Control Bar Card
          ShowcaseCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interactive Playground Controls',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Clicks: $_clickCount',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Disable All Buttons'),
                      selected: _isDisabled,
                      onSelected: (val) => setState(() => _isDisabled = val),
                    ),
                    FilterChip(
                      label: const Text('Simulate Loading State'),
                      selected: _isLoading,
                      onSelected: (val) => setState(() => _isLoading = val),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 1. Common Material 3 Buttons
          SectionHeader(
            title: 'Material 3 Core Buttons',
            subtitle: 'Different emphasis levels for actions from primary to subtle',
            badge: 'ESSENTIAL',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Material 3 Buttons Code',
                code: '''// Primary High-Emphasis Button
FilledButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.rocket_launch_rounded),
  label: const Text('Primary Filled'),
);

// Secondary Medium-Emphasis Button
FilledButton.tonal(
  onPressed: () {},
  child: const Text('Tonal Button'),
);

// Elevated Button with shadow
ElevatedButton(
  onPressed: () {},
  child: const Text('Elevated Button'),
);

// Border Outline Button
OutlinedButton(
  onPressed: () {},
  child: const Text('Outlined Button'),
);

// Low-emphasis Text Button
TextButton(
  onPressed: () {},
  child: const Text('Text Button'),
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              children: [
                FilledButton.icon(
                  onPressed: _isDisabled
                      ? null
                      : () => _onButtonPressed('FilledButton (Primary)'),
                  icon: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.rocket_launch_rounded, size: 18),
                  label: Text(_isLoading ? 'Loading...' : 'FilledButton'),
                ),
                FilledButton.tonal(
                  onPressed: _isDisabled
                      ? null
                      : () => _onButtonPressed('FilledButton.tonal'),
                  child: const Text('Tonal Button'),
                ),
                ElevatedButton.icon(
                  onPressed: _isDisabled
                      ? null
                      : () => _onButtonPressed('ElevatedButton'),
                  icon: const Icon(Icons.star_rounded, size: 18),
                  label: const Text('ElevatedButton'),
                ),
                OutlinedButton(
                  onPressed: _isDisabled
                      ? null
                      : () => _onButtonPressed('OutlinedButton'),
                  child: const Text('OutlinedButton'),
                ),
                TextButton.icon(
                  onPressed: _isDisabled
                      ? null
                      : () => _onButtonPressed('TextButton'),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: const Text('TextButton'),
                ),
              ],
            ),
          ),

          // 2. Icon Buttons
          SectionHeader(
            title: 'Icon Buttons Collection',
            subtitle: 'Standard, Filled, Tonal, and Outlined variants for toolbars',
            badge: 'M3 ICONS',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'IconButton Variants',
                code: '''IconButton(
  icon: const Icon(Icons.favorite_border),
  onPressed: () {},
);

IconButton.filled(
  icon: const Icon(Icons.send_rounded),
  onPressed: () {},
);

IconButton.filledTonal(
  icon: const Icon(Icons.bookmark_rounded),
  onPressed: () {},
);

IconButton.outlined(
  icon: const Icon(Icons.share_rounded),
  onPressed: () {},
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      tooltip: 'Standard IconButton',
                      icon: const Icon(Icons.favorite_rounded),
                      onPressed: _isDisabled ? null : () => _onButtonPressed('Standard IconButton'),
                    ),
                    const SizedBox(height: 4),
                    const Text('Standard', style: TextStyle(fontSize: 11)),
                  ],
                ),
                Column(
                  children: [
                    IconButton.filled(
                      tooltip: 'Filled IconButton',
                      icon: const Icon(Icons.send_rounded),
                      onPressed: _isDisabled ? null : () => _onButtonPressed('Filled IconButton'),
                    ),
                    const SizedBox(height: 4),
                    const Text('Filled', style: TextStyle(fontSize: 11)),
                  ],
                ),
                Column(
                  children: [
                    IconButton.filledTonal(
                      tooltip: 'Tonal IconButton',
                      icon: const Icon(Icons.bookmark_rounded),
                      onPressed: _isDisabled ? null : () => _onButtonPressed('Tonal IconButton'),
                    ),
                    const SizedBox(height: 4),
                    const Text('Tonal', style: TextStyle(fontSize: 11)),
                  ],
                ),
                Column(
                  children: [
                    IconButton.outlined(
                      tooltip: 'Outlined IconButton',
                      icon: const Icon(Icons.share_rounded),
                      onPressed: _isDisabled ? null : () => _onButtonPressed('Outlined IconButton'),
                    ),
                    const SizedBox(height: 4),
                    const Text('Outlined', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),

          // 3. Floating Action Buttons (FAB)
          SectionHeader(
            title: 'Floating Action Buttons (FAB)',
            subtitle: 'Primary promotional actions in mini, standard, and extended forms',
            badge: 'PROMINENT',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Floating Action Buttons Code',
                code: '''// Small FAB
FloatingActionButton.small(
  onPressed: () {},
  child: const Icon(Icons.add),
);

// Standard FAB
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.edit),
);

// Extended FAB
FloatingActionButton.extended(
  onPressed: () {},
  icon: const Icon(Icons.add_task),
  label: const Text('New Task'),
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'fab_small',
                      onPressed: _isDisabled ? null : () => _onButtonPressed('Small FAB'),
                      child: const Icon(Icons.add_rounded),
                    ),
                    const SizedBox(height: 6),
                    const Text('Small FAB', style: TextStyle(fontSize: 11)),
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'fab_regular',
                      onPressed: _isDisabled ? null : () => _onButtonPressed('Standard FAB'),
                      child: const Icon(Icons.edit_rounded),
                    ),
                    const SizedBox(height: 6),
                    const Text('Standard FAB', style: TextStyle(fontSize: 11)),
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton.extended(
                      heroTag: 'fab_extended',
                      onPressed: _isDisabled ? null : () => _onButtonPressed('Extended FAB'),
                      icon: const Icon(Icons.add_task_rounded),
                      label: const Text('Create'),
                    ),
                    const SizedBox(height: 6),
                    const Text('Extended FAB', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),

          // 4. Segmented Buttons
          SectionHeader(
            title: 'Segmented Buttons (Material 3)',
            subtitle: 'Single-select and multi-select toggles replacing legacy ToggleButtons',
            badge: 'MODERN',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'SegmentedButton Code',
                code: '''SegmentedButton<String>(
  segments: const [
    ButtonSegment(value: 'Day', label: Text('Day')),
    ButtonSegment(value: 'Week', label: Text('Week')),
    ButtonSegment(value: 'Month', label: Text('Month')),
  ],
  selected: {'Month'},
  onSelectionChanged: (newSelection) {},
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Single Selection:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Day', label: Text('Day')),
                    ButtonSegment(value: 'Week', label: Text('Week')),
                    ButtonSegment(value: 'Month', label: Text('Month')),
                    ButtonSegment(value: 'Year', label: Text('Year')),
                  ],
                  selected: {_selectedView},
                  onSelectionChanged: _isDisabled
                      ? null
                      : (newSet) => setState(() => _selectedView = newSet.first),
                ),
                const SizedBox(height: 16),
                const Text('Multi Selection:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  multiSelectionEnabled: true,
                  segments: const [
                    ButtonSegment(value: 'Bold', icon: Icon(Icons.format_bold_rounded)),
                    ButtonSegment(value: 'Italic', icon: Icon(Icons.format_italic_rounded)),
                    ButtonSegment(value: 'Underline', icon: Icon(Icons.format_underlined_rounded)),
                  ],
                  selected: _selectedFormats,
                  onSelectionChanged: _isDisabled
                      ? null
                      : (newSet) => setState(() => _selectedFormats
                        ..clear()
                        ..addAll(newSet)),
                ),
              ],
            ),
          ),

          // 5. Cupertino & Popup Menus
          SectionHeader(
            title: 'Cupertino & Context Menus',
            subtitle: 'Apple-styled buttons and contextual popup options',
            badge: 'EXPANDED',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Cupertino & PopupMenuButton',
                code: '''CupertinoButton.filled(
  onPressed: () {},
  child: const Text('Cupertino Filled'),
);

PopupMenuButton<String>(
  onSelected: (val) {},
  itemBuilder: (context) => [
    const PopupMenuItem(value: 'Edit', child: Text('Edit')),
    const PopupMenuItem(value: 'Delete', child: Text('Delete')),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  onPressed: _isDisabled ? null : () => _onButtonPressed('CupertinoButton'),
                  child: const Text('Cupertino Button', style: TextStyle(fontSize: 13)),
                ),
                PopupMenuButton<String>(
                  onSelected: (val) {
                    setState(() => _selectedMenuItem = val);
                    _onButtonPressed('Selected: $val');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Menu: $_selectedMenuItem', style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_drop_down_rounded, size: 20),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Option 1',
                      child: Row(
                        children: [
                          Icon(Icons.edit_rounded, size: 18),
                          SizedBox(width: 8),
                          Text('Edit Item'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Option 2',
                      child: Row(
                        children: [
                          Icon(Icons.copy_rounded, size: 18),
                          SizedBox(width: 8),
                          Text('Duplicate'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: 'Delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline_rounded, color: Colors.red, size: 18),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
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
