import 'package:flutter_riverpod/all.dart';
import 'package:shop_owner/model/list_item.dart';

final listState = StateNotifierProvider(
    (ref) => DemoItemList([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]));
final loadingState = StateProvider((ref) => false);
