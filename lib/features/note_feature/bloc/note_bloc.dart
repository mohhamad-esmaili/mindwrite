import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(const NoteInitial()) {
    // مدیریت رویداد LoadNoteEvent
    on<LoadNoteEvent>((event, emit) {
      // اینجا می‌توانید داده‌ها را از یک منبع خارجی بارگیری کنید
      // ولی فعلاً فرض می‌کنیم که رنگ اولیه باید بارگذاری شود.
      emit(const NoteInitial());
    });

    // مدیریت رویداد ChangeNoteColorEvent
    on<ChangeNoteColorEvent>((event, emit) {
      emit((state as NoteInitial).copyWith(chosenColor: event.selectedColor));
    });
  }
}
