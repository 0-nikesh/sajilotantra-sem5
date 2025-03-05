import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';
import 'package:sajilotantra/features/guidance/domain/use_case/get_all_guidance_usecase.dart';
import 'package:sajilotantra/features/guidance/domain/use_case/get_guidance_by_id_usecase.dart';
import 'package:sajilotantra/features/guidance/presentation/view/guidance_detail_view.dart';
import 'package:sajilotantra/features/guidance/presentation/view_model/guidance_bloc.dart';
import 'package:sajilotantra/features/guidance/presentation/view_model/guidance_state.dart';

// Generate mocks with: flutter pub run build_runner build
@GenerateMocks([GuidanceBloc, GetAllGuidancesUseCase, GetGuidanceByIdUseCase])
import 'guidance_detail_view_test.mocks.dart';

void main() {
  late MockGuidanceBloc mockGuidanceBloc;

  setUp(() {
    mockGuidanceBloc = MockGuidanceBloc();
  });

  // Helper method to create the widget under test
  Widget createWidgetUnderTest({required GuidanceState state}) {
    when(mockGuidanceBloc.stream).thenAnswer((_) => Stream.value(state));
    when(mockGuidanceBloc.state).thenReturn(state);

    return MaterialApp(
      home: BlocProvider<GuidanceBloc>(
        create: (_) => mockGuidanceBloc,
        child: const GuidanceDetailScreen(guidanceId: 'test-id'),
      ),
    );
  }

  group('GuidanceDetailScreen', () {
    testWidgets('shows loading state initially', (WidgetTester tester) async {
      await tester
          .pumpWidget(createWidgetUnderTest(state: GuidanceInitialState()));

      expect(find.text('Waiting for Details...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator),
          findsNothing); // If you add one later
    });

    testWidgets('displays error message when in error state',
        (WidgetTester tester) async {
      const errorMessage = 'Failed to load guidance';
      await tester.pumpWidget(createWidgetUnderTest(
        state: GuidanceErrorState(message: errorMessage),
      ));

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('displays guidance details when loaded',
        (WidgetTester tester) async {
      final guidance = GuidanceEntity(
        id: 'test-id',
        title: 'Test Guidance',
        description: '<p>Test steps</p>',
        thumbnail: 'https://example.com/image.jpg',
        category: 'Test Category',
        documentsRequired: const ['Doc1', 'Doc2'],
        costRequired: '\$100',
        userId: 'user123',
        createdAt: DateTime(2023, 1, 1),
      );

      await tester.pumpWidget(createWidgetUnderTest(
        state: GuidanceDetailsLoadedState(guidance: guidance),
      ));

      // Wait for all animations and network calls to settle
      await tester.pumpAndSettle();

      // Verify basic elements
      expect(find.text('Guidance Details'), findsOneWidget); // AppBar title
      expect(find.text('Test Guidance'), findsOneWidget);
      expect(find.text('Category: Test Category'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      // Verify accordion sections
      expect(find.text('Documents Required'), findsOneWidget);
      expect(find.text('Steps to Follow'), findsOneWidget);
      expect(find.text('Cost Required'), findsOneWidget);

      // Test expansion
      await tester.tap(find.text('Documents Required'));
      await tester.pumpAndSettle();
      expect(find.text('Doc1\nDoc2'), findsOneWidget);

      await tester.tap(find.text('Steps to Follow'));
      await tester.pumpAndSettle();
      expect(find.byType(Html), findsOneWidget);

      await tester.tap(find.text('Cost Required'));
      await tester.pumpAndSettle();
      expect(find.text('\$100'), findsOneWidget);
    });

    testWidgets('shows placeholder when image fails to load',
        (WidgetTester tester) async {
      const guidance = GuidanceEntity(
        id: 'test-id',
        title: 'Test Guidance',
        description: 'Test description',
        thumbnail: 'https://invalid-url.com/image.jpg', // Invalid URL
        category: 'Test Category',
      );

      await tester.pumpWidget(createWidgetUnderTest(
        state: GuidanceDetailsLoadedState(guidance: guidance),
      ));

      await tester.pumpAndSettle();

      expect(find.byType(Image), findsNothing);
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
      expect(find.byType(Container), findsWidgets); // The grey container
    });

    testWidgets('accordion displays default text when data is null',
        (WidgetTester tester) async {
      const guidance = GuidanceEntity(
        id: 'test-id',
        title: 'Test Guidance',
        description: 'Test description',
        thumbnail: 'https://example.com/image.jpg',
        category: 'Test Category',
        documentsRequired: null,
        costRequired: null,
      );

      await tester.pumpWidget(createWidgetUnderTest(
        state: GuidanceDetailsLoadedState(guidance: guidance),
      ));

      await tester.pumpAndSettle();

      await tester.tap(find.text('Documents Required'));
      await tester.pumpAndSettle();
      expect(find.text('No documents specified.'), findsOneWidget);

      await tester.tap(find.text('Cost Required'));
      await tester.pumpAndSettle();
      expect(find.text('No cost information available.'), findsOneWidget);
    });

    testWidgets('handles empty entity correctly', (WidgetTester tester) async {
      const guidance = GuidanceEntity.empty();

      await tester.pumpWidget(createWidgetUnderTest(
        state: GuidanceDetailsLoadedState(guidance: guidance),
      ));

      await tester.pumpAndSettle();

      expect(find.text(''), findsWidgets); // Empty title
      expect(find.text('Category: '), findsOneWidget);

      await tester.tap(find.text('Documents Required'));
      await tester.pumpAndSettle();
      expect(find.text(''), findsWidgets); // Empty documents

      await tester.tap(find.text('Cost Required'));
      await tester.pumpAndSettle();
      expect(find.text(''), findsWidgets); // Empty cost
    });
  });
}
