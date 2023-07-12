import 'package:equatable/equatable.dart';

class Range extends Equatable {
  const Range({required this.fromInclusive, required this.toExclusive});

  final int fromInclusive, toExclusive;

  @override
  List<Object?> get props => [fromInclusive, toExclusive];
}
