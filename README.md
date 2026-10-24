# Flutter Widget Studio (Material 3 Showcase)

A modern, Apple/Linear-inspired showcase application built with **Flutter 3.44+** and **Material 3**, exhibiting all essential Flutter UI primitives, layout structures, and navigation patterns across interactive labs.

---

## 📱 Featured Widget Showcases & Labs

| Section | Widgets Covered | Interactive Features |
| :--- | :--- | :--- |
| **Buttons & Triggers** | `ElevatedButton`, `FilledButton`, `FilledButton.tonal`, `OutlinedButton`, `TextButton`, `IconButton` (4 variants), `FloatingActionButton` (Small, Regular, Extended), `SegmentedButton`, `CupertinoButton`, `PopupMenuButton` | Live click counter, Disable-all switch, Loading state spinner, and Flutter code inspector |
| **Layouts & Containers** | `Container`, `BoxDecoration`, `Row`, `Column`, `Stack`, `Positioned`, `Wrap`, `Card` (Elevated, Filled, Outlined), `AspectRatio`, `Center`, `Padding` | Dynamic border radius slider, border stroke slider, gradient toggle, and MainAxis/CrossAxis alignment switcher |
| **Flex & Spacing** | `Flex`, `Expanded`, `Flexible`, `Spacer` | Proportional Flex factor sliders ($1:1:1$ to $5:5:5$), `FlexFit.tight` vs `FlexFit.loose` comparison, adjustable spacer flex |
| **Images & Media** | `Image.network`, `BoxFit` (6 modes), `ClipRRect`, `ClipOval`, `CircleAvatar`, `BackdropFilter` (Frosted Glass), Material & Cupertino Icons | Live `BoxFit` mode switcher, corner radius slider, frosted glass blur sigma slider |
| **Lists & Scrolling** | `ListView.builder`, `ListView.separated`, `ListTile` anatomy, `ExpansionTile` (accordion), `Dismissible` (swipe delete & archive), `ReorderableListView` | Interactive swipe-to-delete with undo SnackBar, drag-and-drop handle reordering, horizontal story feed |
| **Grids & Collections** | `GridView.builder`, `GridView.count`, `SliverGridDelegateWithFixedCrossAxisCount` | Live column count selector (2, 3, 4 cols), axis spacing slider, child aspect ratio slider, favorite toggle |
| **App Bar & Slivers** | `AppBar`, `SliverAppBar`, `FlexibleSpaceBar`, `TabBar`, `TabBarView`, embedded `SearchBar` | Interactive scroll testing with `pinned`, `floating`, and `snap` toggles, tabbed content switching |
| **Side Bar ("die bar")** | `Drawer`, `EndDrawer` (filter sheet), `UserAccountsDrawerHeader`, `NavigationRail` | Left drawer with user account header, right drawer filter panel, collapsible desktop NavigationRail |
| **Bottom Navigation Bar** | Material 3 `NavigationBar` with animated pill & badges, legacy `BottomNavigationBar`, docked FAB `BottomAppBar` | Tab state persistence, badge indicators, docked action button cradle |

---

## 🎨 Theme & Design Philosophy

- **Modern Apple-Inspired Restraint**: Subtle neutral surface hierarchy, refined border outlines (`1px`), clean SF Pro / Inter typography, and controlled Indigo/Sky accents.
- **Dynamic Theme Mode**: Seamless one-tap toggle between Light and Dark mode with consistent contrast across all widgets.
- **In-App Code Inspector**: Tap the `<>` icon on any section to inspect the exact Flutter code implementation with one-tap copy to clipboard.

---

## 🚀 Running the App

### 1. Run on macOS Desktop
```bash
flutter run -d macos
```

### 2. Run in Google Chrome (Dev Mode)
```bash
flutter run -d chrome
```

### 3. View the Built Web App
The production web bundle is compiled in `build/web/`. A local server is currently hosted at:
```
http://localhost:8088/
```
To run the server again anytime:
```bash
python3 -m http.server 8088 --directory build/web
```

---

## 📂 Project Structure

```
lib/
├── main.dart                      # Root application & shell navigation
├── theme/
│   └── app_theme.dart             # Light & Dark Material 3 theme definitions
├── models/
│   └── widget_item.dart           # Widget showcase category metadata
├── screens/
│   ├── home_catalog_screen.dart   # Hero dashboard with search & filter chips
│   ├── buttons_screen.dart        # Core M3 & Cupertino buttons
│   ├── layouts_screen.dart        # Containers, alignment, Stack, & Wrap
│   ├── flex_screen.dart           # Deep dive into Flex, Expanded, & Spacer
│   ├── images_screen.dart         # BoxFit, clipping, blur & gradient overlays
│   ├── lists_screen.dart          # ListTile, Expansion, Dismissible & Reorder
│   ├── grid_screen.dart           # Interactive columns, spacing & cards
│   ├── app_bar_screen.dart        # SliverAppBar collapsing header & tabs
│   ├── sidebar_screen.dart        # Drawer ("die bar"), EndDrawer & NavigationRail
│   └── bottom_bar_screen.dart     # M3 NavigationBar, BottomAppBar & Docked FAB
└── widgets/
    ├── app_drawer.dart            # Global navigation drawer with theme switch
    ├── code_preview_dialog.dart   # Bottom sheet code viewer with clipboard copy
    └── section_header.dart        # Editorial section header & badge component
```
