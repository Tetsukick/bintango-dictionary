import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bintango_indonesian_dictionary/feature/home/model/book.dart';
import 'package:bintango_indonesian_dictionary/shared/http/app_exception.dart';

part 'books_state.freezed.dart';

@freezed
class BooksState with _$BooksState {
  const factory BooksState.loading() = _Loading;

  const factory BooksState.booksLoaded(List<Book> books) = _Loaded;

  const factory BooksState.error(AppException error) = _Error;
}
