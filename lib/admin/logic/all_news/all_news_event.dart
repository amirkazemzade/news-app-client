part of 'all_news_bloc.dart';

abstract class AllNewsEvent extends Equatable {}

class FetchAllNews extends AllNewsEvent {
  @override
  List<Object> get props => [];
}

class ResetAllNews extends AllNewsEvent {
  @override
  List<Object> get props => [];
}
