import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_access_event.dart';

class LocationAccessBloc extends Bloc<LocationAccessEvent, bool> {
  LocationAccessBloc() : super(false);

  @override
  Stream<bool> mapEventToState(LocationAccessEvent event) async* {
    if (event is LocationAccessAvailableEvent) {
      print("location_connected++++++++++++++++++++++++++++++++++++++++++++++");
      yield true;
    } else if (event is LocationAccessUnavailableEvent) {
      print("location_disconnected+++++++++++++++++++++++++++++++++++++++++++");
      yield false;
    }
  }
}
