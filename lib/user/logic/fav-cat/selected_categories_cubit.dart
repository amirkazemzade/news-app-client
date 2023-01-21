import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/category_enum.dart';


class SelectedCategoriesCubit extends Cubit<List<Category>> {
  SelectedCategoriesCubit() : super([]);

  void addCategory(Category category) {
    final newList = state.toList();
    newList.add(category);
    emit(newList);
  }

  void removeCategory(Category category) {
    final newList = state.toList();
    newList.remove(category);
    emit(newList);
  }

  void setCategories(List<Category> categories) => emit(categories);
}
