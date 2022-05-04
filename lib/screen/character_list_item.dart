import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_owner/model/character_summary.dart';

import '../helpers/styleguide.dart';

/// List item representing a single Character with its photo and name.
class CharacterListItem extends StatefulWidget {
  const CharacterListItem({
    this.character,
    Key key,
  }) : super(key: key);

  final CharacterSummary character;

  @override
  _CharacterListItemState createState() => _CharacterListItemState();
}

class _CharacterListItemState extends State<CharacterListItem> {
  @override
  Widget build(BuildContext context) => ListTile(
        // leading: CircleAvatar(
        //   radius: 20,
        //   backgroundImage:
        //       CachedNetworkImageProvider(widget.character.pictureUrl),
        // ),
        leading: Container(
          height: 28,
          width: 28,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Icon(
            FontAwesomeIcons.chevronDown,
            color: Colors.white,
            size: 15,
          ),
        ),
        title: Text(widget.character.name),
      );
}
