import 'package:restaurant_app/models/food_item_model.dart';
import 'package:restaurant_app/data/sandwich_items.dart';
import 'package:restaurant_app/data/burger_items.dart';

class CategoryModel {
  String name;
  String imgPath;
  bool isSelected;
  List<FoodItem> foodItems;

  CategoryModel({
    required this.name,
    required this.imgPath,
    required this.isSelected,
    this.foodItems = const [],
  });

  static List<CategoryModel> getCategories(){
    return [
      CategoryModel(
        name: 'Sandwich', 
        imgPath: 'assets/images/sandwich-menu.jpg',
        isSelected: false,
        foodItems: SandwichItems.getSandwichItems(),
        ),

      CategoryModel(
        name: 'Burger', 
        imgPath: 'assets/images/burger-menu.jpg',
        isSelected: false,
        foodItems: BurgerItems.getBurgerItems(),
        )
    ];

  }

  // static List<FoodItem> _getBurgerItems(){
  //   return[
  //     FoodItem(
  //       name: "Chevre Miel", 
  //       description: "Pain Brioche, Steak Hache Frais 150g, chevre oignons confits, cheddar, miel, Sauce maison", 
  //       price: [10.90, 10.10],
  //     ),
  //   ];
  // }

}