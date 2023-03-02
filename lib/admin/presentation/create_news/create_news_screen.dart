import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/admin/data/providers/admin_news_data_provider.dart';
import 'package:news_app_client/admin/logic/create_news/create_news_bloc.dart';
import 'package:news_app_client/admin/logic/create_news/selected_category_cubit.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/user/data/models/category_enum.dart'
    as category;
import 'package:news_app_client/user/data/models/category_enum.dart';
import 'package:news_app_client/widgets/dropdown_menu.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';
import 'package:news_app_client/widgets/snack_bar.dart';
import 'package:news_app_client/widgets/string_extension.dart';
import 'package:news_app_client/widgets/top_bar.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final viewCountController = TextEditingController();

  @override
  void initState() {
    viewCountController.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectedCategoryCubit(),
        ),
        BlocProvider(
          create: (context) =>
              CreateNewsBloc(provider: AdminNewsDataProvider()),
        ),
      ],
      child: Scaffold(
        appBar: topBar(
          context,
          actions: [
            BlocConsumer<CreateNewsBloc, CreateNewsState>(
              listener: (context, state) {
                if (state is CreateNewsSuccess) {
                  Navigator.of(context).pop();
                } else if (state is CreateNewsFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(context, state.error, isError: true),
                  );
                }
              },
              builder: (context, state) {
                if (state is CreateNewsLoading) {
                  return const StyledLoadingIndicator(width: 20);
                }
                return IconButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == false) return;
                    final selectedCategory =
                        context.read<SelectedCategoryCubit>().state;
                    context.read<CreateNewsBloc>().add(
                          CreateNewsEvent(
                            title: titleController.text,
                            body: bodyController.text,
                            categoryId: selectedCategory.id,
                            viewCount:
                                int.tryParse(viewCountController.text) ?? 0,
                          ),
                        );
                  },
                  icon: const Icon(Icons.done),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: padding64,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: circular16),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isBlank) {
                      return "Please provide a title.";
                    }
                    return null;
                  },
                ),
                sizedBoxH32,
                TextFormField(
                  controller: bodyController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Body",
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: circular16),
                  ),
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isBlank) {
                      return "Please provide a body.";
                    }
                    return null;
                  },
                ),
                sizedBoxH32,
                TextFormField(
                  controller: viewCountController,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: "View Count",
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: circular16),
                  ),
                  validator: (value) {
                    if (value == null || value.isBlank) {
                      return "Please provide a view count.";
                    }
                    return null;
                  },
                ),
                sizedBoxH32,
                BlocBuilder<SelectedCategoryCubit, Category>(
                  builder: (context, selectedCategory) {
                    return DropdownMenu<Category>(
                      label: "Category",
                      selected: selectedCategory,
                      items: category.Category.values,
                      itemTitle: (category) => category.name,
                      onChange: (value) {
                        context
                            .read<SelectedCategoryCubit>()
                            .setCategory(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
