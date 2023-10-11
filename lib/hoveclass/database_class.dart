
import 'package:hive/hive.dart';
part 'database_class.g.dart';


@HiveType(typeId: 0)
class contect extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String number;

  contect(this.name,this.number);

}