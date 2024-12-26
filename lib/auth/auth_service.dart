import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../models/BasketItem.dart'; // Убедитесь, что вы импортируете модель BasketItem

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Список для хранения товаров в корзине
  List<BasketItem> _cartItems = [];

  // Метод для получения товаров в корзине
  List<BasketItem> get cartItems => _cartItems;

  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  String? getCurrentUserEmail() {
    final user = _firebaseAuth.currentUser;
    return user?.email;
  }

  String? getCurrentUserId() {
    final user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  // Метод для добавления товара в корзину
  void addToCart(BasketItem item) {
    _cartItems.add(item);
    notifyListeners(); // Уведомление слушателей о изменении состояния
  }

  // Метод для удаления товара из корзины
  void removeFromCart(BasketItem item) {
    _cartItems.remove(item);
    notifyListeners(); // Уведомление слушателей о изменении состояния
  }
}
