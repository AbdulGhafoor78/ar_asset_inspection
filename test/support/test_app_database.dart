
import 'package:drift/native.dart';

import 'package:ar_asset_inspection/core/database/app_database.dart';

class TestAppDatabase extends AppDatabase {
  TestAppDatabase() : super.forTesting(NativeDatabase.memory());
}
