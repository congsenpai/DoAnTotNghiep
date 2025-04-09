// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/user/user_bloc.dart';
import 'package:myparkingapp/bloc/user/user_event.dart';
import 'package:myparkingapp/bloc/user/user_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/screens/profile/profile_screen.dart';


class EditProfileScreen extends StatefulWidget {
  final UserResponse user;
  
  const EditProfileScreen({super.key, required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController homeAddressController;
  late TextEditingController companyAddressController;

  List<VehicleResponse> vehicles = [

  ];
  late UserResponse user;
  Uint8List? _imageBytes;
  String uploadedImageUrl = ""; // URL từ Cloudinary
  String publicId = "";
  final String defaultImageUrl =
    "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg";


  @override
  void initState() {
    super.initState();
    user = widget.user;
    _startInit();
  }

  void _startInit(){
    context.read<UserBloc>().add(LoadUserDataEvent(user.userID));
    usernameController = TextEditingController(text: user.username);
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);
    homeAddressController = TextEditingController(text: user.homeAddress);
    companyAddressController = TextEditingController(text: user.companyAddress);
        if(widget.user.avatar.url != null){
    uploadedImageUrl = widget.user.avatar.url!;
    publicId = widget.user.avatar.imageID;
    }
    else{
      publicId = DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  Future<void> _pickImage() async {
    final bytes = await ImagePickerWeb.getImageAsBytes();
    if (bytes != null) {
      setState(() {
        _imageBytes = bytes;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không có ảnh nào được chọn")),
      );
    }
  }

  void _showVehicleEditOrAdd(BuildContext context, VehicleResponse? vehicle) {
    VehicleType? selectedVehicleType = vehicle?.vehicleType ?? VehicleType.MOTORCYCLE;
    TextEditingController licensePlateController = TextEditingController(text: vehicle?.licensePlate ?? "");
    TextEditingController descriptionController = TextEditingController(text: vehicle?.description ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(vehicle == null ? AppLocalizations.of(context).translate("Add Vehicle") : AppLocalizations.of(context).translate("Edit Vehicle")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<VehicleType>(
              value: selectedVehicleType,
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() => selectedVehicleType = newValue);
                }
              },
              items: VehicleType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.toString().split('.').last));
              }).toList(),
            ),
            TextFormField(controller: licensePlateController, decoration: InputDecoration(labelText: AppLocalizations.of(context).translate("License Plate"))),
            TextFormField(controller: descriptionController, decoration: InputDecoration(labelText: AppLocalizations.of(context).translate("Description"))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context).translate("Cancel"))),
          ElevatedButton(
            onPressed: () {
              if (vehicle == null) {
                vehicles.add(VehicleResponse(vehicleId: "", vehicleType: selectedVehicleType!, licensePlate: licensePlateController.text, description: descriptionController.text));
              } else {
                vehicle.vehicleType = selectedVehicleType!;
                vehicle.licensePlate = licensePlateController.text;
                vehicle.description = descriptionController.text;
              }
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context).translate("Save")),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Update Profile")),
        backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                // ignore: deprecated_member_use
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context)
            ),
          ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            vehicles = state.vehicles;
            user = state.user;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: _imageBytes != null
                      ? Image.memory(_imageBytes!, fit: BoxFit.scaleDown)
                      : Image.network(defaultImageUrl, fit: BoxFit.scaleDown),
                    ),
                    SizedBox(height: 10),
                    TextButton.icon(
                        style: ButtonStyle(
                          iconColor: WidgetStateProperty.all(Colors.red),
                        ),
                        onPressed: () => _pickImage(),
                        icon: Icon(Icons.image),
                        label: Text(AppLocalizations.of(context).translate("Choose Image"), style: TextStyle(color: Colors.black)), 
                      ),
                  ],
                ),
              ),
                  Divider(),
                  ...[
                    usernameController, firstNameController, lastNameController,
                    emailController, phoneController, homeAddressController, companyAddressController
                  ].map((controller) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
                  )),
                  const SizedBox(height: 10),
                  Text("Vehicles:"),
                  Column(
                    children: vehicles.map((vehicle) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: ListTile(
                              title: Text(vehicle.licensePlate),
                              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () => _showVehicleEditOrAdd(context, vehicle)),
                            ),
                          ),
                          IconButton(onPressed: (){
                            context.read<UserBloc>().add(DeleteVehicle(vehicle.vehicleId));
                          }, icon: Icon(Icons.delete_forever)
                      )],
                      );
                    }).toList(),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showVehicleEditOrAdd(context, null),
                    icon: Icon(Icons.add_circle_outlined),
                    label: Text("Add Vehicle"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      UpdateUserRequest userUpdate = UpdateUserRequest(
                        userID: widget.user.userID,
                        username: usernameController.text.trim(),
                        password: widget.user.password,
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim(),
                        homeAddress: homeAddressController.text.trim(),
                        companyAddress: companyAddressController.text.trim(),
                        avatar: ImagesResponse(publicId, "", _imageBytes),
                        vehicles: vehicles,
                      );
                      context.read<UserBloc>().add(UpdateUserInfo(widget.user, userUpdate));
                    },
                    child: Text("Save Update"),
                  ),
                ],
              ),
            );
          }
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent, size: 18));
        },
        listener: (context, state) {
          if (state is UserSuccessState) {
            AppDialog.showSuccessEvent(context, state.mess,onPress: (){
              _startInit();
            });
          } else if (state is UserErrorState) {
            AppDialog.showErrorEvent(context, state.mess);
          }
        },
      ),
    );
  }
}
