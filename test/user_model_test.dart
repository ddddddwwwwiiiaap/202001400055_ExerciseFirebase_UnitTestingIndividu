// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasematerial/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements User {}

void main() {
  group('UserModel', () {
    test('toMap returns a map with the correct data', () {
      final user = UserModel(name: 'Alice', email: 'alice@example.com', uId: '123');
      final expectedMap = <String, dynamic>{
        'name': 'Alice',
        'email': 'alice@example.com',
        'uId': '123',
      };
      expect(user.toMap(), expectedMap);
    });

    test('fromMap creates a user model from a map', () {
      final map = <String, dynamic>{
        'name': 'Bob',
        'email': 'bob@example.com',
        'uId': '456',
      };
      final user = UserModel.fromMap(map);
      expect(user.name, 'Bob');
      expect(user.email, 'bob@example.com');
      expect(user.uId, '456');
    });

    test('toJson returns a json string with the correct data', () {
      final user = UserModel(name: 'Charlie', email: 'charlie@example.com', uId: '789');
      final expectedJson = '{"name":"Charlie","email":"charlie@example.com","uId":"789"}';
      expect(user.toJson(), expectedJson);
    });

    test('fromJson creates a user model from a json string', () {
      final json = '{"name":"David","email":"david@example.com","uId":"1011"}';
      final user = UserModel.fromJson(json);
      expect(user.name, 'David');
      expect(user.email, 'david@example.com');
      expect(user.uId, '1011');
    });
  });
}