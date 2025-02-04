
// ignore_for_file: non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/blocs/user/user_bloc.dart';
import 'package:myparkingapp/blocs/user/user_event.dart';
import 'package:myparkingapp/blocs/user/user_state.dart';
import 'package:myparkingapp/data/models/User.dart';


class UpdateUserProfile extends StatefulWidget {
  final String UserID;
  final String bearerToken;
  const UpdateUserProfile({super.key, required this.UserID, required this.bearerToken});

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  late TextEditingController _userName;
  late TextEditingController _email;
  late TextEditingController _phone;
  late TextEditingController _avatar;
  late TextEditingController _address;
  late TextEditingController _firstName;
  late TextEditingController _lastName;

  late User user = User(
    username: '',
    password: '',
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    address: '',
    roles: {"ADMIN"},
    status: true,
    avatar: "",
    createdDate: DateTime.now(),
    updatedDate: DateTime.now());
  @override
  void initState() {

    super.initState();
    // Khởi tạo TextEditingController
    _userName = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _avatar = TextEditingController();
    _address = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    context.read<UserBloc>().add(InitstateEvent(widget.UserID,widget.bearerToken));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(AppLocalizations.of(context).translate('My Profile'))),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            user = state.userModel;
            // Gán dữ liệu cho TextEditingController
            _userName.text = user.username;
            _lastName.text = user.lastName;
            _firstName.text = user.firstName;
            _email.text = user.email;
            _phone.text = user.phone;
            _avatar.text = user.avatar;
            _address.text = user.address;

          } else if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(Get.width / 20),
              margin: EdgeInsets.only(top: Get.width / 20, bottom: Get.width / 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Get.width / 30),
// 1. user :
                    TextField(
                      controller: _userName,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('UserName'),
                        border: const OutlineInputBorder(),
                      ),
                    ),

// 2. first name :
                    SizedBox(height: Get.width / 30),
                    TextField(
                      controller: _firstName,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('FirstName'),
                        border: const OutlineInputBorder(),
                      ),
                    ),
// 3. last name
                    SizedBox(height: Get.width / 30),
                    TextField(
                      controller: _lastName,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('LastName'),
                        border: const OutlineInputBorder(),
                      ),
                    ),
// 4. email                    
                    SizedBox(height: Get.width / 30),
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('Email'),
                        border: const OutlineInputBorder(),
                      ),
                    ),
// 5. phone
                    SizedBox(height: Get.width / 30),
                    TextField(
                      controller: _phone,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('Phone'),
                        border: const OutlineInputBorder(),
                      ),
                    ),
// 6. avatar
                    SizedBox(height: Get.width / 30),
                    TextField(
                      controller: _avatar,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('Avatar'),
                        border: const OutlineInputBorder(),
                      ),
                    ),
// 7. address
                    SizedBox(height: Get.width / 30),
                    TextField(
                      controller: _address,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('Avatar'),
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    SizedBox(height: Get.width / 30),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(ChangeProfileEvent(
                          widget.UserID,
                          _userName.text,
                          _lastName.text,
                          _firstName.text,
                          _email.text,
                          _phone.text,
                          _avatar.text,
                          _address.text,
                        ));
                      },
                      child: const Center(
                        child: Text("Update"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is UserError) {
            UserError('Loading Data was false');
          }
        },
      ),
      // bottomNavigationBar: footerWidget(userID: widget.UserID, userName: _userName.text,),
    );
  }

}


