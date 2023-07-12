import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:simple_flutter/features/feed/bloc/feed_bloc.dart';
import 'package:simple_flutter/features/feed/bloc/feed_event.dart';
import 'package:simple_flutter/features/feed/bloc/feed_state.dart';
import 'package:test/test.dart';

import 'feed_bloc_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<GetPageRangeUseCase>(), MockSpec<FeedUiItemsMapper>()])
void main() {
  late MockGetPageRangeUseCase mockUseCase;
  late MockFeedUiItemsMapper mockMapper;
  late FeedBloc bloc;

  setUp(() {
    mockUseCase = MockGetPageRangeUseCase();
    mockMapper = MockFeedUiItemsMapper();
    bloc =
        FeedBloc(getPageRangeUseCase: mockUseCase, mapper: FeedUiItemsMapper());
  });

  test('initial sate should be empty', () async {
    expect(bloc.state, Fetched.empty());
  });

  blocTest<FeedBloc, FeedState>(
      "should call concrete useCase on OnBottomOfPageReached event when state is Fetched",
      build: () =>
          FeedBloc(getPageRangeUseCase: mockUseCase, mapper: mockMapper),
      seed: () => const Fetched(
          items: [],
          uiItems: [],
          range: Range(fromInclusive: 0, toExclusive: 1)),
      act: (bloc) => bloc.add(OnBottomOfPageReached()),
      wait: const Duration(milliseconds: 2000),
      verify: (_) {
        verify(mockUseCase.getPageRange(range: anyNamed('range')));
      });

  blocTest<FeedBloc, FeedState>(
      "should not call concrete useCase on OnBottomOfPageReached event when state is Error",
      build: () =>
          FeedBloc(getPageRangeUseCase: mockUseCase, mapper: mockMapper),
      seed: () => const Error(
          items: [],
          uiItems: [],
          range: Range(fromInclusive: 0, toExclusive: 1)),
      act: (bloc) => bloc.add(OnBottomOfPageReached()),
      wait: const Duration(milliseconds: 2000),
      verify: (_) {
        verifyNever(mockUseCase.getPageRange(range: anyNamed('range')));
      });

  blocTest<FeedBloc, FeedState>(
      "should not call concrete useCase on OnBottomOfPageReached event when state is Fetching",
      build: () =>
          FeedBloc(getPageRangeUseCase: mockUseCase, mapper: mockMapper),
      seed: () => const Fetching(
          items: [],
          uiItems: [],
          range: Range(fromInclusive: 0, toExclusive: 1)),
      act: (bloc) => bloc.add(OnBottomOfPageReached()),
      wait: const Duration(milliseconds: 2000),
      verify: (_) {
        verifyNever(mockUseCase.getPageRange(range: anyNamed('range')));
      });

  blocTest<FeedBloc, FeedState>(
      "should emit Fetching,Fetched when useCase call si successful",
      build: () {
        when(mockUseCase.getPageRange(range: anyNamed('range'))).thenAnswer(
            (_) => Stream.fromIterable(
                [FetchInFlight(), Success(pages: const [])]));

        return FeedBloc(getPageRangeUseCase: mockUseCase, mapper: mockMapper);
      },
      act: (bloc) => bloc.add(OnBottomOfPageReached()),
      expect: () => [
            const Fetching(
                items: [],
                uiItems: [],
                range: Range(fromInclusive: 0, toExclusive: 0)),
            const Fetched(
                items: [],
                uiItems: [],
                range: Range(fromInclusive: 0, toExclusive: 0))
          ]);

  blocTest<FeedBloc, FeedState>(
      "should emit Fetching,Error when useCase call is un_successful",
      build: () {
        when(mockUseCase.getPageRange(range: anyNamed('range'))).thenAnswer(
            (_) => Stream.fromIterable(
                [FetchInFlight(), Failed(error: GetPageError.genericError)]));

        return FeedBloc(getPageRangeUseCase: mockUseCase, mapper: mockMapper);
      },
      act: (bloc) => bloc.add(OnBottomOfPageReached()),
      expect: () => [
            const Fetching(
                items: [],
                uiItems: [],
                range: Range(fromInclusive: 0, toExclusive: 0)),
            const Error(
                items: [],
                uiItems: [],
                range: Range(fromInclusive: 0, toExclusive: 0))
          ]);
}
