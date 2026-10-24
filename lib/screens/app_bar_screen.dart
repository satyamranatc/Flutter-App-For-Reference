import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/code_preview_dialog.dart';

class AppBarScreen extends StatefulWidget {
  const AppBarScreen({super.key});

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _pinned = true;
  bool _floating = false;
  bool _snap = false;
  final double _elevation = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: _floating,
              pinned: _pinned,
              snap: _snap && _floating,
              elevation: _elevation,
              backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 16, bottom: 58),
                title: const Text(
                  'SliverAppBar Demo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                              : [const Color(0xFF4F46E5), const Color(0xFF06B6D4)],
                        ),
                      ),
                    ),
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Icon(
                        Icons.web_rounded,
                        size: 140,
                        color: Colors.white.withAlpha(20),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.code_rounded, color: Colors.white),
                  tooltip: 'View Code',
                  onPressed: () {
                    showCodeModal(
                      context,
                      title: 'SliverAppBar Configuration',
                      code: '''SliverAppBar(
  expandedHeight: 200.0,
  pinned: $_pinned,
  floating: $_floating,
  snap: $_snap,
  flexibleSpace: FlexibleSpaceBar(
    title: Text('SliverAppBar Demo'),
    background: Image or Gradient,
  ),
  bottom: TabBar(
    tabs: [Tab(text: 'Controls'), Tab(text: 'Variants'), Tab(text: 'Features')],
  ),
);''',
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: isDark ? const Color(0xFF0F172A) : Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: theme.colorScheme.primary,
                    unselectedLabelColor: isDark ? Colors.white60 : Colors.black54,
                    indicatorColor: theme.colorScheme.primary,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: 'Controls'),
                      Tab(text: 'Variants'),
                      Tab(text: 'Overview'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Interactive Controls
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SectionHeader(
                  title: 'Scroll Behavior Controls',
                  subtitle: 'Scroll up/down to see how pinned, floating, and snap alter the header',
                  badge: 'INTERACTIVE',
                ),
                ShowcaseCard(
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Pinned (Header sticks at top)'),
                        subtitle: const Text('Keeps app bar visible after scrolling past'),
                        value: _pinned,
                        onChanged: (val) => setState(() => _pinned = val),
                      ),
                      const Divider(),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Floating (Reveals on reverse scroll)'),
                        subtitle: const Text('App bar slides down immediately when scrolling up'),
                        value: _floating,
                        onChanged: (val) => setState(() {
                          _floating = val;
                          if (!val) _snap = false;
                        }),
                      ),
                      const Divider(),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Snap (Snaps open automatically)'),
                        subtitle: const Text('Requires Floating to be active'),
                        value: _snap,
                        onChanged: _floating ? (val) => setState(() => _snap = val) : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (int i = 1; i <= 8; i++)
                  Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text('$i', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                      ),
                      title: Text('Scrollable Content Row $i'),
                      subtitle: const Text('Scroll upward to test SliverAppBar collapse'),
                      trailing: const Icon(Icons.arrow_upward_rounded, size: 16, color: Colors.grey),
                    ),
                  ),
              ],
            ),

            // Tab 2: Variants
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SectionHeader(
                  title: 'Standard AppBar Styles',
                  subtitle: 'Clean Material 3 AppBar with center title, search, and action items',
                  badge: 'M3 STYLES',
                ),
                ShowcaseCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      AppBar(
                        automaticallyImplyLeading: false,
                        title: const Text('Simple M3 AppBar', style: TextStyle(fontSize: 15)),
                        actions: [
                          IconButton(icon: const Icon(Icons.bookmark_outline_rounded), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
                        ],
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SearchBar(
                          hintText: 'Search in app bar...',
                          leading: const Icon(Icons.search_rounded, size: 20),
                          elevation: const WidgetStatePropertyAll(0),
                          backgroundColor: WidgetStatePropertyAll(
                            isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Tab 3: Overview
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SectionHeader(
                  title: 'AppBar Architecture',
                  subtitle: 'Key components forming the top navigation layer',
                  badge: 'COMPONENTS',
                ),
                ShowcaseCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('• leading: Back button, drawer hamburger, or custom logo', style: TextStyle(fontSize: 13, height: 1.6)),
                      Text('• title: Primary screen title or embedded SearchBar', style: TextStyle(fontSize: 13, height: 1.6)),
                      Text('• actions: Contextual buttons on the trailing edge', style: TextStyle(fontSize: 13, height: 1.6)),
                      Text('• flexibleSpace: Background visuals, gradients, or parallax images', style: TextStyle(fontSize: 13, height: 1.6)),
                      Text('• bottom: TabBar or progress indicator', style: TextStyle(fontSize: 13, height: 1.6)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
