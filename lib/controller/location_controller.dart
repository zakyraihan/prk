import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController {
  Position? currentUserPosition;
  bool? serviceEnabled;
  LocationPermission? permission;
  String kota = "";

  Future getTheDistance(lat, lng) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location Permission Denied');
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      if (currentUserPosition == null) {
        return (0);
      } else {
        final distanceInMeter = Geolocator.distanceBetween(
          currentUserPosition!.latitude,
          currentUserPosition!.longitude,
          lat,
          lng,
        );
        var distance = distanceInMeter.round().toInt();
        print("distance: $distance");
        return (distance / 1000);
      }
    }
  }

  Future getPermissionLocation() async {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location Permission Denied');
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      currentUserPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
  }

  Future<Placemark?> getLocationUser() async {
    int maxRetries = 3;
    int retry = 0;
    while (retry < maxRetries) {
      try {
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        List<Placemark> placemarks = await GeocodingPlatform.instance!
            .placemarkFromCoordinates(position.latitude, position.longitude);
        final place = placemarks.first;
        kota = formatPlaceName(place.subAdministrativeArea!);
        return place;
      } on PlatformException catch (e) {
        print("Failed location fetch (attempt $retry): $e");
        await Future.delayed(const Duration(seconds: 5));
        retry++;
      }
    }
    print("Location retrieval failed after $maxRetries attempts.");
    return null;
  }

  String formatPlaceName(String placeName) {
    List<String> parts = placeName.split(' ');
    if (parts.length == 2 && parts[0] == "Kabupaten") {
      return "${parts[0].substring(0, 3)}. ${parts[1]}";
    } else {
      return placeName;
    }
  }
}
