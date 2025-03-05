
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/blocs/user/userEvent.dart';
import 'package:myparkingapp/blocs/user/userState.dart';


import '../../../blocs/user/userBloc.dart';
import '../../../data/model/user.dart';


class UpdateUserProfile extends StatefulWidget {
  final String token;
  final User user;
  const UpdateUserProfile({super.key, required this.user, required this.token});

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  late TextEditingController _userName;
  late TextEditingController _email;
  late TextEditingController _phone;
  late TextEditingController _avatar;
  late TextEditingController _homeAddress;
  late TextEditingController _companyAddress;
  late TextEditingController _firstName;
  late TextEditingController _lastName;

  late User user = widget.user;
  @override
  void initState() {

    super.initState();
    // Khởi tạo TextEditingController
    _userName = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _avatar = TextEditingController();
    _homeAddress = TextEditingController();
    _companyAddress = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(AppLocalizations.of(context).translate('My Profile'))),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            user = state.userModel;
            // Gán dữ liệu cho TextEditingController
            _userName.text = user.username;
            _lastName.text = user.lastName;
            _firstName.text = user.firstName;
            _email.text = user.email;
            _phone.text = user.phoneNumber;
            _avatar.text = user.avatar;
            _homeAddress.text = user.companyAddress;
            _companyAddress.text = user.companyAddress;

          } else if (state is UserLoadingState) {
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
                      controller: _homeAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('Avatar'),
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    SizedBox(height: Get.width / 30),
                    TextField(
                      controller: _companyAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).translate('Avatar'),
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    SizedBox(height: Get.width / 30),
                    ElevatedButton(
                      onPressed: () {
                        User user = User(
                            userId: '',
                            username: _userName.text,
                            password: '',
                            phoneNumber: _phone.text,
                            homeAddress: _homeAddress.text,
                            companyAddress: _companyAddress.text,
                            lastName: _lastName.text,
                            firstName: _firstName.text,
                            avatar: _avatar.text,
                            email: _email.text,
                            status: UserStatus.ACTIVE,
                            roles: []);
                        context.read<UserBloc>().add(UpdateUser(
                          user,widget.token
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
          if (state is UserErrorState) {
            UserErrorState('Loading Data was false');
          }
        },
      ),
      // bottomNavigationBar: footerWidget(userID: widget.UserID, userName: _userName.text,),
    );
  }

}


