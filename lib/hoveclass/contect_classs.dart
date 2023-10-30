import 'package:hive/hive.dart';

import 'database_class.dart';

class boxes {

  static Box<contect> getdata() => Hive.box("cont");
}