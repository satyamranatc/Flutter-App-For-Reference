import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/app_drawer.dart';
import 'screens/home_catalog_screen.dart';
import 'screens/buttons_screen.dart';
import 'screens/layouts_screen.dart';
import 'screens/flex_screen.dart';
import 'screens/images_screen.dart';
import 'screens/lists_screen.dart';
import 'screens/grid_screen.dart';
import 'screens/app_bar_screen.dart';
import 'screens/sidebar_screen.dart';
import 'screens/bottom_bar_screen.dart';

void main() {
  runApp(const FlutterWidgetStudioApp());
}

class FlutterWidgetStudioApp extends StatefulWidget {
  const FlutterWidgetStudioApp({super.key});

  @override
  State<FlutterWidgetStudioApp> createState() => _FlutterWidgetStudioAppState();
}

class _FlutterWidgetStudioAppState extends State<FlutterWidgetStudioApp> {
  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(ThemeMode.system);

  @override
  void dispose() {
    _themeModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeModeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Flutter Widget Studio',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          home: RootAppShell(themeModeNotifier: _themeModeNotifier),
        );
      },
    );
  }
}

class RootAppShell extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const RootAppShell({super.key, required this.themeModeNotifier});

  @override
  State<RootAppShell> createState() => _RootAppShellState();
}

class _RootAppShellState extends State<RootAppShell> {
  int _currentTabIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeCatalogScreen(
        themeModeNotifier: widget.themeModeNotifier,
        onNavigateTab: (index) {
          setState(() => _currentTabIndex = index);
        },
      ),
      const ButtonsScreen(),
      const LayoutsScreen(),
      const FlexScreen(),
      const ImagesScreen(),
      const ListsScreen(),
      const GridScreen(),
      const AppBarScreen(),
      const SidebarScreen(),
      const BottomBarScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // If not on Home page (index 0), each dedicated screen has its own rich AppBar.
    // If on Home page, we provide the Drawer and Bottom Navigation Bar for quick jumping.
    return Scaffold(
      drawer: AppDrawer(
        selectedIndex: _currentTabIndex,
        themeModeNotifier: widget.themeModeNotifier,
        onDestinationSelected: (index) {
          setState(() => _currentTabIndex = index);
        },
      ),
      body: IndexedStack(
        index: _currentTabIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTabIndex > 4 ? 4 : _currentTabIndex,
        onDestinationSelected: (idx) {
          if (idx == 4) {
            // "More" pressed -> jump to home catalog or open drawer
            setState(() => _currentTabIndex = 0);
          } else {
            setState(() => _currentTabIndex = idx);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_button_outlined),
            selectedIcon: Icon(Icons.smart_button_rounded),
            label: 'Buttons',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_quilt_outlined),
            selectedIcon: Icon(Icons.view_quilt_rounded),
            label: 'Layouts',
          ),
          NavigationDestination(
            icon: Icon(Icons.format_list_bulleted_rounded),
            selectedIcon: Icon(Icons.format_list_bulleted_rounded),
            label: 'Lists',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'All Labs',
          ),
        ],
      ),
    );
  }
}
