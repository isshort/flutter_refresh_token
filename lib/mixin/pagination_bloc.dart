import 'package:flutter/material.dart';

const _start = 0;

mixin PagingBlocList<T extends StatefulWidget, Data> on State<T> {
  final scrollController = ScrollController();

  List<Data> dataList = <Data>[];
  bool isLoading = false;
  void get callbackRequest;
  int get itemCount => dataList.length + (isLoading ? 1 : 0);

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (position.atEdge && position.pixels != _start) {
        callbackRequest;
      }
    });
  }

  ScrollPosition get position => scrollController.position;
  bool get shouldCircle =>
      scrollController.hasClients && position.pixels != _start;

  Widget reloadPagination() {
    return shouldCircle
        ? const CircularProgressIndicator()
        : const SizedBox.shrink();
  }

  @override
  void initState() {
    _setupScrollController(context);
    callbackRequest;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }
}
mixin PagingSubData<D> {
  bool isLoading = false;

  List<D> dataList = <D>[];
  int get itemCount => dataList.length + (isLoading ? 1 : 0);
}
