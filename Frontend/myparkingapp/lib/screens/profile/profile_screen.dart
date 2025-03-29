import 'package:flutter/material.dart';
import 'package:myparkingapp/data/response/user__response.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  final UserResponse user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user: user,),
    );
  }
}
