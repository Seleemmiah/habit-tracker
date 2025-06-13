import 'package:isar/isar.dart';

// run cmd to generate the isar model
// flutter pub run build_runner build
part 'habit.g.dart';

@Collection()
class Habit {
  // habit id
  Id id = Isar.autoIncrement;

  // habit name
  late String name;

  // completion status
  List<DateTime> completedDates = [
    // datetime(year, moth, day)
    // datetime(2025, 1, 1)
    // datetime(2025, 1, 2)
  ];
}