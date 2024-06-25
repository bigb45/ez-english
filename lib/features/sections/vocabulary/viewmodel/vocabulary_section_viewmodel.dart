import 'dart:async';

import 'package:ez_english/core/constants.dart';
import 'package:ez_english/core/firebase/exceptions.dart';
import 'package:ez_english/core/firebase/firebase_authentication_service.dart';
import 'package:ez_english/core/firebase/firestore_service.dart';
import 'package:ez_english/features/models/base_answer.dart';
import 'package:ez_english/features/models/base_question.dart';
import 'package:ez_english/features/models/base_viewmodel.dart';
import 'package:ez_english/features/models/user.dart';
import 'package:ez_english/features/sections/components/evaluation_section.dart';
import 'package:ez_english/features/sections/models/word_definition.dart';
import 'package:ez_english/utils/utils.dart';

import '../../models/word_model.dart';

class VocabularySectionViewmodel extends BaseViewModel {
  late List<WordModel> _words;
  String? levelId;
  String? _levelName;
  UserModel? _userData;
  String? get levelName => _levelName;
  List<BaseQuestion?> _questions = [];

  List<BaseQuestion?> get questions => _questions;
  get words => _words;
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  @override
  FutureOr<void> init() {
    _words = const [
      WordModel(word: "View", type: WordType.verb, isNew: false),
      WordModel(word: "View", type: WordType.verb, isNew: false),
      WordModel(word: "View", type: WordType.verb, isNew: false),
      WordModel(word: "View", type: WordType.verb, isNew: false),
      WordModel(word: "View", type: WordType.verb, isNew: false),
      WordModel(word: "View", type: WordType.verb, isNew: false),
    ];
  }

  void setValuesAndInit() async {
    currentIndex = 0;
    _levelName = RouteConstants.getLevelName(levelId!);
    await getUserData(_firebaseAuthService.getUser()!.uid);
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    isLoading = true;
    // int lastQuestionIndex = _userData!.levelsProgress![levelName]!
    //     .sectionProgress![_sectionName]!.lastStoppedQuestionIndex;
    try {
      _questions = await firestoreService.fetchQuestions(
        RouteConstants.vocabularySectionName,
        _levelName!,
        0,
      );

      error = null;
    } on CustomException catch (e) {
      // error = e as CustomException;
      _handleError(e.message);
      notifyListeners();
    } catch (e) {
      // TODO: assign error to 'error' variable here and handle state in UI
      // error = CustomException(e.toString());
      _handleError("An undefined error occurred ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _handleError(String e) {
    // TODO: separate UI logic from business logic
    Utils.showSnackBar(e);
  }

  Future<void> getUserData(String userId) async {
    _userData = await _firestoreService.getUser(userId);
  }
}
