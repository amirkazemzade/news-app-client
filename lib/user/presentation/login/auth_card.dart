import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/routing/routes.dart';
import 'package:news_app_client/style/dimensions.dart';
import 'package:news_app_client/user/logic/auth/login/login_bloc.dart';
import 'package:news_app_client/user/logic/auth/obscure_state_cubit.dart';
import 'package:news_app_client/user/logic/auth/sign_up/sign_up_bloc.dart';
import 'package:news_app_client/user/logic/tokens/save_tokens_bloc.dart';
import 'package:news_app_client/widgets/filled_button.dart';
import 'package:news_app_client/widgets/loading_indicator.dart';
import 'package:news_app_client/widgets/snack_bar.dart';
import 'package:news_app_client/widgets/string_extension.dart';
import 'package:sizing/sizing.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveTokensBloc, SaveTokensState>(
      listener: (context, state) {
        if (state is SaveTokensSuccess) {
          Navigator.of(context).pushReplacementNamed(Routes.newsFeed);
        } else if (state is SaveTokensFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(context, state.error, isError: true),
          );
        }
      },
      child: Card(
        child: Container(
          width: 0.4.sw,
          padding: padding16,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                sizedBoxH16,
                Text(
                  "Login / Sign-Up",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                sizedBoxH32,
                _usernameTextField(),
                sizedBoxH12,
                _passwordTextField(),
                sizedBoxH24,
                _loginButton(),
                sizedBoxH8,
                _signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          _saveTokens(context, state.response.result!.token!);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(context, state.error, isError: true));
        }
      },
      builder: (context, state) {
        final child = state is SignUpLoading
            ? const StyledLoadingIndicator(width: 20)
            : const Text("Sign Up");
        return TextButton(
          onPressed: onSignUp,
          child: child,
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          _saveTokens(context, state.response.result!.token!);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(context, state.error, isError: true));
        }
      },
      builder: (context, state) {
        return FilledButton(
            onPressed: onLogin,
            isLoading: state is LoginLoading,
            child: const Text("Login"));
      },
    );
  }

  BlocBuilder<ObscureStateCubit, bool> _passwordTextField() {
    return BlocBuilder<ObscureStateCubit, bool>(
      builder: (context, obscure) {
        return TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) => onLogin(),
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: "Password",
            isDense: true,
            border: const OutlineInputBorder(
              borderRadius: circular16,
            ),
            suffixIcon: IconButton(
              splashRadius: 25,
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () => context.read<ObscureStateCubit>().revert(),
            ),
          ),
          validator: (value) {
            if (value == null || value.isBlank) {
              return "Please provide a password.";
            }
            return null;
          },
        );
      },
    );
  }

  TextFormField _usernameTextField() {
    return TextFormField(
      controller: usernameController,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "Username",
        isDense: true,
        border: OutlineInputBorder(borderRadius: circular16),
      ),
      validator: (value) {
        if (value == null || value.isBlank) {
          return "Please provide a username.";
        }
        return null;
      },
    );
  }

  void onLogin() {
    if (formKey.currentState?.validate() == false) return;
    context.read<LoginBloc>().add(
          OnLogin(
            username: usernameController.text,
            password: passwordController.text,
          ),
        );
  }

  void onSignUp() {
    if (formKey.currentState?.validate() == false) return;
    context.read<SignUpBloc>().add(
          OnSignUp(
            username: usernameController.text,
            password: passwordController.text,
          ),
        );
  }

  void _saveTokens(BuildContext context, String accessToken) {
    context.read<SaveTokensBloc>().add(
          SaveTokensEvent(
            accessToken: accessToken,
          ),
        );
  }
}
