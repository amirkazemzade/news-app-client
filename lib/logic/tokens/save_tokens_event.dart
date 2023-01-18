part of 'save_tokens_bloc.dart';

class SaveTokensEvent extends Equatable {
  final String accessToken;

  const SaveTokensEvent({
    required this.accessToken,
  });

  @override
  List<Object> get props => [accessToken];
}
