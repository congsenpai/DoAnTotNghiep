import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_bloc.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_event.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';
import 'package:provider/provider.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';

import '../../../../constants.dart';

class UserDetail extends StatefulWidget {
  final UserResponse user;
  VoidCallback? onEdit;

  UserDetail({
    super.key,
    required this.user,
    this.onEdit,
  });

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  bool isEdit = false;
  late TextEditingController _userNameController;
  late TextEditingController _lastnameController;
  late TextEditingController _firstnameController;
  late TextEditingController _emailController;
  late TextEditingController _homeAddressController;
  late TextEditingController _companyAddressController;
  late TextEditingController _numberPhoneController;
  late TextEditingController _avatarController;
  late TextEditingController _roleController;
  late TextEditingController _statusController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _userNameController = TextEditingController(text: widget.user.username);
    _lastnameController = TextEditingController(text: widget.user.lastName);
    _firstnameController = TextEditingController(text: widget.user.firstName);
    _emailController = TextEditingController(text: widget.user.email);
    _homeAddressController = TextEditingController(text: widget.user.homeAddress);
    _companyAddressController = TextEditingController(text: widget.user.companyAddress);
    _numberPhoneController = TextEditingController(text: widget.user.phoneNumber);
    _avatarController = TextEditingController(text: widget.user.avatar);
    _roleController = TextEditingController(text: widget.user.roles.join(", "));
    _statusController = TextEditingController(text: widget.user.status.name);
  }

  Future<void> _pickImage(bool isEdit) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && isEdit) {
      setState(() {
        _avatarController.text = pickedFile.path;
      });
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _lastnameController.dispose();
    _firstnameController.dispose();
    _emailController.dispose();
    _homeAddressController.dispose();
    _companyAddressController.dispose();
    _numberPhoneController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ❌ Không hiển thị nút back
        title: Text(
          "${widget.user.username} / ${AppLocalizations.of(context).translate("User Detail")}",
        ),
        actions: [
          isEdit
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    final UpdateInfoResquest request = UpdateInfoResquest(
                      username: _userNameController.text,
                      password: widget.user.password,
                      phoneNumber: _numberPhoneController.text,
                      homeAddress: _homeAddressController.text,
                      companyAddress: _companyAddressController.text,
                      lastName: _lastnameController.text,
                      firstName: _firstnameController.text,
                      avatar: _avatarController.text,
                      email: _emailController.text,
                    );

                    context.read<MainAppBloc>().add(
                          UpdatesUserInforEvent(widget.user.userId, request),
                        );

                    setState(() {
                      isEdit = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEdit = true;
                    });
                    widget.onEdit?.call();
                  },
                ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: defaultPadding),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.user.avatar),
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: TextFieldCustom(
                      editController: _roleController,
                      title: "Role",
                      isEdit: false,
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: TextFieldCustom(
                      editController: _statusController,
                      title: "Status",
                      isEdit: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'UserName', editController: _userNameController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'LastName', editController: _lastnameController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'FirstName', editController: _firstnameController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'HomeAddress', editController: _homeAddressController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'CompanyAddress', editController: _companyAddressController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'Email', editController: _emailController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'Phone', editController: _numberPhoneController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFieldCustom(
                      title: 'Avatar URL',
                      editController: _avatarController,
                      isEdit: isEdit,
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 1,
                    child: TextButton.icon(
                      style: ButtonStyle(
                        iconColor: WidgetStateProperty.all(Colors.red),
                      ),
                      onPressed: () => _pickImage(isEdit),
                      icon: Icon(Icons.image),
                      label: Text(AppLocalizations.of(context).translate("Choose Image")),
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
