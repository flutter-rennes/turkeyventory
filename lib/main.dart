import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turkeyventory/turkey_detail.dart';
import 'package:turkeyventory/turkey_model.dart';
import 'package:turkeyventory/turkey_widgets.dart';

void main() async {
  await Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Turkeyventory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turkeyventory'),
      ),
      body: TurkeyCardList(),
    );
  }
}

class TurkeyCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('turkeys').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading...');
        final count = snapshot.data.documents.length;
        return ListView.builder(
          itemCount: count,
          itemBuilder: (context, i) {
            final doc = snapshot.data.documents[i];
            final model = TurkeyModel.fromSnapshot(doc);
            return TurkeyCard(model, i.isEven);
          },
        );
      },
    );
  }
}

class TurkeyCard extends StatelessWidget {
  TurkeyCard(this.model, this.isLeft);
  final TurkeyModel model;
  final bool isLeft;

  static const double innerPadding = 20.0;
  static const double opacity = 0.75;
  static const double size = 250.0;

  @override
  Widget build(BuildContext context) {
    final Color color = isLeft ? Colors.indigo : Colors.blue;
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TurkeyDetail(model, color))),
      child: Padding(
        padding: const EdgeInsets.all(innerPadding),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Positioned.fill(
              bottom: innerPadding,
              left: isLeft ? innerPadding : 0.0,
              right: !isLeft ? innerPadding : 0.0,
              top: innerPadding,
              child: Card(
                elevation: 15.0,
                child: Hero(
                  tag: 'image_${model.id}',
                  child: Image.network(
                    model.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: Hero(
                tag: 'info_${model.id}',
                child: Card(
                  color: color.withOpacity(opacity),
                  margin: EdgeInsets.all(0.0),
                  elevation: 2.0,
                  shape: const Border(),
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: TurkeyInfoWidget(
                              model,
                              isLeftAligned: isLeft,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: isLeft ? Alignment.bottomRight : Alignment.bottomLeft,
              child: RawMaterialButton(
                onPressed: () {
                  Firestore.instance.runTransaction((transaction) async {
                    DocumentSnapshot freshSnap =
                        await transaction.get(model.snapshot.reference);
                    await transaction.update(
                        freshSnap.reference, {'count': freshSnap['count'] + 1});
                  });
                },
                shape: const CircleBorder(),
                constraints: BoxConstraints.tightFor(width: 60.0, height: 60.0),
                fillColor: Colors.white,
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
