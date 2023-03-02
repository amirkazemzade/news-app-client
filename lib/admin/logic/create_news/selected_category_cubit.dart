import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/category_enum.dart';


class SelectedCategoryCubit extends Cubit<Category> {
  SelectedCategoryCubit() : super(Category.sports);

  void setCategory (Category category) => emit(category);
}
