import 'package:flutter_test/flutter_test.dart';
import 'package:toyota_gr/main.dart';

void main() {
  testWidgets('Toyota Gazoo Racing app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ToyotaGrApp());
    expect(find.text('TOYOTA GAZOO RACING'), findsWidgets);
  });
}
