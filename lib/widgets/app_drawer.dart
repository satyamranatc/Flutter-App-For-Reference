import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.themeModeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.widgets_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Widget Studio',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'Flutter Premium UI Showcase',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.white60 : Colors.black54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: [
                  _buildNavTile(
                    context,
                    index: 0,
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard_rounded,
                    title: 'Catalog Home',
                    subtitle: 'Overview of all widgets',
                  ),
                  _buildNavTile(
                    context,
                    index: 1,
                    icon: Icons.smart_button_outlined,
                    activeIcon: Icons.smart_button_rounded,
                    title: 'Buttons',
                    subtitle: 'Elevated, Filled, Tonal, FAB',
                  ),
                  _buildNavTile(
                    context,
                    index: 2,
                    icon: Icons.view_quilt_outlined,
                    activeIcon: Icons.view_quilt_rounded,
                    title: 'Layouts',
                    subtitle: 'Row, Column, Stack, Wrap',
                  ),
                  _buildNavTile(
                    context,
                    index: 3,
                    icon: Icons.compare_arrows_rounded,
                    activeIcon: Icons.compare_arrows_rounded,
                    title: 'Flex & Spacing',
                    subtitle: 'Expanded, Flexible, Spacer',
                  ),
                  _buildNavTile(
                    context,
                    index: 4,
                    icon: Icons.image_outlined,
                    activeIcon: Icons.image_rounded,
                    title: 'Images & Media',
                    subtitle: 'BoxFit, Clips, Icons, Glass',
                  ),
                  _buildNavTile(
                    context,
                    index: 5,
                    icon: Icons.format_list_bulleted_rounded,
                    activeIcon: Icons.format_list_bulleted_rounded,
                    title: 'Lists',
                    subtitle: 'ListView, Dismissible, Reorder',
                  ),
                  _buildNavTile(
                    context,
                    index: 6,
                    icon: Icons.grid_view_rounded,
                    activeIcon: Icons.grid_view_rounded,
                    title: 'Grid',
                    subtitle: 'GridView count & builder',
                  ),
                  _buildNavTile(
                    context,
                    index: 7,
                    icon: Icons.web_rounded,
                    activeIcon: Icons.web_rounded,
                    title: 'App Bar',
                    subtitle: 'SliverAppBar, tabs, actions',
                  ),
                  _buildNavTile(
                    context,
                    index: 8,
                    icon: Icons.dock_rounded,
                    activeIcon: Icons.dock_rounded,
                    title: 'Side Bar (Drawer)',
                    subtitle: 'NavigationRail & Drawers',
                  ),
                  _buildNavTile(
                    context,
                    index: 9,
                    icon: Icons.navigation_outlined,
                    activeIcon: Icons.navigation_rounded,
                    title: 'Bottom Bar',
                    subtitle: 'NavigationBar & BottomAppBar',
                  ),
                ],
              ),
            ),

            const Divider(),

            // Theme Switcher & Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: ValueListenableBuilder<ThemeMode>(
                valueListenable: themeModeNotifier,
                builder: (context, currentMode, _) {
                  final isCurrentlyDark = currentMode == ThemeMode.dark ||
                      (currentMode == ThemeMode.system && isDark);

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCurrentlyDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              isCurrentlyDark ? 'Dark Mode' : 'Light Mode',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: isCurrentlyDark,
                          onChanged: (val) {
                            themeModeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTile(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final isSelected = selectedIndex == index;
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withAlpha(128)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? theme.colorScheme.primary : (isDark ? Colors.white70 : Colors.black87),
            size: 20,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? theme.colorScheme.primary : (isDark ? Colors.white : Colors.black87),
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ),
          onTap: () {
            Navigator.pop(context); // Close drawer
            onDestinationSelected(index);
          },
        ),
      ),
    );
  }
}
