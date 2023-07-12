import 'package:collection/collection.dart';
import 'package:simple_flutter/data/mappers/entity_mapper.dart';
import 'package:simple_flutter/data/model/movie_data.dart';
import 'package:simple_flutter/domain/entity/movie_entity.dart';
import 'package:test/test.dart';

void main() {
  const int numOfElements = 3;
  final List<MovieData> dataList = [];
  final List<Movie> domainList = [];
  const EntityMapper subject = EntityMapper();

  setUp(() {
    for (var i = 0; i < numOfElements; i++) {
      dataList.add(MovieData(
          id: i,
          title: "title_$i",
          overview: "overview_$i",
          posterPath: "posterPath_$i",
          releaseDate: "releaseDate_$i",
          voteAverage: i.toDouble(),
          voteCount: i));

      domainList.add(Movie(
          id: i,
          title: "title_$i",
          overview: "overview_$i",
          posterPath: "posterPath_$i",
          releaseDate: "releaseDate_$i",
          voteAverage: i.toDouble(),
          voteCount: i));
    }
  });

  test('Mapper should map MovieData to Movie', () {
    MovieData data = dataList.first;
    Movie domain = domainList.first;

    Movie result = subject.mapToMovie(data);

    expect(domain, result);
  });

  test("Mapper should map MovieData list to Movie list", () {
    List<Movie> results = subject.mapToMovies(dataList);
    expect(const ListEquality().equals(domainList, results), true);
  });
}
