part of 'create_news_bloc.dart';

class CreateNewsEvent extends Equatable {
  final String title;
  final String body;
  final int categoryId;
  final int viewCount;

  const CreateNewsEvent({
    required this.title,
    required this.body,
    required this.categoryId,
    required this.viewCount,
  });

  @override
  List<Object> get props => [title, body, categoryId, viewCount];
}
