// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myparkingappadmin/dto/response/user.dart';
import '../../../../constants.dart';
import '../../../app/localization/app_localizations.dart';


class CustomerDetail extends StatefulWidget {

  final String title;
  final bool isImage;
  final User object;

  const CustomerDetail({
    super.key,
    required this.object,
    required this.isImage,
    required this.title,

  });

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate(widget.title),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        // Add your save functionality here
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Add your delete functionality here
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (widget.isImage && widget.object.avatar.isNotEmpty)
              Center(
                child: widget.object.avatar.startsWith('http')
                    ? Image.network(widget.object.avatar, width: 100, height: 100, fit: BoxFit.cover)
                    : Image.asset(widget.object.avatar, width: 100, height: 100, fit: BoxFit.cover),
              ),
            SizedBox(height: defaultPadding),
            ObjectDetailInfor(objectInfo: widget.object),
          ],
        ),
      ),
    );
  }
}


class ObjectDetailInfor extends StatefulWidget {
  final User objectInfo;

  const ObjectDetailInfor({super.key, required this.objectInfo});

  @override
  State<ObjectDetailInfor> createState() => _ObjectDetailInforState();
}

class _ObjectDetailInforState extends State<ObjectDetailInfor> {
  late TextEditingController _lastnameController;
  late TextEditingController _firstnameController;
  late TextEditingController _emailController;
  late TextEditingController _homeAddressController;
  late TextEditingController _companyAddressController;
  late TextEditingController _numberPhoneController;
  late TextEditingController _avatarController; // Thêm controller cho avatar URL

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeControllers(widget.objectInfo);
  }
  @override
  void didUpdateWidget(covariant ObjectDetailInfor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.objectInfo != widget.objectInfo) {
      _initializeControllers(widget.objectInfo);
    }
  }

  void _initializeControllers(User objectInfo) {
    _lastnameController = TextEditingController(text: objectInfo.lastName);
    _firstnameController = TextEditingController(text: objectInfo.firstName);
    _emailController = TextEditingController(text: objectInfo.email);
    _homeAddressController = TextEditingController(text: objectInfo.homeAddress);
    _companyAddressController = TextEditingController(text: objectInfo.companyAddress);
    _numberPhoneController = TextEditingController(text: objectInfo.phoneNumber);
    _avatarController = TextEditingController(text: objectInfo.avatar); // Hiển thị đường link ảnh
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarController.text = pickedFile.path; // Cập nhật TextField với đường dẫn ảnh
      });
    }
  }

  @override
  void dispose() {
    _lastnameController.dispose();
    _firstnameController.dispose();
    _emailController.dispose();
    _homeAddressController.dispose();
    _companyAddressController.dispose();
    _numberPhoneController.dispose();
    _avatarController.dispose(); // Giải phóng bộ nhớ
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: defaultPadding),
          TestFiles(editController: _lastnameController, title: 'LastName', width: double.infinity,),
          SizedBox(height: defaultPadding),
          TestFiles(editController: _firstnameController, title: 'FirstName', width: double.infinity,),
          SizedBox(height: defaultPadding),
          TestFiles(editController: _homeAddressController, title: 'HomeAddress', width: double.infinity,),
          SizedBox(height: defaultPadding),
          TestFiles(editController: _companyAddressController, title: 'CompanyAddress', width: double.infinity,),
          SizedBox(height: defaultPadding),
          TestFiles(editController: _emailController, title: 'Email', width: double.infinity,),
          SizedBox(height: defaultPadding),
          TestFiles(editController: _numberPhoneController, title: 'Phone', width: double.infinity,),
          SizedBox(height: defaultPadding),

          // TextField để hiển thị đường dẫn ảnh
          Row(
            children: [
              TestFiles(editController: _avatarController, title: 'Avatar URL', width: Get.width/3,),
              SizedBox(width: defaultPadding),
              TextButton.icon(
                style: ButtonStyle(
                  iconColor: WidgetStateProperty.all(Colors.red),
                ),
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text(AppLocalizations.of(context).translate("Choose Image"), style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary
                ),),
              ),
            ],
          ),
          
          SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}

class TestFiles extends StatelessWidget {
  final TextEditingController editController;
  final String title;
  final double width; 

  const TestFiles({
    super.key,
    required this.editController,
    required this.title, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: editController,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(title),
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
