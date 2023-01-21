import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/providers/hive_provider.dart';
import 'package:news_app_client/user/data/repository.dart';
import 'package:news_app_client/user/logic/auth/login/login_bloc.dart';
import 'package:news_app_client/user/logic/auth/obscure_state_cubit.dart';
import 'package:news_app_client/user/logic/auth/sign_up/sign_up_bloc.dart';
import 'package:news_app_client/user/logic/tokens/save_tokens_bloc.dart';
import 'package:news_app_client/user/presentation/login/auth_card.dart';
import 'package:news_app_client/widgets/top_bar.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ObscureStateCubit(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(repository: _repository(context)),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(repository: _repository(context)),
        ),
        BlocProvider(
          create: (context) => SaveTokensBloc(provider: HiveProvider()),
        ),
      ],
      child: Scaffold(
        appBar: topBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AuthCard(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Repository _repository(BuildContext context) => context.read<Repository>();
}
