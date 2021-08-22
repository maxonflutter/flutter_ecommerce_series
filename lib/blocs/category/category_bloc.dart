import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:flutter_ecommerce_app/repositories/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState();
    }
    if (event is UpdateCategories) {
      yield* _mapUpdateCategoriesToState(event);
    }
  }

  Stream<CategoryState> _mapLoadCategoriesToState() async* {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllCategories().listen(
          (categories) => add(
            UpdateCategories(categories),
          ),
        );
  }

  Stream<CategoryState> _mapUpdateCategoriesToState(
      UpdateCategories event) async* {
    yield CategoryLoaded(categories: event.categories);
  }
}
