import 'package:latlong2/latlong.dart';
import 'package:myparkingapp/data/api_service/tomtom_map/map_widget.dart';

abstract class LocationState {}

class LocationInitialState extends LocationState{

}

class LocationLoading extends LocationState{}

class LocationSuccessState extends LocationState{
  final String mess;
  LocationSuccessState(this.mess);
}

class LocationLoadedState extends LocationState{
  final List<LatLng> routePoints;
  final LatLng currentLocation;
  final MapWidget mapWidget;
  LocationLoadedState(this.routePoints, this.currentLocation, this.mapWidget);
  
}

class LocationErrorState extends LocationState{
  final String mess;
  LocationErrorState(this.mess);
}

class LoadingDistanceState extends LocationState{
  final double distance;
  LoadingDistanceState(this.distance);
}