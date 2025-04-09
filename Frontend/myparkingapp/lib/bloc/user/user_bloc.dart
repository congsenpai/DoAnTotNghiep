import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/user/user_event.dart';
import 'package:myparkingapp/bloc/user/user_state.dart';
import 'package:myparkingapp/components/api_result.dart';
import 'package:myparkingapp/data/repository/image_repository.dart';
import 'package:myparkingapp/data/repository/user_repository.dart';
import 'package:myparkingapp/data/repository/vehicle_repository.dart';
import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  UserBloc():super(UserInitialState()){
    on<UpdateUserInfo>(_updateUser);
    on<ChangePassword>(_changePassword);
    on<LoadUserDataEvent>(_loadStateInitial);
    on<AddNewVehicle>(_addNewVehicle);
    on<DeleteVehicle>(_deleteNewVehicle);

  }

  void _loadStateInitial(LoadUserDataEvent event, Emitter<UserState> emit) async{
    try{
      UserRepository userRepository = UserRepository();
      ApiResult userAPI = await userRepository.getUserById(event.userId);
      UserResponse user =  userAPI.result;
      emit(UserLoadedState(user.vehicles,user));
    }
    catch(e){
      throw Exception("UserBloc_updateUser : $e");
    }
    
  }

  void _updateUser(UpdateUserInfo event, Emitter<UserState> emit) async{
    try{
      emit(UserLoadingState());
      UserRepository user = UserRepository();
      ApiResult useApi = await user.updateUser(event.newUser);
      if(useApi.code == 200){
        emit(UserSuccessState(useApi.message));
      }
      else{
        emit(UserErrorState(useApi.message));
      }
      ImageRepository imagerepository = ImageRepository();
      Cloudinary cloudinary = await imagerepository.getApiCloud();
      CloudinaryResponse uploadResponse = await imagerepository.uploadImage(
          cloudinary,
          event.newUser.avatar.imageBytes!,
          "myparkingapp/avatars",
          event.newUser.avatar.imageID,
          event.newUser.avatar.imageID);
      if (uploadResponse.isSuccessful) {
        ImagesResponse image = ImagesResponse(event.newUser.avatar.imageID, uploadResponse.url, null);
        emit(UserSuccessState(
            "Successful Upload"));
      } else {
        emit(UserErrorState(
            "Falsed Upload : ${uploadResponse.error}"));
      }
    }
    catch(e){
      throw Exception("UserBloc_updateUser : $e");
    }
  }

  void _changePassword(ChangePassword event, Emitter<UserState> emit) async{
    try{
      emit(UserLoadingState());
      UserRepository user = UserRepository();
      ApiResult useApi = await user.changePass(event.user.userID, event.oldPass, event.newPass);
      if(useApi.code == 200){
        emit(UserSuccessState(useApi.message));

      }
      else{
        emit(UserErrorState(useApi.message));
      }
    }
    catch(e){
      throw Exception("UserBloc_ChangePassword: $e");
    }
  }

  void _addNewVehicle(AddNewVehicle event, Emitter<UserState> emit) async{
    try{
      VehicleRepository vehicle = VehicleRepository();
      ApiResult useApi = await vehicle.addVehicle(event.vehicle, event.user);
      if(useApi.code == 200){
        emit(UserSuccessState(useApi.message));
      }
      else{
        emit(UserErrorState(useApi.message));
      }
    }
    catch(e){
      throw Exception("UserBloc_addNewVehicle: $e");
    }
  }
  void _deleteNewVehicle(DeleteVehicle event, Emitter<UserState> emit) async{
    try{
      VehicleRepository vehicle = VehicleRepository();
      ApiResult useApi = await vehicle.deleteVehicle(event.vehicleID);
      if(useApi.code == 200){
        emit(UserSuccessState(useApi.message));
      }
      else{
        emit(UserErrorState(useApi.message));
      }
    }
    catch(e){
      throw Exception("UserBloc_deleteNewVehicle: $e");
    }
  }
}