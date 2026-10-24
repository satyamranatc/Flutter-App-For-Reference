import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class SidebarScreen extends StatefulWidget {
  const SidebarScreen({super.key});

  @override
  State<SidebarScreen> createState() => _SidebarScreenState();
}

class _SidebarScreenState extends State<SidebarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _railIndex = 0;
  bool _isRailExtended = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Side Bar & Drawer Showcase'),
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          tooltip: 'Open Drawer',
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            tooltip: 'Open End Drawer',
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      // Left Drawer ("die bar")
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Flutter Developer', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text('flutter.dev@example.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person_rounded, size: 36, color: Color(0xFF4F46E5)),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                      : [const Color(0xFF4F46E5), const Color(0xFF0EA5E9)],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_rounded),
              title: const Text('Workspace Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.analytics_rounded),
              title: const Text('Performance Metrics'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(40),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('PRO', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_rounded),
              title: const Text('Cloud Storage'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline_rounded),
              title: const Text('Help & Documentation'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      // Right End Drawer (Side filter sheet)
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Filter Sheet (EndDrawer)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 12),
                const Text('Category Filters', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(label: const Text('Buttons'), selected: true, onSelected: (_) {}),
                    FilterChip(label: const Text('Layouts'), selected: false, onSelected: (_) {}),
                    FilterChip(label: const Text('Flex'), selected: true, onSelected: (_) {}),
                    FilterChip(label: const Text('Images'), selected: false, onSelected: (_) {}),
                  ],
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Center(child: Text('Apply Filters')),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. Drawer triggers
          SectionHeader(
            title: 'Drawer ("die bar" / Side Menu)',
            subtitle: 'Standard sliding panel from the left or right edge of the screen',
            badge: 'NAVIGATION',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Drawer & EndDrawer Code',
                code: '''Scaffold(
  drawer: Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(...),
        ListTile(leading: Icon(Icons.home), title: Text('Home')),
      ],
    ),
  ),
  endDrawer: Drawer(...), // Opens from right
);''',
              );
            },
          ),
          ShowcaseCard(
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.menu_rounded),
                    label: const Text('Open Left Drawer'),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.filter_list_rounded),
                    label: const Text('Open End Drawer'),
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  ),
                ),
              ],
            ),
          ),

          // 2. NavigationRail (Desktop/Tablet sidebar)
          SectionHeader(
            title: 'NavigationRail (Tablet / Desktop Side Bar)',
            subtitle: 'Side navigation rail ideal for larger screens with collapsed & extended states',
            badge: 'RESPONSIVE',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'NavigationRail Code',
                code: '''NavigationRail(
  selectedIndex: _railIndex,
  extended: $_isRailExtended,
  onDestinationSelected: (val) => setState(() => _railIndex = val),
  destinations: const [
    NavigationRailDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: Text('Home'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.star_outline),
      selectedIcon: Icon(Icons.star),
      label: Text('Favorites'),
    ),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Live NavigationRail Preview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      FilterChip(
                        label: Text(_isRailExtended ? 'Collapse Rail' : 'Extend Rail'),
                        selected: _isRailExtended,
                        onSelected: (val) => setState(() => _isRailExtended = val),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 240,
                  child: Row(
                    children: [
                      NavigationRail(
                        selectedIndex: _railIndex,
                        extended: _isRailExtended,
                        minExtendedWidth: 160,
                        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                        onDestinationSelected: (val) => setState(() => _railIndex = val),
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.dashboard_outlined),
                            selectedIcon: Icon(Icons.dashboard_rounded),
                            label: Text('Overview'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.layers_outlined),
                            selectedIcon: Icon(Icons.layers_rounded),
                            label: Text('Components'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.settings_outlined),
                            selectedIcon: Icon(Icons.settings_rounded),
                            label: Text('Settings'),
                          ),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                [
                                  Icons.dashboard_rounded,
                                  Icons.layers_rounded,
                                  Icons.settings_rounded
                                ][_railIndex],
                                size: 36,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Selected: ${['Overview', 'Components', 'Settings'][_railIndex]}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
