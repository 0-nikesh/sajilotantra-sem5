import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sajilotantra/core/error/failure.dart';
import 'package:sajilotantra/features/guidance/domain/entity/guidance_entity.dart';
import 'package:sajilotantra/features/guidance/domain/use_case/get_all_guidance_usecase.dart';
import 'package:sajilotantra/features/guidance/domain/use_case/get_guidance_by_id_usecase.dart';
import 'package:sajilotantra/features/guidance/presentation/view/guidance_list_view.dart';
import 'package:sajilotantra/features/guidance/presentation/view_model/guidance_bloc.dart';
import 'package:sajilotantra/features/guidance/presentation/view_model/guidance_event.dart';

class MockGetAllGuidancesUseCase extends Mock
    implements GetAllGuidancesUseCase {}

class MockGetGuidanceByIdUseCase extends Mock
    implements GetGuidanceByIdUseCase {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late GuidanceBloc mockGuidanceBloc;
  late MockGetAllGuidancesUseCase mockGetAllGuidancesUseCase;
  late MockGetGuidanceByIdUseCase mockGetGuidanceByIdUseCase;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockGetAllGuidancesUseCase = MockGetAllGuidancesUseCase();
    mockGetGuidanceByIdUseCase = MockGetGuidanceByIdUseCase();
    mockGuidanceBloc = GuidanceBloc(
      getAllGuidancesUseCase: mockGetAllGuidancesUseCase,
      getGuidanceByIdUseCase: mockGetGuidanceByIdUseCase,
    );
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider.value(
        value: mockGuidanceBloc,
        child: child,
      ),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  testWidgets('displays list of guidance when loaded',
      (WidgetTester tester) async {
    // Mock use case return value
    when(() => mockGetAllGuidancesUseCase.call())
        .thenAnswer((_) async => Right(mockGuidances));

    await tester.pumpWidget(createTestWidget(const GuidanceListScreen()));

    // Dispatch event to load guidance
    mockGuidanceBloc.add(LoadAllGuidancesEvent());
    await tester.pump();

    // Check if UI displays the correct text
    expect(find.text('Guidance 1'), findsOneWidget);
    expect(find.text('Guidance 2'), findsOneWidget);
    expect(find.text('No Guidance Available'), findsNothing);
  });

  testWidgets('displays no guidance message when no guidance available',
      (WidgetTester tester) async {
    when(() => mockGetAllGuidancesUseCase.call())
        .thenAnswer((_) async => const Right([]));

    await tester.pumpWidget(createTestWidget(const GuidanceListScreen()));

    mockGuidanceBloc.add(LoadAllGuidancesEvent());
    await tester.pump();

    expect(find.text('No Guidance Available'), findsOneWidget);
  });

  testWidgets('displays error message when guidance fails to load',
      (WidgetTester tester) async {
    when(() => mockGetAllGuidancesUseCase.call()).thenAnswer(
        (_) async => const Left(ApiFailure(message: 'Error loading guidance')));

    await tester.pumpWidget(createTestWidget(const GuidanceListScreen()));

    mockGuidanceBloc.add(LoadAllGuidancesEvent());
    await tester.pump();

    expect(find.text('Error loading guidance'), findsOneWidget);
  });

  testWidgets('navigates to guidance detail screen on tap',
      (WidgetTester tester) async {
    when(() => mockGetAllGuidancesUseCase.call())
        .thenAnswer((_) async => Right(mockGuidances));

    await tester.pumpWidget(createTestWidget(const GuidanceListScreen()));

    mockGuidanceBloc.add(LoadAllGuidancesEvent());
    await tester.pump();

    // Tap on the first guidance item
    await tester.tap(find.text('Guidance 1'));
    await tester.pumpAndSettle();

    // Verify navigation occurred
    verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
  });
}

// Mock Guidance Data
var mockGuidances = [
  GuidanceEntity(
    id: '1',
    title: 'Guidance 1',
    description: 'This is a description for guidance 1.',
    thumbnail: 'https://example.com/image1.jpg',
    category: 'Category 1',
    documentsRequired: const ['Document 1', 'Document 2'],
    costRequired: '100',
    userId: 'user1',
    createdAt: DateTime.now(),
  ),
  GuidanceEntity(
    id: '2',
    title: 'Guidance 2',
    description: 'This is a description for guidance 2.',
    thumbnail: 'https://example.com/image2.jpg',
    category: 'Category 2',
    documentsRequired: const ['Document A', 'Document B'],
    costRequired: '200',
    userId: 'user2',
    createdAt: DateTime.now(),
  ),
];
