import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurants_app/app/presentation/manager/home_controller.dart';
import 'package:restaurants_app/app/presentation/utils/app_colors.dart';
import 'package:restaurants_app/app/presentation/utils/assets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final heightFactor = height / 767.42;
    final widthFactor = width / 372.74;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundColor, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: heightFactor * 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on),
                      FutureBuilder<String>(
                          future: controller.getLocationFromCoordinates(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Icon(Icons.error);
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: heightFactor * 180,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            '   Stories',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      SizedBox(
                        width: width,
                        height: heightFactor * 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.05),
                              child: Image.asset(AppAssets.story1),
                            ),
                            Image.asset(AppAssets.story2),
                            Image.asset(AppAssets.story3),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: heightFactor * 63,
                  child: Center(
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: TextField(
                        onChanged: (value) {
                          controller.filterList(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: heightFactor * 25,
                          ),
                          labelText: 'Search Restaurants',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightFactor * 70,
                  width: width,
                  child: Obx(() {
                    return Center(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: 12,
                                top: heightFactor * 12,
                                bottom: heightFactor * 12),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectCategory('all');
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(30),
                                elevation: 5,
                                child: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: controller.isAllselected.value
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 12,
                                top: heightFactor * 12,
                                bottom: heightFactor * 12),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectCategory('pizza');
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(30),
                                elevation: 5,
                                child: Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: controller.isPizzaSelected.value
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppAssets.pizzaIcon,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Pizza',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 12,
                                top: heightFactor * 12,
                                bottom: heightFactor * 12),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectCategory('chicken');
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(30),
                                elevation: 5,
                                child: Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: controller.isChickenSelected.value
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppAssets.chickenIcon,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Chicken',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 12,
                                top: heightFactor * 12,
                                bottom: heightFactor * 12),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectCategory('salad');
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(30),
                                elevation: 5,
                                child: Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: controller.isSaladSelected.value
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppAssets.saladIcon,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Salad',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 12,
                                top: heightFactor * 12,
                                bottom: heightFactor * 12),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectCategory('burger');
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(30),
                                elevation: 5,
                                child: Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: controller.isBurgerSelected.value
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppAssets.burgerIcon,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Burger',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: heightFactor * 35,
                  child: Row(
                    children: [
                      Text(
                        'Nearby Restaurants',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: heightFactor * 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return SizedBox(
                      height: heightFactor * 370,
                    child: Center(
                      child: controller.isRestaurantsLoading.value
                          ? const CircularProgressIndicator()
                          : controller.filteredRestaurants.isEmpty
                              ? const Text('There is no restaurants found')
                              : ListView.builder(
                                  itemCount:
                                      controller.filteredRestaurants.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(15),
                                        child: Stack(
                                          children: [
                                            const Positioned.fill(
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                            Container(
                                              height: 225,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    controller
                                                        .filteredRestaurants[
                                                            index]
                                                        .primaryImage,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            height: 25,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color
                                                                  .fromARGB(
                                                                      255,
                                                                      8,
                                                                      224,
                                                                      48),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .filteredRestaurants[
                                                                          index]
                                                                      .rating,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                                const Icon(
                                                                  Icons.star,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 68,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        bottom:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            widthFactor * 12,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .filteredRestaurants[
                                                                        index]
                                                                    .name,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    heightFactor *
                                                                        6,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .filteredRestaurants[
                                                                        index]
                                                                    .tags,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    AppAssets
                                                                        .discountIcon,
                                                                    height: 35,
                                                                  ),
                                                                  Text(
                                                                    '${controller
                                                                            .filteredRestaurants[index]
                                                                            .discount}% FLAT OFF',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        fontSize:
                                                                            17),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                '${controller
                                                                        .filteredRestaurants[
                                                                            index]
                                                                        .distance} meters away',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          33,
                                                                          33,
                                                                          33),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
