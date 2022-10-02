import 'package:flutter/material.dart';
import '../../../models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: 'shrouk mohamed',
      phone: '+01211611162',
    ),
    UserModel(
      id: 2,
      name: 'bahaa mohamed',
      phone: '+01211611162',
    ),
    UserModel(
      id: 3,
      name: 'mahmoud mohamed',
      phone: '+01211611162',
    ),
    UserModel(
      id: 4,
      name: 'mohamed zaki',
      phone: '+01211611162',
    ),
    UserModel(
      id: 5,
      name: 'esraa eid',
      phone: '+01211611162',
    ),
    UserModel(
      id: 6,
      name: 'hoda ramadan',
      phone: '+01211611162',
    ),
    UserModel(
      id: 7,
      name: 'Amira ramadan',
      phone: '+01211611162',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
