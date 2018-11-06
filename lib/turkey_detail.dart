import 'package:flutter/material.dart';
import 'package:turkeyventory/turkey_model.dart';
import 'package:turkeyventory/turkey_widgets.dart';

class TurkeyDetail extends StatelessWidget {
  TurkeyDetail(this.model, this.color);
  final TurkeyModel model;
  final Color color;

  static const double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline.copyWith(
          color: Colors.white,
        );
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(model.name),
            expandedHeight: _appBarHeight,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'image_${model.id}',
                child: Image.network(
                  model.images[0],
                  fit: BoxFit.cover,
                  height: _appBarHeight,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'info_${model.id}',
                  child: Card(
                    color: color,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 40.0,
                        ),
                        child: Center(
                          child: TurkeyInfoWidget(
                            model,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [.1, .9],
                        colors: [
                          Colors.grey.shade800,
                          Colors.grey.shade900,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 80.0,
                      ),
                      child: Text(
                        model.text,
                        style: textStyle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
