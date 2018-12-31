import 'package:outfitter/models/user.dart';

class Like {
  final User user;
  DateTime _dateCreated = DateTime.now();

  DateTime get dateCreated => _dateCreated;

  Like(this.user);
}
