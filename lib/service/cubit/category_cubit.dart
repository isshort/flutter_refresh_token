import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

const _firstPage = 0;

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  bool? hasNextPage = true;
  int page = 0;

  Future<void> categoryList() async {
    if (state is CategoryLoading) return;
    final currentState = state;
    var oldCategories = <Category>[];
    if (currentState is CategoryLoaded) {
      oldCategories = currentState.categories;
    }
    emit(CategoryLoading(oldCategories, page == _firstPage));
    if (hasNextPage == true) {
      // final response = await _repo.getCategories(page.toPagination(page));
      /// here should be request
      ///
      ///
      // if (response.error != null) {
      //   emit(CategoryError(response.error!));
      // } else if (response.data != null && state is CategoryLoading) {
      //   hasNextPage = response.hasNextPage;
      //   page++;
      //   final newCategories = response.data;
      //   final categories = (state as CategoryLoading).oldCategories
      //     ..addAll(newCategories!);
      //   emit(CategoryLoaded(categories));
      // }
    }
  }
}

class Category {}
