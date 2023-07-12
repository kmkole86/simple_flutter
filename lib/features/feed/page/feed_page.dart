import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter/features/feed/bloc/feed_bloc.dart';
import 'package:simple_flutter/features/feed/bloc/feed_event.dart';
import 'package:simple_flutter/features/feed/bloc/feed_state.dart';
import 'package:simple_flutter/features/feed/widgets/feed_list.dart';

import '../../../injection_container.dart';

class PopularMoviesPage extends StatelessWidget {
  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SimpleApp"),
        ),
        body: buildBody(context));
  }
}

BlocProvider<FeedBloc> buildBody(BuildContext context) {
  return BlocProvider<FeedBloc>(
    create: (_) => di<FeedBloc>()..add(OnBottomOfPageReached()),
    child: BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) => MovieList(items: state.uiItems),
    ),
  );
}
