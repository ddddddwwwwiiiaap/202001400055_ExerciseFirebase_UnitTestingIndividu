import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebasematerial/controller/auth_controller.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late AuthController authController;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth();
    authController = AuthController(auth, fakeFirestore.collection('users'));
  });

  group('AuthController Tests', () {
    test('Register with Email and Password Test', () async {
      final user = await authController.registerWithEmailAndPassword(
        'test@example.com',
        'password',
        'Test User',
      );

      expect(user, isNotNull);
      expect(user!.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.uId.isNotEmpty, true);

      final savedUserSnapshot =
          await fakeFirestore.collection('users').doc(user.uId).get();
      expect(savedUserSnapshot.exists, true);
    });

    test('Sign In with Incorrect Credentials Test', () async {
      final wrongCredentials = await authController.signInWithEmailAndPassword(
        'nonexistent@example.com', // Non-existent user
        'wrongpassword',
      );

      expect(wrongCredentials, isNull);
    });

    test('Sign Out Test', () async {
      await authController.signOut();
      final currentUser = authController.getCurrentUser();

      expect(currentUser, isNull);
    });

    test('Sign In with Email and Password Test', () async {
      // Add a new user for login testing
      await authController.registerWithEmailAndPassword(
        'test_login@example.com',
        'password',
        'Login User',
      );

      final loggedInUser = await authController.signInWithEmailAndPassword(
        'test_login@example.com',
        'password',
      );

      expect(loggedInUser, isNotNull);
      expect(loggedInUser!.email, 'test_login@example.com');
      expect(loggedInUser.name, 'Login User');
      expect(loggedInUser.uId.isNotEmpty, true);
    });

    test('Get Current User Test', () {
      final currentUser = authController.getCurrentUser();

      // Ensure current user is null as no one is logged in yet
      expect(currentUser, isNull);
    });
  });
}