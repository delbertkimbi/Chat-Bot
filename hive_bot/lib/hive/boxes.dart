import 'package:hive/hive.dart';
import 'package:hive_bot/constants.dart';
import 'package:hive_bot/hive/chat_history.dart';
import 'package:hive_bot/hive/settings.dart';
import 'package:hive_bot/hive/user_model.dart';

class Boxes {
  //get chatHistory box
  static Box<ChatHistory> getChatHistore() =>
      Hive.box<ChatHistory>(Constants.chatHistoryBox);

  //get useModel box
  static Box<UserModel> getUser() => Hive.box<UserModel>(Constants.userBox);

  // get settings box
  static Box<Settings> getSettings() =>
      Hive.box<Settings>(Constants.settingsBox);
}
