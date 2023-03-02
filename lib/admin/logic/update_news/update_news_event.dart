part of 'update_news_bloc.dart';

class UpdateNewsEvent extends Equatable {
  final int newsId;
  final String? title;
  final String? body;
  final int? categoryId;
  final int? viewCount;

  const UpdateNewsEvent({
    required this.newsId,
    this.title,
    this.body,
    this.categoryId,
    this.viewCount,
  });

  @override
  List<Object?> get props => [newsId, title, body, categoryId, viewCount];
}
