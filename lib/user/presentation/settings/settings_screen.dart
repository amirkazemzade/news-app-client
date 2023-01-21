import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/category_enum.dart';
import 'package:news_app_client/user/data/providers/favorite_category_data_provider.dart';
import 'package:news_app_client/user/logic/fav-cat/favorite_categories_bloc.dart';
import 'package:news_app_client/user/logic/fav-cat/selected_categories_cubit.dart';
import 'package:news_app_client/user/logic/update-fav-cat/update_fav_cats_bloc.dart';
import 'package:news_app_client/widgets/failure_widgets.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';
import 'package:news_app_client/widgets/top_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FavoriteCategoriesBloc(provider: FavoriteCategoryDataProvider()),
        ),
        BlocProvider(
          create: (context) =>
              UpdateFavCatsBloc(provider: FavoriteCategoryDataProvider()),
        ),
        BlocProvider(
          create: (context) => SelectedCategoriesCubit(),
        ),
      ],
      child: BlocConsumer<UpdateFavCatsBloc, UpdateFavCatsState>(
        listener: (context, state) {
          if (state is UpdateFavCatsSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, updateFavCatsState) {
          return Scaffold(
            appBar: topBar(
              context,
              actions: _actions(updateFavCatsState, context),
            ),
            body: BlocConsumer<FavoriteCategoriesBloc, FavoriteCategoriesState>(
              listener: (context, state) {
                if (state is FavoriteCategoriesSuccess) {
                  context.read<SelectedCategoriesCubit>().setCategories(state
                      .categories.categories!
                      .map((e) => categoryFromId(e))
                      .toList());
                }
              },
              builder: (context, favCatState) {
                if (favCatState is FavoriteCategoriesInitial) {
                  _fetchFavoriteCategories(context);
                }
                if (favCatState is FavoriteCategoriesSuccess) {
                  return BlocBuilder<SelectedCategoriesCubit, List<Category>>(
                    builder: (context, selected) {
                      return ListView(
                        children: Category.values.map((e) {
                          var isSelected = selected.contains(e);
                          return ListTile(
                            onTap: () {
                              setCategory(e, isSelected, context);
                            },
                            leading: Checkbox(
                              value: isSelected,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              checkColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              onChanged: (bool? value) {
                                setCategory(e, isSelected, context);
                              },
                            ),
                            title: Text(e.name),
                          );
                        }).toList(),
                      );
                    },
                  );
                }
                if (favCatState is FavoriteCategoriesFailure) {
                  return FailureWidget(
                    onPressed: () => _resetFavoriteCategories(context),
                    errorMessage: favCatState.error,
                  );
                }
                return const StyledLoadingIndicator();
              },
            ),
          );
        },
      ),
    );
  }

  List<Widget> _actions(UpdateFavCatsState updateFavCatsState, BuildContext context) {
    return updateFavCatsState is UpdateFavCatsLoading
                ? [const StyledLoadingIndicator(width: 20)]
                : [
                    IconButton(
                      onPressed: () {
                        final categories =
                            context.read<SelectedCategoriesCubit>().state;
                        context.read<UpdateFavCatsBloc>().add(
                              UpdateFavCatsEvent(
                                favoriteCategories:
                                    categories.map((e) => e.id).toList(),
                              ),
                            );
                      },
                      icon: const Icon(Icons.done),
                    )
                  ];
  }

  void _fetchFavoriteCategories(BuildContext context) {
    context.read<FavoriteCategoriesBloc>().add(FetchFavoriteCategories());
  }

  void _resetFavoriteCategories(BuildContext context) {
    context.read<FavoriteCategoriesBloc>().add(ResetFavoriteCategories());
  }

  void setCategory(Category e, bool isSelected, BuildContext context) {
    if (isSelected) {
      context.read<SelectedCategoriesCubit>().removeCategory(e);
    } else {
      context.read<SelectedCategoriesCubit>().addCategory(e);
    }
  }
}
