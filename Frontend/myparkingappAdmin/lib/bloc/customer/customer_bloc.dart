import 'package:cloudinary/cloudinary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/customer/customer_event.dart';
import 'package:myparkingappadmin/bloc/customer/customer_state.dart';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/demodata.dart';
import 'package:myparkingappadmin/repository/imageRepository.dart';
import 'package:myparkingappadmin/repository/userRepository.dart';

class CustomerBloc extends Bloc<UserEvent, UserState> {
  CustomerBloc() : super(UserInitial()) {
    on<LoadedCustomerScreenEvent>(_loadedCustomerScreen);
    on<LoadedOwnerScreenEvent>(_loadedOwnerScreen);
    on<UpdateUserEvent>(_updateUser);
    on<UpdatedStatusUserEvent>(_updatedStatusUser);
    on<CreateParkingOwnerEvent>(_registerOwnerEvent);
  }
  void _loadedCustomerScreen(
      LoadedCustomerScreenEvent event, Emitter<UserState> emit) async {
    emit(CustomerLoadingState());
    //  UserRepository userRepository = UserRepository();
    //  try{
    //   ApiResult apiResult = await userRepository.getAllCustomerUser(event.searchCustomer);
    //   if(apiResult.code == 200){
    //     List<UserResponse> customerList = apiResult.result;
    //     emit(CustomerLoadedState(customerList));
    //   }else{
    //     emit(CustomerErrorState(apiResult.message));
    //  }}catch(e){
    //    emit(CustomerErrorState(e.toString()));
    //  }

    emit(CustomerLoadedState(users
        .where((i) =>
            i.lastName
                .toLowerCase()
                .contains(event.searchCustomer.toLowerCase()) ||
            i.firstName
                .toLowerCase()
                .contains(event.searchCustomer.toLowerCase()))
        .toList()));
  }

  void _loadedOwnerScreen(
      LoadedOwnerScreenEvent event, Emitter<UserState> emit) async {
    emit(CustomerLoadingState());
    //  UserRepository userRepository = UserRepository();
    //  try{
    //   ApiResult apiResult = await userRepository.getAllOwnerUser(event.searchOwner);
    //   if( apiResult.code == 200){
    //     List<UserResponse> ownerList = apiResult.result;
    //     emit(CustomerLoadedState(ownerList));
    //   }else{
    //     emit(OwnerErrorState(apiResult.message));
    //  }}catch(e){
    //    emit(OwnerErrorState(e.toString()));
    emit(CustomerLoadedState(owners
        .where((i) =>
            i.lastName
                .toLowerCase()
                .contains(event.searchOwner.toLowerCase()) ||
            i.firstName.toLowerCase().contains(event.searchOwner.toLowerCase()))
        .toList()));
  }
}

void _registerOwnerEvent(CreateParkingOwnerEvent event, Emitter<UserState> emit) async {
  UserRepository userRepository = UserRepository();
  ImageRepository imagerepository = ImageRepository();
  Cloudinary cloudinary = await imagerepository.getApiCloud();
  try {
    print("1");
    CloudinaryResponse uploadResponse = await imagerepository.uploadImage(
        cloudinary,
        event.request.avatar.imageBytes!,
        "myparkingapp/avatars",
        event.request.avatar.imageID,
        event.request.avatar.imageID);
    if (uploadResponse.isSuccessful) {
      Images image = Images(event.request.avatar.imageID, uploadResponse.url, null);
      CreateParkingOwnerRequest request = CreateParkingOwnerRequest(
          username: event.request.username,
          password: event.request.password,
          phoneNumber: event.request.phoneNumber,
          homeAddress: event.request.homeAddress,
          companyAddress: event.request.companyAddress,
          lastName: event.request.lastName,
          firstName: event.request.firstName,
          avatar: image,
          email: event.request.email);
      
      ApiResult apiResult = await userRepository.register(request);
      if (apiResult.code == 200) {
        print(apiResult.message);
        emit(OwnerSuccessState(apiResult.message));
      } else {
        emit(OwnerErrorState(apiResult.message));
      }
    }
    else{
      print("uploadResponse.error: ${uploadResponse.error}");
    }
  } catch (e) {
    emit(OwnerErrorState(e.toString()));
  }
}

void _updateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
  emit(CustomerLoadingState());
  UserRepository userRepository = UserRepository();
  try {
    ApiResult apiResult =
        await userRepository.updatedUser(event.request, event.userId);
    if (apiResult.code == 200) {
      emit(OwnerSuccessState(apiResult.message));
    } else {
      emit(OwnerErrorState(apiResult.message));
    }
  } catch (e) {
    emit(OwnerErrorState(e.toString()));
  }
}

void _updatedStatusUser(
    UpdatedStatusUserEvent event, Emitter<UserState> emit) async {
  emit(CustomerLoadingState());
  UserRepository userRepository = UserRepository();
  try {
    ApiResult apiResult =
        await userRepository.updatedStatusUser(event.userId, event.newStatus);
    if (apiResult.code == 200) {
      emit(OwnerSuccessState(apiResult.message));
    } else {
      emit(OwnerErrorState(apiResult.message));
    }
  } catch (e) {
    emit(OwnerErrorState(e.toString()));
  }
}