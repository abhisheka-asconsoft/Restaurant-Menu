import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_menu/data/dummy_menu_data.dart';

class MenuSliverPage extends StatelessWidget {
  const MenuSliverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Restaurant header
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 200,

            title: Text(restaurant.name),

            //Back button
            leading: const BackButton(),

            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 25,
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
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),

          // Search bar
          SliverToBoxAdapter(
            child: Container(
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
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),

          // const StickyTitleWidget(label: 'Food Category'),

          // Restaurant menu list
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: menu.length,
                (context, index) {
                  final category = menu[index];
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
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.food,
  });

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  food.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Description
                Text(
                  food.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),

                // Price
                Text(
                  '₹ ${food.price}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          //Food Image
          Expanded(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: food.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: 100,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red[200],
                ),
                child: const FlutterLogo(),
              ),
              placeholder: (context, string) => Container(
                height: 100,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red[200],
                ),
                child: const FlutterLogo(),
              ),
              errorWidget: (context, url, error) => Container(
                height: 100,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red[200],
                ),
                child: const FlutterLogo(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
