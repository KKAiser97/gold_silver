import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/locale/bloc/locale_event.dart';
import 'package:gold_silver/src/features/locale/bloc/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('vi'))) {
    on<ChangeLocaleEvent>((event, emit) {
      emit(LocaleState(event.locale));
    });
  }
}
