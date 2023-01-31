import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mixin/pagination_bloc.dart';
import '../service/cubit/category_cubit.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with PagingBlocList<CategoryView, Category> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading && state.isFirstFetch) {
          return const CircularProgressIndicator();
        }
        if (state is CategoryLoading) {
          isLoading = true;
          dataList = state.oldCategories;
        } else if (state is CategoryLoaded) {
          dataList = state.categories;
        }
        ListView.builder(
          itemBuilder: (context, index) {
            if (index < dataList.length) {
              final item = dataList[index];
              return Text("$item");
            }
            return null;
          },
        );
        return reloadPagination();
      },
    );
  }

  @override
  void get callbackRequest => context.read<CategoryCubit>().categoryList();
}
