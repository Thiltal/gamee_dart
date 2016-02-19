// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library gamee.test;

import 'package:gamee/gamee.dart';
import 'package:test/test.dart';

void main() {
  group('Wrapper test', () {
    Gamee gamee;

    setUp(() {
      gamee = new Gamee();
    });

    test('First Test', () {
      gamee.paused = true;
      expect(gamee.paused, isTrue);
      // Not possible ... browser tests will be necessary
      // TODO: implement browser tests
    });
  });
}
