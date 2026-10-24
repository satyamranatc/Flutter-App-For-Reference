import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _m3Index = 0;
  int _classicIndex = 0;
  int _dockedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Showcase'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // 1. Material 3 NavigationBar
          SectionHeader(
            title: 'Material 3 NavigationBar (Modern Standard)',
            subtitle: 'Includes animated pill indicator, subtle container tint, and badge integration',
            badge: 'MATERIAL 3',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'Material 3 NavigationBar Code',
                code: '''NavigationBar(
  selectedIndex: _index,
  onDestinationSelected: (idx) => setState(() => _index = idx),
  destinations: const [
    NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
    NavigationDestination(
      icon: Badge(label: Text('3'), child: Icon(Icons.notifications_outlined)),
      label: 'Alerts',
    ),
    NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    child: Center(
                      child: Text(
                        'Active Tab: ${['Home', 'Explore', 'Notifications', 'Profile'][_m3Index]}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                  NavigationBar(
                    selectedIndex: _m3Index,
                    onDestinationSelected: (val) => setState(() => _m3Index = val),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home_rounded),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.explore_outlined),
                        selectedIcon: Icon(Icons.explore_rounded),
                        label: 'Explore',
                      ),
                      NavigationDestination(
                        icon: Badge(
                          label: Text('4'),
                          child: Icon(Icons.notifications_outlined),
                        ),
                        selectedIcon: Badge(
                          label: Text('4'),
                          child: Icon(Icons.notifications_rounded),
                        ),
                        label: 'Alerts',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person_rounded),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 2. Classic BottomNavigationBar (M2)
          SectionHeader(
            title: 'Classic BottomNavigationBar (Fixed / Shifting)',
            subtitle: 'The legacy Flutter bottom navigation with item labels and icon tinting',
            badge: 'CLASSIC',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'BottomNavigationBar Code',
                code: '''BottomNavigationBar(
  currentIndex: _index,
  type: BottomNavigationBarType.fixed,
  onTap: (idx) => setState(() => _index = idx),
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chats'),
    BottomNavigationBarItem(icon: Icon(Icons.call_outlined), label: 'Calls'),
    BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
  ],
);''',
              );
            },
          ),
          ShowcaseCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    child: Center(
                      child: Text(
                        'Active Tab: ${['Chats', 'Calls', 'Settings'][_classicIndex]}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                  BottomNavigationBar(
                    currentIndex: _classicIndex,
                    onTap: (val) => setState(() => _classicIndex = val),
                    selectedItemColor: theme.colorScheme.primary,
                    unselectedItemColor: isDark ? Colors.white54 : Colors.black45,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.chat_bubble_outline_rounded),
                        activeIcon: Icon(Icons.chat_bubble_rounded),
                        label: 'Chats',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.call_outlined),
                        activeIcon: Icon(Icons.call_rounded),
                        label: 'Calls',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings_outlined),
                        activeIcon: Icon(Icons.settings_rounded),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 3. BottomAppBar with Docked FAB
          SectionHeader(
            title: 'BottomAppBar with Docked FAB',
            subtitle: 'Cradle cutout docking a FloatingActionButton in the center or end',
            badge: 'DOCKED FAB',
            onCodeTap: () {
              showCodeModal(
                context,
                title: 'BottomAppBar with Docked FAB',
                code: '''Scaffold(
  floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () {},
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  bottomNavigationBar: BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 6.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
      ],
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
              child: Column(
                children: [
                  Container(
                    height: 90,
                    color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    child: const Center(
                      child: Text(
                        'Docked Floating Action Bar',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home_rounded),
                          onPressed: () => setState(() => _dockedIndex = 0),
                          color: _dockedIndex == 0 ? theme.colorScheme.primary : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.search_rounded),
                          onPressed: () => setState(() => _dockedIndex = 1),
                          color: _dockedIndex == 1 ? theme.colorScheme.primary : null,
                        ),
                        // Center Elevated Action Button
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withAlpha(100),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.add_rounded, color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_outline_rounded),
                          onPressed: () => setState(() => _dockedIndex = 2),
                          color: _dockedIndex == 2 ? theme.colorScheme.primary : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_horiz_rounded),
                          onPressed: () => setState(() => _dockedIndex = 3),
                          color: _dockedIndex == 3 ? theme.colorScheme.primary : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
