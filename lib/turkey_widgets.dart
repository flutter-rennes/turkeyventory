import 'package:flutter/material.dart';
import 'package:turkeyventory/turkey_model.dart';

class TurkeyInfoWidget extends StatelessWidget {
  TurkeyInfoWidget(
    this.model, {
    this.titleFontSize = 36.0,
    this.countFontSize = 20.0,
    this.isLeftAligned = true,
  });
  final TurkeyModel model;
  final double titleFontSize;
  final double countFontSize;
  final bool isLeftAligned;

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.title.copyWith(
          fontSize: titleFontSize,
          color: Colors.white,
        );
    final TextStyle countStyle = Theme.of(context).textTheme.subhead.copyWith(
          fontSize: countFontSize,
          color: Colors.white,
        );
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 120.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isLeftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            model.name,
            style: titleStyle,
            textAlign: isLeftAligned ? TextAlign.start : TextAlign.end,
          ),
          Expanded(
            child: SizedBox(),
          ),
          Text(
            '${model.count} dindon(s)',
            style: countStyle,
          )
        ],
      ),
    );
  }
}
