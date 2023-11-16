// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebasematerial/model/contact_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Test data
  final contact1 = ContactModel(
    id: '1',
    name: 'Alice',
    phone: '1234567890',
    email: 'alice@example.com',
    address: 'Street A',
  );
  final contact2 = ContactModel(
    id: '2',
    name: 'Bob',
    phone: '0987654321',
    email: 'bob@example.com',
    address: 'Street B',
  );
  final contact3 = ContactModel(
    id: null,
    name: 'Charlie',
    phone: '1111111111',
    email: 'charlie@example.com',
    address: 'Street C',
  );

  // Test group for ContactModel class
  group('ContactModel', () {
    // Test constructor
    test('constructor should create a valid contact model', () {
      expect(contact1.id, '1');
      expect(contact1.name, 'Alice');
      expect(contact1.phone, '1234567890');
      expect(contact1.email, 'alice@example.com');
      expect(contact1.address, 'Street A');
    });

    // Test toMap method
    test('toMap should return a map representation of the contact model', () {
      final map = contact1.toMap();
      expect(map['id'], '1');
      expect(map['name'], 'Alice');
      expect(map['phone'], '1234567890');
      expect(map['email'], 'alice@example.com');
      expect(map['address'], 'Street A');
    });

    // Test fromMap factory
    test('fromMap should return a contact model from a map', () {
      final map = {
        'id': '2',
        'name': 'Bob',
        'phone': '0987654321',
        'email': 'bob@example.com',
        'address': 'Street B',
      };
      final contact = ContactModel.fromMap(map);
      expect(contact.id, '2');
      expect(contact.name, 'Bob');
      expect(contact.phone, '0987654321');
      expect(contact.email, 'bob@example.com');
      expect(contact.address, 'Street B');
    });

    // Test toJson method
    test('toJson should return a json string representation of the contact model', () {
      final json = contact1.toJson();
      expect(json, '{"id":"1","name":"Alice","phone":"1234567890","email":"alice@example.com","address":"Street A"}');
    });

    // Test fromJson factory
    test('fromJson should return a contact model from a json string', () {
      final json = '{"id":"2","name":"Bob","phone":"0987654321","email":"bob@example.com","address":"Street B"}';
      final contact = ContactModel.fromJson(json);
      expect(contact.id, '2');
      expect(contact.name, 'Bob');
      expect(contact.phone, '0987654321');
      expect(contact.email, 'bob@example.com');
      expect(contact.address, 'Street B');
    });
  });
}