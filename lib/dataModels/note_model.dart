
import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String descr;
  @HiveField(3)
  final String selectedTime;
  @HiveField(4)
  final String selectedDate;
  @HiveField(5)
  final int repeatOn;

  NoteModel(this.title, this.descr, this.selectedDate, this.selectedTime, this.repeatOn, this.id);

}