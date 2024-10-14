import 'package:flutter/material.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/shared_bloc/domain/repository/shared_repository.dart';

class ChangeLanguageUsecase implements UseCase<DataState<Locale>, Locale> {
  final SharedRepository sharedRepository;
  ChangeLanguageUsecase(this.sharedRepository);
  @override
  Future<DataState<Locale>> call(Locale locale) async {
    try {
      final result = await sharedRepository.changeLanguage(locale);

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
