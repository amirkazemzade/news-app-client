import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureStateCubit extends Cubit<bool> {
  ObscureStateCubit() : super(true);

  void revert() => emit(!state);
}
