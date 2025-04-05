import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/bloc/customer/customer_event.dart';
import 'package:myparkingappadmin/bloc/customer/customer_state.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/network/api_result.dart';
import 'package:myparkingappadmin/repository/userRepository.dart';

class  CustomerBloc extends Bloc< UserEvent, UserState>{
   CustomerBloc():super(UserInitial()){
    on<LoadedCustomerScreenEvent>(_loadedCustomerScreen);
    on<LoadedOwnerScreenEvent>(_loadedOwnerScreen);
    on<RegisterOwnerEvent>(_registerOwnerEvent);
    on<UpdateUserEvent>(_updateUser);
    on<UpdatedStatusUserEvent>(_updatedStatusUser);
    
   }
  void _loadedCustomerScreen(LoadedCustomerScreenEvent event, Emitter<UserState> emit)async{
     emit(CustomerLoadingState());
     UserRepository userRepository = UserRepository();
     try{
      ApiResult apiResult = await userRepository.getAllCustomerUser(event.searchCustomer);
      if(apiResult.code == 200){
        List<UserResponse> customerList = apiResult.result;
        emit(CustomerLoadedState(customerList));
      }else{
        emit(CustomerErrorState(apiResult.message));
     }}catch(e){
       emit(CustomerErrorState(e.toString()));
     }
   }

  void _loadedOwnerScreen(LoadedOwnerScreenEvent event, Emitter<UserState> emit)async{
     emit(CustomerLoadingState());
     UserRepository userRepository = UserRepository();
     try{
      ApiResult apiResult = await userRepository.getAllOwnerUser(event.searchOwner);
      if( apiResult.code == 200){
        List<UserResponse> ownerList = apiResult.result;
        emit(CustomerLoadedState(ownerList));
      }else{
        emit(OwnerErrorState(apiResult.message));
     }}catch(e){
       emit(OwnerErrorState(e.toString()));
     }
   }

  void _registerOwnerEvent(RegisterOwnerEvent event, Emitter<UserState> emit)async{
     emit(CustomerLoadingState());
     UserRepository userRepository = UserRepository();
     try{
      ApiResult apiResult = await userRepository.register(event.request);
      if( apiResult.code == 200){
        emit(UserSuccessState(apiResult.message));
      }else{
        emit(OwnerErrorState(apiResult.message));
     }}catch(e){
       emit(OwnerErrorState(e.toString()));
     }
   }
  
  void _updateUser(UpdateUserEvent event, Emitter<UserState> emit)async{
     emit(CustomerLoadingState());
     UserRepository userRepository = UserRepository();
     try{
      ApiResult apiResult = await userRepository.updatedUser(event.request, event.userId);
      if( apiResult.code == 200){
        emit(UserSuccessState(apiResult.message));
      }else{
        emit(UserErrorState(apiResult.message));
     }}catch(e){
       emit(UserErrorState(e.toString()));
     }
   }

  void _updatedStatusUser(UpdatedStatusUserEvent event, Emitter<UserState> emit)async{
     emit(CustomerLoadingState());
     UserRepository userRepository = UserRepository();
     try{
      ApiResult apiResult = await userRepository.updatedStatusUser(event.userId, event.newStatus);
      if( apiResult.code == 200){
        emit(UserSuccessState(apiResult.message));
      }else{
        emit(UserErrorState(apiResult.message));
     }}catch(e){
       emit(UserErrorState(e.toString()));
     }
   }
}