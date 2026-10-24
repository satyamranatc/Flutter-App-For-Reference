import 'package:flutter/material.dart';
import '../models/widget_item.dart';
import 'buttons_screen.dart';
import 'layouts_screen.dart';
import 'flex_screen.dart';
import 'images_screen.dart';
import 'lists_screen.dart';
import 'grid_screen.dart';
import 'app_bar_screen.dart';
import 'sidebar_screen.dart';
import 'bottom_bar_screen.dart';

class HomeCatalogScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigateTab;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const HomeCatalogScreen({
    super.key,
    this.onNavigateTab,
    required this.themeModeNotifier,
  });

  @override
  State<HomeCatalogScreen> createState() => _HomeCatalogScreenState();
}

class _HomeCatalogScreenState extends State<HomeCatalogScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<WidgetCategory> _categories = [
    const WidgetCategory(
      id: 'buttons',
      title: 'Buttons & Triggers',
      description: 'Elevated, Filled, Tonal, Outlined, FAB & SegmentedButtons',
      icon: Icons.smart_button_rounded,
      accentColor: Color(0xFF4F46E5),
      widgetCount: 8,
      screen: ButtonsScreen(),
    ),
    const WidgetCategory(
      id: 'layouts',
      title: 'Layouts & Containers',
      description: 'Row, Column, Stack, Positioned, Wrap, Cards & Alignment',
      icon: Icons.view_quilt_rounded,
      accentColor: Color(0xFF0EA5E9),
      widgetCount: 7,
      screen: LayoutsScreen(),
    ),
    const WidgetCategory(
      id: 'flex',
      title: 'Flex, Expanded & Spacers',
      description: 'Expanded proportions, Flexible tight vs loose, and Spacer',
      icon: Icons.compare_arrows_rounded,
      accentColor: Color(0xFF10B981),
      widgetCount: 4,
      screen: FlexScreen(),
    ),
    const WidgetCategory(
      id: 'images',
      title: 'Images & Media Effects',
      description: 'Network images, BoxFit modes, ClipRRect, Blur & Hero cards',
      icon: Icons.image_rounded,
      accentColor: Color(0xFF8B5CF6),
      widgetCount: 6,
      screen: ImagesScreen(),
    ),
    const WidgetCategory(
      id: 'lists',
      title: 'Lists & Scrolling',
      description: 'ListView, ListTile, ExpansionTile, Dismissible & Reorderable',
      icon: Icons.format_list_bulleted_rounded,
      accentColor: Color(0xFFF59E0B),
      widgetCount: 5,
      screen: ListsScreen(),
    ),
    const WidgetCategory(
      id: 'grid',
      title: 'Grids & Collections',
      description: 'GridView builder & count with interactive columns & aspect ratio',
      icon: Icons.grid_view_rounded,
      accentColor: Color(0xFFEC4899),
      widgetCount: 3,
      screen: GridScreen(),
    ),
    const WidgetCategory(
      id: 'app_bar',
      title: 'App Bar & Slivers',
      description: 'SliverAppBar collapsing header, TabBar, search bar & actions',
      icon: Icons.web_rounded,
      accentColor: Color(0xFF06B6D4),
      widgetCount: 4,
      screen: AppBarScreen(),
    ),
    const WidgetCategory(
      id: 'sidebar',
      title: 'Side Bar & Drawer',
      description: 'Drawer ("die bar"), EndDrawer filters & NavigationRail',
      icon: Icons.dock_rounded,
      accentColor: Color(0xFF6366F1),
      widgetCount: 3,
      screen: SidebarScreen(),
    ),
    const WidgetCategory(
      id: 'bottom_bar',
      title: 'Bottom Navigation Bars',
      description: 'Material 3 NavigationBar, Classic M2 bar & Docked FAB Bar',
      icon: Icons.navigation_rounded,
      accentColor: Color(0xFF14B8A6),
      widgetCount: 3,
      screen: BottomBarScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredList = _categories.where((cat) {
      final matchesQuery = cat.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          cat.description.toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesQuery) return false;

      if (_selectedFilter == 'All') return true;
      if (_selectedFilter == 'Layout' && (cat.id == 'layouts' || cat.id == 'flex' || cat.id == 'grid')) return true;
      if (_selectedFilter == 'Navigation' && (cat.id == 'app_bar' || cat.id == 'sidebar' || cat.id == 'bottom_bar')) return true;
      if (_selectedFilter == 'Controls' && (cat.id == 'buttons' || cat.id == 'lists' || cat.id == 'images')) return true;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Studio'),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: widget.themeModeNotifier,
            builder: (context, mode, _) {
              final isCurrentlyDark = mode == ThemeMode.dark ||
                  (mode == ThemeMode.system && isDark);
              return IconButton(
                tooltip: isCurrentlyDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                icon: Icon(
                  isCurrentlyDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  size: 20,
                ),
                onPressed: () {
                  widget.themeModeNotifier.value =
                      isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Hero Banner
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                    : [const Color(0xFFEEF2FF), const Color(0xFFE0F2FE)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'FLUTTER 3.44 • MATERIAL 3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Widget Showcase Studio',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Interactive exploration of all core Flutter widgets: Buttons, Layouts, Flex, Images, Lists, Grids, App Bars, Drawers & Navigation Bars.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white70 : Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildStatPill('9 Labs', Icons.science_outlined),
                    _buildStatPill('45+ Widgets', Icons.widgets_outlined),
                    _buildStatPill('Live Source Code', Icons.code_rounded),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Search Bar
          TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            decoration: InputDecoration(
              hintText: 'Search widgets (e.g. Button, Grid, Flex, Sliver)...',
              hintStyle: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              filled: true,
              fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: theme.colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: theme.colorScheme.outline),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['All', 'Controls', 'Layout', 'Navigation'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter, style: const TextStyle(fontSize: 12)),
                    selected: isSelected,
                    onSelected: (val) {
                      if (val) setState(() => _selectedFilter = filter);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Catalog List of Cards
          for (int i = 0; i < filteredList.length; i++) ...[
            _buildCategoryCard(context, filteredList[i]),
            const SizedBox(height: 12),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatPill(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(160),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF4F46E5)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, WidgetCategory category) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => category.screen),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: category.accentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  category.icon,
                  color: category.accentColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            category.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: theme.colorScheme.outline),
                          ),
                          child: Text(
                            '${category.widgetCount} widgets',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.black54,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: isDark ? Colors.white30 : Colors.black26,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
