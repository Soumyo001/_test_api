import 'package:basic_crud_operations/utils/constants.dart';

class User {
  final int userId;
  final String name;
  final String address;

  User({
    required this.userId,
    required this.name,
    required this.address,
  });

  User.fromJson(Map<String, Object?> json)
      : userId = json[userID] as int,
        name = json[userName] as String,
        address = json[userAddress] as String;

  Map<String, Object?> toJson() => {
        userID: userId,
        userName: name,
        userAddress: address,
      };
  @override
  bool operator ==(covariant User other) => userId == other.userId;

  @override
  String toString() => 'User ID = $userId, Name = $name, Address = $address';

  @override
  int get hashCode => userId.hashCode;
}
