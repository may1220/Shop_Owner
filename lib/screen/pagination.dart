import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shop_owner/model/character_summary.dart';
import 'package:shop_owner/provider/remote_api.dart';
import 'package:shop_owner/screen/common_widget/appbar_screen.dart';
import 'package:shop_owner/screen/character_list_item.dart';
import 'package:shop_owner/screen/drawer_page/drawer.dart';

class CharacterListView extends StatefulWidget {
  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  static const _pageSize = 20;

  final PagingController<int, CharacterSummary> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  bool lastPage = false;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        setState(() {
          lastPage = true;
        });
        _pagingController.appendLastPage(newItems);
      } else {
        // lastPage = false;
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BaseAppBar(
            title: 'Staff List',
            appBar: AppBar(),
          ),
          drawer: DrawerScreen(),
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                      // () => _pagingController.refresh(),
                      () {
                    setState(() {
                      lastPage = false;
                    });
                    _pagingController.refresh();
                  }),
                  child: PagedListView<int, CharacterSummary>.separated(
                    pagingController: _pagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<CharacterSummary>(
                      itemBuilder: (context, item, index) => CharacterListItem(
                        character: item,
                      ),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
              ),
              lastPage == true
                  ? Center(
                      child: Text(
                        "No more to show ...",
                        style: GoogleFonts.openSans(color: Colors.black),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
