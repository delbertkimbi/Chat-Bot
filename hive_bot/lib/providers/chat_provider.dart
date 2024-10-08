import 'package:flutter/material.dart';
import 'package:hive_bot/Models/message.dart';
import 'package:hive_bot/constants.dart';
import 'package:hive_bot/hive/chat_history.dart';
import 'package:hive_bot/hive/settings.dart';
import 'package:hive_bot/hive/user_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatProvider extends ChangeNotifier {
  //List of messages
  List<Message> _inChatMessages = [];
  //page controller
  final PageController _pageController = PageController();
  //image file list
  List<XFile>? _imageFileList = [];

  //index of current screen
  int _currentIndex = 0;

  //current chatId
  String _currentChatId = '';

  //initialize generative model
  GenerativeModel? _model;

  //initialize text model
  GenerativeModel? _textModel;

  //initialize vision model
  GenerativeModel? _visionModel;

  //current mode
  String _modelType = 'gemini-pro';

  //loading bool
  bool _isLoading = false;

  //getters
  List<Message> get inChatMessages => _inChatMessages;
  PageController get pageController => _pageController;
  List<XFile>? get imageFileList => _imageFileList;
  int get currentIndex => _currentIndex;
  String get currentChatId => _currentChatId;
  GenerativeModel? get model => _model;
  GenerativeModel? get textModel => _textModel;
  GenerativeModel? get visionModel => _visionModel;
  bool get isLoading => _isLoading;

  

  //init Hive box
  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.gemeniDB);
    //register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryAdapter());
      //open the chat history box
      await Hive.openBox<ChatHistory>(Constants.chatHistoryBox);
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
      Hive.openBox<UserModel>(Constants.userBox);
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SettingsAdapter());
      Hive.openBox<Settings>(Constants.settingsBox);
    }
  }
}
