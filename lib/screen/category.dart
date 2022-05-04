import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_owner/model/category.dart';
import 'package:shop_owner/provider/change_state.dart';

import '../helpers/styleguide.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ChangeState>(context);
    final isSelected = appState.selectedCategoryId == category.categoryId;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          appState.updateCategoryId(category.categoryId);
        }
      },
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 4),
        margin: EdgeInsets.only(right: 10.0),
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        height: 35,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          border: Border.all(
              color: isSelected ? Colors.transparent : Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(19)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: GoogleFonts.openSans(
                color: isSelected ? Colors.white : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
