import 'package:flutter/material.dart';
import 'package:flutter_refresh_token/mixin/cancelable.dart';
import 'package:flutter_refresh_token/mixin/debouncer.dart';

class SearchFieldWithDebouncer extends StatefulWidget {
  const SearchFieldWithDebouncer({Key? key}) : super(key: key);

  @override
  State<SearchFieldWithDebouncer> createState() =>
      _SearchFieldWithDebouncerState();
}

class _SearchFieldWithDebouncerState extends State<SearchFieldWithDebouncer>
    with Debouncer {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SearchFieldWithDebouncer Title')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => debounceRun(() {
              print('debunce value');
            }),
          )
        ],
      ),
    );
  }
}

class SearchFieldCancelable extends StatefulWidget {
  const SearchFieldCancelable({Key? key}) : super(key: key);

  @override
  State<SearchFieldCancelable> createState() => _SearchFieldCancelableState();
}

class _SearchFieldCancelableState extends State<SearchFieldCancelable>
    with CancelableMixin<SearchFieldCancelable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SearchFieldCancelable Title')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => onChange(value, () {
              print('cancelable value');
            }),
          )
        ],
      ),
    );
  }
}
