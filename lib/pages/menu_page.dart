import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:restaurant_menu/data/dummy_menu_data.dart';

import 'menu_sliver_page.dart';

extension ScrollMetricsX on ScrollMetrics {
  String stringify() {
    return 'ScrollMetricsMixin('
        'axisDirection: $axisDirection, '
        'extentBefore: $extentBefore, '
        'extentInside: $extentInside, '
        'extentAfter: $extentAfter, '
        'pixels: $pixels, '
        'viewportDimension: $viewportDimension, '
        'minScrollExtent: $minScrollExtent, '
        'maxScrollExtent: $maxScrollExtent'
        ')';
  }
}

sealed class AppBarEvents {}

class InvisibleAppBar extends AppBarEvents {}

class ShowTitle extends AppBarEvents {
  final String title;

  ShowTitle({required this.title});
}

class ShowSearch extends AppBarEvents {
  final String? categoryName;
  final VoidCallback onSearchTapped;

  ShowSearch({
    this.categoryName,
    required this.onSearchTapped,
  });
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ValueNotifier appBarEventNotifier = ValueNotifier<AppBarEvents>(InvisibleAppBar());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                log('Scroll metrics - ${notification.metrics.stringify()}');
                final metrics = notification.metrics;
                if (metrics.pixels > 240) {
                  appBarEventNotifier.value = ShowSearch(onSearchTapped: () {});
                } else if (metrics.pixels > 53) {
                  appBarEventNotifier.value = ShowTitle(title: restaurant.name);
                } else {
                  appBarEventNotifier.value = InvisibleAppBar();
                }
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Restaurant header
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            restaurant.cuisines.join(", "),
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star_outline,
                              ),
                              const SizedBox(width: 8),
                              Text('${restaurant.rating} (${restaurant.numberOfReviews}+)'),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Delivery time and distance row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Delivery time
                              Row(
                                children: [
                                  const Icon(Icons.timelapse),
                                  const SizedBox(width: 5),
                                  Text(restaurant.deliveryTime),
                                ],
                              ),

                              const SizedBox(width: 30),

                              // Distance
                              Row(
                                children: [
                                  const Icon(Icons.bike_scooter_outlined),
                                  const SizedBox(width: 5),
                                  Text('${restaurant.distance} Kms'),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Address
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(restaurant.address),
                          ),

                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),

                      // Search bar
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(width: 8),
                            Text('Search dishes'),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Menu
                      ...menu.map(
                        (category) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ExpansionTile(
                              title: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(category.name),
                              ),
                              backgroundColor: Colors.black.withOpacity(0.03),
                              collapsedBackgroundColor: Colors.black.withOpacity(0.03),
                              tilePadding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide.none,
                              ),
                              initiallyExpanded: true,
                              children: category.subcategories.isNotEmpty

                                  /// Subcategories from the [category]
                                  ? category.subcategories.map((e) {
                                      final subcategory = e;
                                      final foodItems = e.foodItems;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ExpansionTile(
                                          backgroundColor: Colors.black.withOpacity(0.01),
                                          collapsedBackgroundColor: Colors.black.withOpacity(0.01),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide.none,
                                          ),
                                          initiallyExpanded: true,
                                          title: Text(subcategory.name),
                                          tilePadding: EdgeInsets.zero,
                                          children: foodItems.isEmpty
                                              ? []
                                              : foodItems
                                                  .map(
                                                    (e) => FoodCard(
                                                      food: e,
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      );
                                    }).toList()

                                  /// Food items from the [category]
                                  : category.foodItems.isNotEmpty
                                      ? category.foodItems
                                          .map(
                                            (e) => FoodCard(
                                              food: e,
                                            ),
                                          )
                                          .toList()
                                      : <Widget>[],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ValueListenableBuilder(
                valueListenable: appBarEventNotifier,
                builder: (context, value, child) {
                  return Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: value is InvisibleAppBar ? Colors.transparent : Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(),
                            if (value is ShowTitle) ...[
                              Text(
                                (value).title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            if (value is ShowTitle || value is ShowSearch) ...[
                              Flexible(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  width: value is ShowSearch ? 500 : 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: value is ShowTitle
                                      ? const Icon(Icons.search)
                                      : value is ShowSearch
                                          ? const Row(
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                                    child: Icon(Icons.search),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    'Search dishes',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                ),
                              )
                            ]
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
