import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_catalog/main.dart';

void main() {
  testWidgets('App smoke test loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterWidgetStudioApp());
    expect(find.text('Widget Showcase Studio'), findsOneWidget);
  });
}
