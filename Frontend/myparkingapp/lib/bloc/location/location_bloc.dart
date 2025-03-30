import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:myparkingapp/bloc/location/location_event.dart';
import 'package:myparkingapp/bloc/location/location_state.dart';
import 'package:myparkingapp/data/api_service/tomtom_map/distance_calculator.dart';
import 'package:myparkingapp/data/api_service/tomtom_map/map_widget.dart';

class LocationBloc extends Bloc<LocationEvent,LocationState>{
  LocationBloc():super(LocationInitialState()){
    on<GetLocationEvent>(_getCurrentLocation);
    on<GetCurrentDistance>(_getCurrentDistance);
    on<GetRouterEvent>(_getRoute);
  }
  void _getCurrentLocation(GetLocationEvent event, Emitter<LocationState> emit) async{
    try{
      emit(LocationLoading());
      late MapWidget acceptLocationPremission = MapWidget(endPoint:  LatLng(21.0285, 105.8542));
      bool check = await acceptLocationPremission.checkLocationPermission();
      if(check == true){
        emit(LocationSuccessState("Successfully"));
      }
      else{
        emit(LocationErrorState("Please, accepting location permission"));
      }
      
    }
    catch(e){
      throw Exception("LocationBloc__getCurrentLocation");
    }

  }
  void _getCurrentDistance(GetCurrentDistance event, Emitter<LocationState> emit) async{
    try{
      emit(LocationLoading());
      late DistanceCalculatorCustom distances = DistanceCalculatorCustom();
      final double distance = await distances.getDistanceToEndpoint(event.endpoint);
      emit(LoadingDistanceState(distance));
    }
    catch(e){
      throw Exception("LocationBloc__getCurrentLocation");
    }

  }

  void _getRoute(GetRouterEvent event, Emitter<LocationState> emit) async{
    try{
      emit(LocationLoading());
      MapWidget mapWidget = MapWidget(endPoint: event.endpoint);
      LatLng?  currentLocation = await mapWidget.getCurrentLocation();
      List<LatLng> routePoints = [];
      if (currentLocation != null) {
        routePoints = await mapWidget.fetchRoute(currentLocation);
        emit(LocationLoadedState(routePoints, currentLocation, mapWidget));
      }
      else{
        emit(LocationErrorState("Please, accepting location permission"));
      }
    }
    catch(e){
      throw Exception("LocationBloc__getCurrentLocation");
    }

  }
}