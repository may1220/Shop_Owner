import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_owner/model/list_item.dart';
import 'package:shop_owner/screen/state.dart';

class PaginationScreen extends StatelessWidget {
  const PaginationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MyList(),
    );
  }
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    var isLoadingState = watch(loadingState);
    var dataLoaded = watch(listState);
    return ProviderScope(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Lazy Load'),
        ),
        body: LazyLoadScrollView(
          isLoading: isLoadingState.state,
          onEndOfPage: () => _loadMoreItem(context),
          child: Scrollbar(
            child: ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dataLoaded.length,
                    itemBuilder: (context, position) {
                      return MyListItem(position);
                    }),
                isLoadingState.state
                    ? JumpingDotsProgressIndicator(fontSize: 40.0)
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadMoreItem(BuildContext context) async {
    context.read(loadingState).state = true;
    await new Future.delayed(const Duration(seconds: 3));
    context.read(listState).addAll(
        List.generate(10, (index) => context.read(listState).length + index));
    context.read(loadingState).state = false;
  }
}
