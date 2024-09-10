class RestaurantModel {
  final String name;
  final String coverUrl;
  final num rating;
  final num numberOfReviews;
  final num distance;
  final String deliveryTime;
  final String address;
  final List<String> cuisines;

  RestaurantModel({
    required this.name,
    required this.coverUrl,
    required this.rating,
    required this.numberOfReviews,
    required this.distance,
    required this.deliveryTime,
    required this.address,
    required this.cuisines,
  });
}

class CategoryModel {
  final String name;

  final List<FoodModel> foodItems;
  final List<SubcategoryModel> subcategories;

  CategoryModel({required this.name, required this.foodItems, required this.subcategories})
      : assert(foodItems.isNotEmpty || subcategories.isNotEmpty, 'A category must have either food items or subcategories, or both.');
}

class SubcategoryModel {
  final String name;
  final List<FoodModel> foodItems;

  SubcategoryModel({required this.name, required this.foodItems});
}

class FoodModel {
  final String name;
  final num price;
  final String imageUrl;
  final String description;

  FoodModel({required this.name, required this.price, required this.imageUrl, required this.description});
}

// Sample restaurant
final restaurant = RestaurantModel(
    name: 'Taste of India',
    coverUrl: 'https://images.unsplash.com/photo-1555685818-e2981e5b1f7c',
    rating: 4.7,
    numberOfReviews: 320,
    distance: 2.8,
    deliveryTime: '30-40 minutes',
    address: 'NewTown, Kolkata',
    cuisines: ['North Indian', 'Mughal', 'Bangla']);

// Sample menu
final menu = [
  CategoryModel(
    name: 'Appetizers',
    foodItems: [
      FoodModel(
        name: 'Samosas',
        price: 6.99,
        imageUrl:
            'https://images.unsplash.com/photo-1601456349397-04d7b8d2c2e1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDdfc2Ftb3Nhc3xlbnwwfHx8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
        description: 'Crispy pastry filled with spiced potatoes and peas.',
      ),
      FoodModel(
        name: 'Paneer Tikka',
        price: 8.49,
        imageUrl:
            'https://images.unsplash.com/photo-1598075328502-4e912fb2d0c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDdfcGFuZWVyJTIwdGlra2F8ZW58MHx8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
        description: 'Marinated paneer cubes grilled to perfection.',
      ),
    ],
    subcategories: [],
  ),
  CategoryModel(
    name: 'Main Courses',
    foodItems: [],
    subcategories: [
      SubcategoryModel(
        name: 'Curries',
        foodItems: [
          FoodModel(
            name: 'Chicken Curry',
            price: 13.99,
            imageUrl:
                'https://images.unsplash.com/photo-1599424474117-d3467b79c15a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDdfY2hpY2tlbi1jdXJyeXxlbnwwfHx8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
            description: 'Spicy chicken curry with aromatic spices and herbs.',
          ),
          FoodModel(
            name: 'Paneer Butter Masala',
            price: 12.49,
            imageUrl:
                'https://images.unsplash.com/photo-1615295418597-76a0e3e7e663?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDJ8fHBhbmVlcnhlfGVufDF8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
            description: 'Paneer cooked in a creamy tomato-based gravy.',
          ),
        ],
      ),
      SubcategoryModel(
        name: 'Rice Dishes',
        foodItems: [
          FoodModel(
            name: 'Biryani',
            price: 14.99,
            imageUrl:
                'https://images.unsplash.com/photo-1606305154604-39ef1a8d8e60?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDdfYmlyeWFuaXxlbnwwfHx8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
            description: 'Fragrant rice dish with spices, meat, and herbs.',
          ),
          FoodModel(
            name: 'Jeera Rice',
            price: 9.99,
            imageUrl:
                'https://images.unsplash.com/photo-1594673862811-32835e19e2f7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDdfamVlcmljfGVufDF8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
            description: 'Rice flavored with cumin seeds and spices.',
          ),
        ],
      ),
    ],
  ),
  CategoryModel(
    name: 'Desserts',
    foodItems: [
      FoodModel(
        name: 'Gulab Jamun',
        price: 7.99,
        imageUrl:
            'https://images.unsplash.com/photo-1607666636760-d273c379d3b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDF8Z3VsYWJ-fGVufDF8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
        description: 'Deep-fried dough balls soaked in sweet syrup.',
      ),
      FoodModel(
        name: 'Ras Malai',
        price: 8.49,
        imageUrl:
            'https://images.unsplash.com/photo-1617135808128-15b272a008b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDJ8fHJhc19tYWxhaXxlbnwwfHx8fDE2Njk3MzA5&ixlib=rb-1.2.1&q=80&w=1080',
        description: 'Soft cheese dumplings in creamy, flavored milk.',
      ),
    ],
    subcategories: [],
  ),
];
