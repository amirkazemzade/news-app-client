import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBrightnessCubit extends Cubit<Brightness> {
  ThemeBrightnessCubit() : super(Brightness.dark);

  void setBrightness(Brightness brightness) => emit(brightness);
}
