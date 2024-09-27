import 'package:flutter/material.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';

import 'package:mindwrite/features/shared_bloc/domain/repository/shared_repository.dart';

class ToggleThemeUsecase implements UseCase<DataState<ThemeMode>, ThemeMode> {
  final SharedRepository noteRepository;
  ToggleThemeUsecase(this.noteRepository);
  @override
  Future<DataState<ThemeMode>> call([void param]) async {
    try {
      final result = await noteRepository.toggleThemeMode();

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
