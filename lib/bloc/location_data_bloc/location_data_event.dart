import 'package:location/location.dart';

class LocationDataEvent{}

class LocationDataUpdateEvent extends LocationDataEvent{
  late LocationData locationData;

  LocationDataUpdateEvent(this.locationData);
}
