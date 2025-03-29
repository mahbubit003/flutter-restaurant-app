class FoodItem {
  final String name;
  final String description;
  final List<double> price;
  final bool? hasBreadType;
  final bool? hasMeatType;
  final bool? hasSauces;
  final bool? hasSaucesFry;
  final bool? hasVegetables;
  final bool? hasSupplements;
  final bool? isExpanded; //panini expands food item
  final bool? hasNote;

  FoodItem({
    required this.name,
    required this.description,
    required this.price,
    this.hasBreadType,
    this.hasMeatType,
    this.hasSauces,
    this.hasSaucesFry,
    this.hasVegetables,
    this.hasSupplements, //pizza
    this.isExpanded, //panini expands food item
    this.hasNote,
  });

  // int get truePropertiesCount{
  //   return [
  //     hasBreadType,
  //     hasMeatType,
  //     hasSauces,
  //     hasSaucesFry,
  //     hasVegetables,
  //     hasSupplements, //pizza
  //     hasNote,
  //   ].where((prop)=> prop == true).length;
  // }

  void printTrueProperties(FoodItem foodItem){
    final properties = {
      'hasBreadType': foodItem.hasBreadType,
      'hasMeatType': foodItem.hasMeatType,
      'hasSauces': foodItem.hasSauces,
      'hasSaucesFry': foodItem.hasSaucesFry,
      'hasVegetables': foodItem.hasVegetables,
      'hasSupplements': foodItem.hasSupplements,
      'hasNote': foodItem.hasNote
    };

    int index = 0;
    int trueCount = 0;
    for (var entry in properties.entries) {
      if (entry.value == true) {
        print('Index: $index, Property: ${entry.key}, Value: ${entry.value}');
        trueCount++;
      }
      index++;
    }
    print('Total true values: $trueCount');
  }
}