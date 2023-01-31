part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {
  const CategoryLoading(this.oldCategories, this.isFirstFetch);

  final List<Category> oldCategories;
  final bool isFirstFetch;
  @override
  List<Object> get props => [oldCategories, isFirstFetch];
}

class CategoryLoaded extends CategoryState {
  const CategoryLoaded(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories, categories.length];
}
