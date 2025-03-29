import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/user/user_bloc.dart';
import 'package:myparkingapp/bloc/user/user_event.dart';
import 'package:myparkingapp/bloc/user/user_state.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/user__response.dart';
import 'package:myparkingapp/data/response/vehicle__response.dart';


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
  String? avatar;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUserDataEvent(widget.user.vehicles));
    
    usernameController = TextEditingController(text: widget.user.username);
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
    homeAddressController = TextEditingController(text: widget.user.homeAddress);
    companyAddressController = TextEditingController(text: widget.user.companyAddress);
    avatar = widget.user.avatar.url;
  }

  Future<String?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path;
  }

  void _showVehicleEditOrAdd(BuildContext context, VehicleResponse? vehicle) {
    VehicleType? selectedVehicleType = vehicle?.vehicleType ?? VehicleType.MOTORCYCLE;
    TextEditingController licensePlateController = TextEditingController(text: vehicle?.licensePlate ?? "");
    TextEditingController descriptionController = TextEditingController(text: vehicle?.description ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(vehicle == null ? "Add Vehicle" : "Edit Vehicle"),
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
            TextFormField(controller: licensePlateController, decoration: InputDecoration(labelText: "License Plate")),
            TextFormField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (vehicle == null) {
                vehicles.add(VehicleResponse(vehicleId: "", vehicleType: selectedVehicleType!, licensePlate: licensePlateController.text, description: descriptionController.text));
              } else {
                vehicle.vehicleType = selectedVehicleType!;
                vehicle.licensePlate = licensePlateController.text;
                vehicle.description = descriptionController.text;
              }
              context.read<UserBloc>().add(LoadUserDataEvent(vehicles));
              Navigator.pop(context);
            },
            child: Text("Save"),
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            vehicles = state.vehicles;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final newAvatar = await pickImage();
                      if (newAvatar != null) {
                        setState(() => avatar = newAvatar);
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: avatar != null ? NetworkImage(avatar!) : AssetImage("assets/images/Banner.png") as ImageProvider,
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
                        avatar: avatar != null ? ImagesResponse(url: avatar!) : widget.user.avatar,
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.mess)));
          } else if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.mess)));
          }
        },
      ),
    );
  }
}
