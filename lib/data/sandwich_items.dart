import 'package:restaurant_app/models/food_item_model.dart';

class SandwichItems {
  List<FoodItem> foodItems;
  SandwichItems({
    this.foodItems = const [],
  });

  static List<FoodItem> getSandwichItems(){
    return _getSandwichItems();
  }

  static List<FoodItem> _getSandwichItems(){
    return[
      FoodItem(
        name: "Grec", 
        description: "Kebab, Crudites", 
        price: [7.90, 7.10], 
        hasSauces: true, 
        hasVegetables: true,
        hasNote: true
      ),

      FoodItem(
        name: "Escalope", 
        description: "Escalopes de poulet, Fromage", 
        price: [7.90, 7.10],
      ),

      FoodItem(
        name: "Chicken Curry", 
        description: "Chicken Curry, Fromage", 
        price: [7.90, 7.10], 
      ),

      FoodItem(
        name: "Chicken Tandoori", 
        description: "Chicken Tandoori, Fromage", 
        price: [7.90, 7.10],
      ),

      FoodItem(
        name: "Boursin", 
        description: "Escalope, Boursin, Oeuf, Fromage", 
        price: [8.10, 8.90],
      ),
      FoodItem(
        name: "Infernal", 
        description: "3 Steaks, Jambon de dinde, Fromage", 
        price: [8.30, 7.50], 
      ),

      FoodItem(
        name: "4X4", 
        description: "4 Steaks, 4 Fromages", 
        price: [8.90, 8.10], 
      ),

      FoodItem(
        name: "blindé", 
        description: "2 Viandes au choix + Fromages (Steak, Grec, Escalope, Chicken, ou Tenders)", 
        price: [8.90, 8.10], 
      ),

      FoodItem(
        name: "délice", 
        description: "2 Steaks, Oeuf, Jambon de dinde, Fromage", 
        price: [7.90, 7.10], 
      ),

      FoodItem(
        name: "RS 3", 
        description: "3 Steaks, Oeuf, 3 Fromages", 
        price: [7.90, 7.10], 
      ),

      FoodItem(
        name: "Country", 
        description: "2 Steaks, 2 Fromages, Galette de Pomme de terre", 
        price: [7.90, 7.10], 
      ),

      FoodItem(
        name: "Radikale", 
        description: "2 Steaks, Cordon bleu fromage", 
        price: [8.50, 7.90], 
      ),

      FoodItem(
        name: "Escalope du chef", 
        description: "Escalop, Fromage, Champignon, Créme fraiche",
        price: [8.50, 7.90],
      ),

      FoodItem(
        name: "Hummer: H-2", 
        description: "2 Steaks, 2 Fromages, 1 Oeuf", 
        price: [8.10, 7.30], 
      ),

      FoodItem(
        name: "Hummer: H-3", 
        description: "3 Steaks, 3 Fromages, 1 Oeuf", 
        price: [9.10, 8.30], 
      ),
    ];
  }
}