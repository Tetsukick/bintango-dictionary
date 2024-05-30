import 'package:flutter/material.dart';
import 'package:bintango_indonesian_dictionary/feature/home/model/book.dart';

class RowBookWidget extends StatelessWidget {

  const RowBookWidget({required this.book, super.key});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: ListTile(
        leading: Text(
          '${book.id}',
          style: const TextStyle(fontSize: 10),
        ),
        title: Text(book.title ?? ''),
        isThreeLine: true,
        subtitle: Text(book.subTitle ?? ''),
        dense: true,
      ),
    );
  }
}
