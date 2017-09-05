// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Empty GridView', (WidgetTester tester) async {
    final List<Widget> children = <Widget>[
      const DecoratedBox(decoration: const BoxDecoration()),
      const DecoratedBox(decoration: const BoxDecoration()),
      const DecoratedBox(decoration: const BoxDecoration()),
      const DecoratedBox(decoration: const BoxDecoration()),
    ];

    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.ltr,
        child: new Center(
          child: new Container(
            width: 200.0,
            child: new GridView.extent(
              maxCrossAxisExtent: 100.0,
              shrinkWrap: true,
              children: children,
            ),
          ),
        ),
      ),
    );

    expect(tester.renderObjectList<RenderBox>(find.byType(DecoratedBox)), hasLength(4));

    for (RenderBox box in tester.renderObjectList<RenderBox>(find.byType(DecoratedBox))) {
      expect(box.size.width, equals(100.0), reason: "child width");
      expect(box.size.height, equals(100.0), reason: "child height");
    }

    final RenderBox grid = tester.renderObject(find.byType(GridView));
    expect(grid.size.width, equals(200.0), reason: "grid width");
    expect(grid.size.height, equals(200.0), reason: "grid height");

    expect(grid.debugNeedsLayout, false);

    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.ltr,
        child: new Center(
          child: new Container(
            width: 200.0,
            child: new GridView.extent(
              maxCrossAxisExtent: 60.0,
              shrinkWrap: true,
              children: children,
            ),
          ),
        ),
      ),
    );

    for (RenderBox box in tester.renderObjectList<RenderBox>(find.byType(DecoratedBox))) {
      expect(box.size.width, equals(50.0), reason: "child width");
      expect(box.size.height, equals(50.0), reason: "child height");
    }

    expect(grid.size.width, equals(200.0), reason: "grid width");
    expect(grid.size.height, equals(50.0), reason: "grid height");
  });
}
