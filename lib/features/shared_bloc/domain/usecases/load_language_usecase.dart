import 'package:flutter/material.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';

import 'package:mindwrite/features/shared_bloc/domain/repository/shared_repository.dart';

class LoadLanguageUsecase implements UseCase<DataState<Locale>, Locale> {
  final SharedRepository noteRepository;
  LoadLanguageUsecase(this.noteRepository);
  @override
  Future<DataState<Locale>> call([void param]) async {
    try {
      final result = await noteRepository.loadAppLocade();

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
