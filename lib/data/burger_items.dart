import 'package:restaurant_app/models/food_item_model.dart';

class BurgerItems {
  List<FoodItem> foodItems;
  BurgerItems({
    this.foodItems = const []
  });

  static List<FoodItem> getBurgerItems(){
    return _getBurgerItems();
  }

  static List<FoodItem> _getBurgerItems(){
  return[
    FoodItem(
      name: "Chevre Miel", 
      description: "Pain Brioche, Steak Hache Frais 150g, chevre oignons confits, cheddar, miel, Sauce maison", 
      price: [10.90, 10.10],
    ),
  ];
}
}