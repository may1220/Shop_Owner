import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyListItem extends StatelessWidget {
  final int position;
  MyListItem(this.position, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
          leading: Icon(Icons.star),
          title: Text('This is demo item $position'),
          subtitle: Text('Generate by code')),
    );
  }
}

class DemoItemList extends StateNotifier<List<int>> {
  DemoItemList(List<int> state) : super(state);
  void addAll(List<int> newItems) {
    state.addAll(newItems);
  }
}
