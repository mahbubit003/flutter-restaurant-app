import "dart:ui";

import "package:flutter/material.dart";
import "package:restaurant_app/models/category_model.dart";
import "package:flutter_svg/flutter_svg.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:restaurant_app/models/food_item_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedFoodItemIndex; // Tracks which food item is selected
  bool showDetailView = false; // Controls view switching

  List<CategoryModel> categories = [];

  void _getCategories(){
    categories = CategoryModel.getCategories();
  }

  @override
  void initState(){
    super.initState();
    _getCategories();
    if (categories.isNotEmpty) {
      categories[0].isSelected = true;
    }
  }

  //animatedSwitcher
  int _currentIndex = 0;
  int? _previousIndex;

  // List of widgets to cycle through
  final List<Widget> _contentList = [
    Container(
      key: ValueKey(0),
      width: 150,
      height: 150,
      child: Card(
        // color: Colors.yellow,
        elevation: 0.0,
        child: Center(child: Text('Page 1', style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0), fontSize: 20)))
        ),
    ),
    Container(
      key: ValueKey(1),
      width: 150,
      height: 150,
      child: Card(
        // color: Colors.blue,
        elevation: 0.0,
        child: Center(child: Text('Page 2', style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0), fontSize: 20)))
        ),
    ),
    Container(
      key: ValueKey(2),
      width: 150,
      height: 150,
      child: Card(
        // color: Colors.green,
        elevation: 0.0,
        child: Center(child: Text('Page 3', style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0), fontSize: 20)))
        ),
    ),
  ];

  void _next() {
    setState(() {
      if (_currentIndex < _contentList.length - 1) {
         _previousIndex = _currentIndex;
        _currentIndex++;
      }
    });
  }

  void _previous() {
    setState(() {
      if (_currentIndex > 0) {
        _previousIndex = _currentIndex;
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Set crossAxisCount based on screen width
    int crossAxisCount = (screenWidth >= 800) ? 4 : 3;

    // Calculate card width
    double cardWidth = 250;
    
    int selectedCategoryIndex = categories.indexWhere((category) => category.isSelected);
    return Scaffold(
      appBar: appBar(),
      // backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: Column(
        children: [
          _categorySection(),
          SizedBox(height: 20,),
          if(showDetailView) SizedBox() else _categoryHeader(),
          if(showDetailView) _detailView(selectedCategoryIndex) else _foodItemGrid(crossAxisCount, selectedCategoryIndex, cardWidth),
        ],
      ),
    );
  }

  Container _foodItemGrid(int crossAxisCount, int selectedCategoryIndex, double cardWidth) {
    return Container(
          child: Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StaggeredGrid.count(
                  mainAxisSpacing: 10,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  children: List.generate(categories[selectedCategoryIndex].foodItems.length, (index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedFoodItemIndex = index;
                            showDetailView = true;
                          });
                          print("You tapped on a card!");
                          categories[selectedCategoryIndex].foodItems[index].printTrueProperties(categories[selectedCategoryIndex].foodItems[index]);
                          print("True properties are ");
                        },
                        child: _foodItemCard(cardWidth, selectedCategoryIndex, index),
                      );
                    }, 
                  ),
                ),
              ),
            ),
          ),
        );
  }

  // Add these new methods to _HomePageState
  Widget _detailView(selectedCategoryIndex) {
    if (selectedFoodItemIndex == null) return Container();
    
    final foodItem = categories[selectedCategoryIndex].foodItems[selectedFoodItemIndex!];
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column (30%)
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Text(categories[selectedCategoryIndex].name.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                  _foodItemGrid(1, selectedCategoryIndex, 300),
                ],
              )
            ),
            
            SizedBox(width: 20),
            
            // Right Column (70%)
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                                showDetailView = false;
                                selectedFoodItemIndex = null;
                        });
                      },
                      child: TextButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 24, 186, 255), 
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          iconColor: Colors.white,
                          foregroundColor: Colors.white
                        ),
                        icon: Icon(Icons.arrow_back),
                        label: Text("Back"),
                        onPressed: () {
                          setState(() {
                            showDetailView = false;
                            selectedFoodItemIndex = null;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  // Details Section
                  Expanded(
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //Food name
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      foodItem.name.toUpperCase(), 
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                //Order custimze column
                                ClipRRect(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Hello Guys"),
                                      AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child, Animation<double> animation) {
                                      final isMovingForward = _previousIndex != null && _currentIndex > _previousIndex!;
                                      // Incoming widget: Slide from right (Next) or left (Previous)
                                      final inTween = isMovingForward
                                          ? Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero) // Right to center
                                          : Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero); // Left to center
                                      // Outgoing widget: Slide to left (Next) or right (Previous)
                                      final outTween = isMovingForward
                                          ? Tween<Offset>(begin: Offset.zero, end: Offset(-1.0, 0.0)) // Center to left
                                          : Tween<Offset>(begin: Offset.zero, end: Offset(1.0, 0.0)); // Center to right

                                      // Check if this child is the new one (entering)
                                      final isNewChild = child.key == _contentList[_currentIndex].key;

                                      return Stack(
                                        children: [
                                          if (!isNewChild) // Outgoing widget
                                            SlideTransition(
                                              position: outTween.animate(animation),
                                              child: child,
                                            ),
                                          SlideTransition(
                                            position: inTween.animate(animation),
                                            child: _contentList[_currentIndex], // Always show incoming widget
                                          ),
                                        ],
                                      );
                                    },
                                    child: _contentList[_currentIndex],
                                  ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: _currentIndex > 0 ? _previous : null, // Disable if at start
                                            child: Text('Previous'),
                                          ),
                                          SizedBox(width: 20),
                                          ElevatedButton(
                                            onPressed: _currentIndex < _contentList.length - 1 ? _next : null, // Disable if at end
                                            child: Text('Next'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  // Container(
                  //   height: 45,
                  // ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                        side: BorderSide(
                          color: Colors.blue,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Your Order",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Divider(color: Colors.blue.shade100,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
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
  }

  Widget _buildPriceItem(String label, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('€${price.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  SizedBox _foodItemCard(double cardWidth, int selectedCategoryIndex, int index) {
    return SizedBox(
      width: cardWidth,
      child: Card(
        elevation: 5,
        // color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      categories[selectedCategoryIndex].foodItems[index].name.toUpperCase(), //last saved
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: const Divider(color: Colors.grey),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        categories[selectedCategoryIndex].foodItems[index].description,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                              color: Colors.red, 
                              width: 2,
                              ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5), 
                              bottomLeft: Radius.circular(5),
                              ),
                          ),
                          child: Text(
                            "Menu",
                            style: TextStyle(fontSize: 12, color: Colors.white)
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4, top: 2, right: 2, bottom: 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 2
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5), 
                              bottomRight: Radius.circular(5)
                              ),
                          ),
                          child: Text(
                            categories[selectedCategoryIndex].foodItems[index].price[0].toStringAsFixed(2)+"€",
                            style: TextStyle(fontSize: 12)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            border: Border.all(
                              color: Colors.yellow, 
                              width: 2,
                              ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5), 
                              bottomLeft: Radius.circular(5),
                              ),
                          ),
                          child: Text(
                            "Seul",
                            style: TextStyle(fontSize: 12, color: Colors.black)
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4, top: 2, right: 2, bottom: 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.yellow,
                              width: 2
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5), 
                              bottomRight: Radius.circular(5)
                              ),
                          ),
                          child: Text(
                            categories[selectedCategoryIndex].foodItems[index].price[1].toStringAsFixed(2)+"€",
                            style: TextStyle(fontSize: 12)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _categoryHeader() {
    return Column(
          children: [
            Text(
              categories.isNotEmpty 
                ? categories.firstWhere((category) => category.isSelected).name
                : '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
  }

  Column _categorySection() {
    return Column(
        children: [
          Container(),
          SizedBox(height: 15,),
          SizedBox(
            height: 100,
            // color: const Color.fromARGB(255, 2, 149, 168),
            child: ListView.separated(
              itemCount: categories.length,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => 
                SizedBox(width: 20,),
                shrinkWrap: true,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (showDetailView) {
                        selectedFoodItemIndex = 0;
                      }
                      for (var category in categories) {
                        category.isSelected = false;
                      }
                      // Select the tapped category
                      categories[index].isSelected = true;
                    });
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                      color: categories[index].isSelected? const Color.fromARGB(255, 85, 183, 0) : Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread of the shadow
                          blurRadius: 5, // Blur effect
                          offset: Offset(0, 3), // Offset (X, Y) -> Y adds depth
                          
                        ),
                      ],
                    ),
                    
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 70,
                            child: Image.asset(
                              categories[index].imgPath,
                              fit: BoxFit.cover,
                              ),
                          ),
                          
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              categories[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: categories[index].isSelected? Colors.white: const Color.fromARGB(255, 80, 79, 79)
                              ),
                            ),
                          ),
                        ],
                        
                      
                      ),
                    ),
                  ),
                );
                
              }
            ),
          ),
        ],
        
        
        
      );
  }

  PreferredSizeWidget appBar() {
    
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
      child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 98, 95, 95), // AppBar color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 2, // Spread of the shadow
            blurRadius: 5, // Blur effect
            offset: Offset(0, 3), // Offset (X, Y) -> Y adds depth
          ),
        ],
      ),
      child: AppBar(
        title: const Text("FEAL TIME", 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Color.fromARGB(255, 255, 255, 255),
            letterSpacing: 5),
          ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 183, 8, 8),
        leading: GestureDetector(
        onTap: () {
          print("clicked on menu");
        },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 10, bottom: 15),
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 234, 14, 14),
            // ),
            child: SvgPicture.asset('assets/icons/burger-menu.svg', colorFilter: ColorFilter.mode(const Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
      
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 15, right: 20, bottom: 15),
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   color: const Color.fromARGB(255, 234, 14, 14),
              // ),
              child: SvgPicture.asset('assets/icons/kebab-horizontal.svg', colorFilter: ColorFilter.mode(const Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),),
            ),
        ),
        ],
          
      ),
      )
    );
  }
}