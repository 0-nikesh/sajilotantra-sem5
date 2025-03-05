import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sajilotantra/features/auth/presentation/view/login.dart';
import 'package:sajilotantra/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUpAll(() {
    registerFallbackValue(LoginState.initial());
  });

  setUp(() {
    loginBloc = MockLoginBloc();
  });

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<LoginBloc>.value(
        value: loginBloc,
        child: child,
      ),
    );
  }

  testWidgets('renders Login page correctly', (WidgetTester tester) async {
    whenListen(
      loginBloc,
      Stream.fromIterable([LoginState.initial()]),
      initialState: LoginState.initial(),
    );

    await tester.pumpWidget(createTestWidget(Login()));

    expect(find.text("Login"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('triggers login event when login button is pressed',
      (WidgetTester tester) async {
    whenListen(
      loginBloc,
      Stream.fromIterable([LoginState.initial()]),
      initialState: LoginState.initial(),
    );

    await tester.pumpWidget(createTestWidget(Login()));

    await tester.enterText(
        find.byType(TextFormField).at(0), "test@example.com");
    await tester.enterText(find.byType(TextFormField).at(1), "password123");

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(() => loginBloc.add(
          LoginUserEvent(
            context: any(named: "context"),
            email: "test@example.com",
            password: "password123",
          ),
        )).called(1);
  });
}
