import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import 'location_data_event.dart';

class LocationDataBloc extends Bloc<LocationDataEvent, LocationData> {
  LocationDataBloc() : super(LocationData.fromMap({}));

  @override
  Stream<LocationData> mapEventToState(LocationDataEvent event) async* {
    if (event is LocationDataUpdateEvent) {
      print("locationUpdated+++++++++++++++++++++++++++++++++++++++++++++++++");
      yield event.locationData;
    }
  }
}
