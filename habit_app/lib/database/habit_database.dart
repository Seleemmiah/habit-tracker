import 'package:flutter/cupertino.dart';
import 'package:habit_app/models/app_settings.dart';
import 'package:habit_app/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // set up

  // Initialize the Isar database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      HabitSchema,
      AppSettingsSchema,
    ], directory: dir.path);
  }

  // save first date of the app startup
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() async {
        await isar.appSettings.put(settings);
      });
    }
  }

  // Get the first launch date
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
     CRUD operations for Habit model

    */
  // Lists of habits
  final List<Habit> currentHabits = [];

  // create
  Future<void> addHabit(String habitName) async {
    // create a new havits
    final newHabit = Habit()..name = habitName;
    // ..completedDates = habit.completedDates;

    // save to Db
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from db
    readHabits();
  }

  // READ - read saved habits fromm db
  Future<void> readHabits() async {
    //fetch all habits from the database
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to currebt habits list
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    // update UI
    notifyListeners(); // notify listeners to update UI
  }

  // UPDATE - update habit
  Future<void> updateHabit(int id, bool isCompleted) async {
    // find the habit by id
    final habit = await isar.habits.get(id);

    // update the completion status
    if (habit != null) {
      await isar.writeTxn(() async{
        // if habit is completed  -> add current date to completedDates
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          // today
          final today = DateTime.now();
        }
      }
       );
    }
  }

  // delete
}
