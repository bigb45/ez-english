import 'package:easy_localization/easy_localization.dart';
import 'package:ez_english/core/firebase/firebase_authentication_service.dart';
import 'package:ez_english/core/firebase/firestore_service.dart';
import 'package:ez_english/features/models/user.dart';
import 'package:ez_english/router.dart';
import 'package:ez_english/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();
  bool errorOccurred = false;

  User? _user;

  User? get user => _user;

  UserModel? _userDate;
  UserModel? get userDate => _userDate;

  bool get isSignedIn => _user != null;
  // bool get isSignedIn => true;
  AuthViewModel() {
    _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> signIn(UserModel user, BuildContext context) async {
    // TODO change the lodaing design
    _showDialog(context);
    errorOccurred = false;
    try {
      await _firebaseAuthService.signIn(user);
      if (isSignedIn) {
        _userDate = await _firestoreService.getUser(_user!.uid);
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      errorOccurred = true;
      _handleError(e);
    }
    if (!errorOccurred) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  Future<void> signUp(UserModel user, BuildContext context) async {
    _showDialog(context);
    errorOccurred = false;
    try {
      UserCredential? userCredential = await _firebaseAuthService.signUp(user);
      if (userCredential == null) return;
      if (userCredential.user != null) {
        user.id = userCredential.user!.uid;
        user.assignedLevels = [];
        await _firestoreService.addUser(user);
      }
    } on FirebaseAuthException catch (e) {
      errorOccurred = true;
      _handleError(e);
    }

    if (isSignedIn) {
      _userDate = await _firestoreService.getUser(_user!.uid);
      notifyListeners();
    }
    if (!errorOccurred) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    _showDialog(context);
    errorOccurred = false;

    try {
      await _firebaseAuthService.resetPassword(email);
    } on FirebaseAuthException catch (e) {
      errorOccurred = true;
      _handleError(e);
    }
    if (!errorOccurred) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  Future<void> signOut(BuildContext context) async {
    errorOccurred = false;
    try {
      await _firebaseAuthService.signOut();
    } on FirebaseAuthException catch (e) {
      errorOccurred = true;
      _handleError(e);
    }
    if (!errorOccurred) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }

  void _handleError(FirebaseAuthException e) {
    Utils.showSnackBar(e.message);
    errorOccurred = true;
    navigatorKey.currentState!.pop();
  }
}
