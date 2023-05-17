import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:restaurants_app/app/data/routes/remote_routes.dart';
import 'package:restaurants_app/app/domain/entities/restaurant_entity.dart';

class HomeController extends GetxController {
  double latitude = 0, longitude = 0;
  RxList<RestaurantEntity> restaurants = <RestaurantEntity>[].obs;
  RxList<RestaurantEntity> filteredRestaurants = <RestaurantEntity>[].obs;
  final isRestaurantsLoading = false.obs;
  final isAllselected = true.obs;
  final isPizzaSelected = false.obs;
  final isChickenSelected = false.obs;
  final isSaladSelected = false.obs;
  final isBurgerSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    getRestaurants();
  }

  Future<String> getLocationFromCoordinates() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = '${placemark.locality}, ${placemark.country}';
        return address;
      } else {
        return 'Location not found';
      }
    } catch (e) {
      return 'Error retrieving location';
    }
  }

  Future<void> getRestaurants() async {
    try {
      isRestaurantsLoading.value = true;
      final dio = Dio();
      dio.options.baseUrl = AppRemoteRoutes.baseUrl;
      dio.options.followRedirects = true;
      const endpoint = 'get_resturants';
      final requestBody = {
        "lat": latitude,
        "lng": longitude,
      };

      final response = await dio.post(endpoint, data: requestBody);

      if (response.statusCode == 200) {
        final jsonResponse = response.data as Map<String, dynamic>;
        final status = jsonResponse['status'];
        final code = jsonResponse['code'];

        if (status == 'SUCCESS') {
          final dataList = (jsonResponse['data'] as List<dynamic>)
              .map((dataJson) => RestaurantEntity.fromJson(dataJson))
              .toList();
          if (dataList.isNotEmpty) {
            restaurants.value = dataList;
            filteredRestaurants.assignAll(restaurants);
          }

          isRestaurantsLoading.value = false;
        } else {
          if (kDebugMode) {
            print('API request failed. Code: $code');
          }
          isRestaurantsLoading.value = false;
        }
      } else {
        if (kDebugMode) {
          print('HTTP request failed. Status code: ${response.statusCode}');
        }
        isRestaurantsLoading.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      isRestaurantsLoading.value = false;
    }
  }

  void filterList(String query) {
    if (query.isNotEmpty && query != '') {
      filteredRestaurants.value = restaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredRestaurants.assignAll(restaurants);
    }
  }

  void selectCategory(String query) {
    if(query == 'all'){
  isAllselected.value = true;
  isPizzaSelected.value = false;
  isChickenSelected.value = false;
  isSaladSelected.value = false;
  isBurgerSelected.value = false;
    }else if(query == 'pizza'){
  isAllselected.value = false;
  isPizzaSelected.value = true;
  isChickenSelected.value = false;
  isSaladSelected.value = false;
  isBurgerSelected.value = false;
    }else if(query == 'chicken'){
  isAllselected.value = false;
  isPizzaSelected.value = false;
  isChickenSelected.value = true;
  isSaladSelected.value = false;
  isBurgerSelected.value = false;
    }else if(query == 'salad'){
  isAllselected.value = false;
  isPizzaSelected.value = false;
  isChickenSelected.value = false;
  isSaladSelected.value = true;
  isBurgerSelected.value = false;
    }else if(query == 'burger'){
  isAllselected.value = false;
  isPizzaSelected.value = false;
  isChickenSelected.value = false;
  isSaladSelected.value = false;
  isBurgerSelected.value = true;
    }
    if (query != 'all') {
      filteredRestaurants.value = restaurants
          .where((restaurant) =>
              restaurant.tags.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredRestaurants.assignAll(restaurants);
    }
  }
}
