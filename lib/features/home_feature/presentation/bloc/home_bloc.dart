import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/home_feature/domain/entities/note_model_entity.dart';

import 'package:mindwrite/features/home_feature/domain/usecases/load_notes_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<NoteModelEntity> allLoadedNotes;
  List<NoteModelEntity>? pinnedNotes = [];
  LoadAllNotes loadNotesUsecase;
  HomeBloc(this.allLoadedNotes, this.loadNotesUsecase)
      : super(const HomeInitial([])) {
    on<GetNotesEvent>((event, emit) async {
      final result = await loadNotesUsecase.call();
      pinnedNotes!.clear();
      if (result is DataSuccess<List<NoteModelEntity>>) {
        for (NoteModelEntity element in result.data!.where(
          (element) => element.pin == true,
        )) {
          pinnedNotes!.add(element);
        }
        emit(HomeLoaded(result.data!,
            pinnedNotes!)); // وضعیت موفقیت‌آمیز با لیست مدل‌های نوت
      } else if (result is DataFailed) {
        emit(HomeLoadFailed(result.error!)); // وضعیت شکست
        print(result.error);
      }
    });
  }
}
