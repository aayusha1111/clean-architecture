import 'package:clean_architecture/core/theme/theme_event.dart';
import 'package:clean_architecture/core/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc():super(ThemeState(themeMode: ThemeMode.light)){
    on<SetLightTheme>((event,emit){
      emit(ThemeState(themeMode: ThemeMode.light));
    });
    on<SetDarkTheme>((event,emit){
      emit(ThemeState(themeMode: ThemeMode.dark));
    });

  }
}