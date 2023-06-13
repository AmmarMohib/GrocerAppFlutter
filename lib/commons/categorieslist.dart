    // Initialize the categories list
   import 'package:flutter/material.dart';

List<Map<String, dynamic>> categoriesList = [
      {
        "imagePath": "assets/images/fruitImage.png",
        "title": "Fruits & Vegetables",
        "subtitle":
            "Fruits, Vegetables, Potato, Tomato, Brocoli, Onion, Banana",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Vegetables",
            "image": "assets/images/subcategories/vegImage.png"
          },
          {
            "title": "Fruits",
            "image": "assets/images/subcategories/fruitImage.png"
          }
        ]
      },
      {
        "imagePath": "assets/images/bakeryImage.png",
        "title": "Bakery & Dairy",
        "subtitle": "Milk, Butter, Cheese, Bread",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Milk",
            "image": "assets/images/subcategories/milkImage.png"
          },
          {
            "title": "Breads",
            "image": "assets/images/subcategories/breadImage.png"
          },
          {
            "title": "Eggs",
            "image": "assets/images/subcategories/eggImage.png"
          },
          {
            "title": "Cream & Butter",
            "image": "assets/images/subcategories/butterImage.png"
          },
          {
            "title": "Cereals & Oats",
            "image": "assets/images/subcategories/cerealImage.png"
          },
          {
            "title": "Cake & Rusk",
            "image": "assets/images/subcategories/ruskImage.png"
          },
          {
            "title": "Cheese",
            "image": "assets/images/subcategories/cheeseImage.png"
          },
          {
            "title": "Yogurt & Lassi",
            "image": "assets/images/subcategories/yogurtImage.png"
          }
        ]
      },
      {
        "imagePath": "assets/images/groceryImage.png",
        "title": "Grocery",
        "subtitle":
            "Oil, Daalain, Spices & Herbs, Flour, Jams, Sauces, Deserts, Olives, Pickels",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Oil & Ghee",
            "image": "assets/images/subcategories/oilImage.png"
          },
          {
            "title": "Spices, Salt & Sugar",
            "image": "assets/images/subcategories/spiceImage.png"
          },
          {
            "title": "Daalain, Rice & Flour",
            "image": "assets/images/subcategories/lentilImage.png"
          },
          {
            "title": "Sauces & Olives",
            "image": "assets/images/subcategories/saucesImage.png"
          },
          {
            "title": "Jam, Honey & Spread",
            "image": "assets/images/subcategories/jamImage.png"
          },
          {
            "title": "Baking & Desserts",
            "image": "assets/images/subcategories/dessertImage.png"
          }
        ]
      },
      {
        "imagePath": "assets/images/meatImage.png",
        "title": "Meat & Seafood",
        "subtitle": "Mutton, Beef, Chicken, Fish",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Chicken",
            "image": "assets/images/subcategories/chickenImage.png"
          },
          {
            "title": "Fish",
            "image": "assets/images/subcategories/fishImage.png"
          },
          {
            "title": "Mutton",
            "image": "assets/images/subcategories/muttonImage.png"
          },
          {
            "title": "Beef",
            "image": "assets/images/subcategories/beefImage.png"
          },
          {
            "title": "Marinated Chicken",
            "image": "assets/images/subcategories/marinchickImage.png"
          },
          {
            "title": "Sea Food",
            "image": "assets/images/subcategories/seafoodImage.png"
          },
          {
            "title": "Batair, Duck & Rabbit",
            "image": "assets/images/subcategories/batairImage.png"
          },
        ]
      },
      {
        "imagePath": "assets/images/instantImage.png",
        "title": "Instant Food",
        "subtitle": "Biscuits, Noodles, Chocolates, Nimko",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Noodles & Pasta",
            "image": "assets/images/subcategories/noodlesImage.png"
          },
          {
            "title": "Biscuits & Cookies",
            "image": "assets/images/subcategories/biscuitImage.png"
          },
          {
            "title": "Chips & Nimko",
            "image": "assets/images/subcategories/nimkoImage.png"
          },
          {
            "title": "Chocolates",
            "image": "assets/images/subcategories/chocolateImage.png"
          },
          {"title": "Can Food", "image": "assets/images/instantImage.png"},
        ]
      },
      {
        "imagePath": "assets/images/cokeImage.png",
        "title": "Beverages",
        "subtitle":
            "Tea, Cold Drinks, Sharbat, Juices, Energy Drinks, Instant Drinks",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Sharbat",
            "image": "assets/images/subcategories/sharbatImage.png"
          },
          {
            "title": "Cold Drinks",
            "image": "assets/images/subcategories/colddrinkImage.png"
          },
          {
            "title": "Juices",
            "image": "assets/images/subcategories/juiceImage.png"
          },
          {"title": "Tea", "image": "assets/images/subcategories/teaImage.png"},
          {
            "title": "Energy Drinks",
            "image": "assets/images/subcategories/energydrinkImage.png"
          },
          {
            "title": "Mineral & Soda Water",
            "image": "assets/images/subcategories/mineralwaterImage.png"
          },
          {
            "title": "Cold Tea, Coffee",
            "image": "assets/images/subcategories/coldteaImage.png"
          },
          {
            "title": "Instant Drinks",
            "image": "assets/images/subcategories/instantImage.png"
          },
          {
            "title": "Flavoured Milk",
            "image": "assets/images/subcategories/flavouredmilkImage.png"
          },
        ]
      },
      {
        "imagePath": "assets/images/surfImage.png",
        "title": "Home Care",
        "subtitle": "Cleaners, Detergents, Tissue, Repellents, Laundry",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Floor, Bath Cleaning",
            "image": "assets/images/subcategories/bathcleanerImage.png"
          },
          {
            "title": "Laundry",
            "image": "assets/images/subcategories/laundryImage.png"
          },
          {
            "title": "Kitchen Cleaning",
            "image": "assets/images/subcategories/floorcleanerImage.png"
          },
          {"title": "Repellents Mosquito", "image": "assets/images/logo.png"},
          {"title": "Air Fresheners", "image": "assets/images/logo.png"},
          {"title": "Tissue Papers", "image": "assets/images/logo.png"},
          {
            "title": "Bath Towels",
            "image": "assets/images/subcategories/bathcleanerImage.png"
          }
        ]
      },
      {
        "imagePath": "assets/images/panteneImage.png",
        "title": "Personal Care",
        "subtitle":
            "Shampoo, Conditioner, Female Hygiene, Body Spray, Hand Wash, Lotion, Hair Gel",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {"title": "Woman Care", "image": "assets/images/logo.png"},
          {"title": "Men Care", "image": "assets/images/logo.png"},
          {"title": "Skin Care", "image": "assets/images/logo.png"},
          {"title": "Hair Care", "image": "assets/images/logo.png"},
          {"title": "Soap, Hand Wash", "image": "assets/images/logo.png"},
          {"title": "Dental Care", "image": "assets/images/logo.png"},
          {"title": "Shoes, Polish & Brush", "image": "assets/images/logo.png"},
          {"title": "Personal Care", "image": "assets/images/logo.png"},
          {"title": "Makeup", "image": "assets/images/logo.png"}
        ]
      },
      {
        "imagePath": "assets/images/pampersImage.png",
        "title": "Baby Care",
        "subtitle": "Diapers, Lotions, Baby Food",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "Feeding Accessories",
            "image": "assets/images/subcategories/biscuitImage.png"
          },
          {
            "title": "Diaper & Wipes",
            "image": "assets/images/pampersImage.png"
          },
          {
            "title": "Food & Milk",
            "image": "assets/images/subcategories/milkImage.png"
          },
          {
            "title": "Bath & Skin Care",
            "image": "assets/images/subcategories/bathcleanerImage.png"
          },
          {
            "title": "Baby Care Essentials",
            "image": "assets/images/subcategories/juiceImage.png"
          },
        ]
      },
      {
        "imagePath": "assets/images/dryfruitImage.png",
        "title": "Dry Fruit & Nuts",
        "subtitle": "Peanuts, Cashew, Nuts, Almonds etc",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {"title": "Dry Fruits", "image": "assets/images/dryfruitImage.png"},
          {
            "title": "Nuts",
            "image": "assets/images/subcategories/cheeseImage.png"
          },
        ]
      },
      {
        "imagePath": "assets/images/frozenImage.png",
        "title": "Frozen & Chilled",
        "subtitle": "Burger Pattie, Nuggets, Kabab, Frozen Desserts",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {
            "title": "French Fries",
            "image": "assets/images/subcategories/frenchfriesImage.png"
          },
          {
            "title": "Frozen Parathay",
            "image": "assets/images/subcategories/frozenparathaImage.png"
          },
          {
            "title": "Sausages & Toppings",
            "image": "assets/images/subcategories/frozensauceImage.png"
          },
          {
            "title": "Kabab & Kofta",
            "image": "assets/images/subcategories/marinchickImage.png"
          },
          {
            "title": "Burger Patties",
            "image": "assets/images/subcategories/frozenburImage.png"
          },
          {
            "title": "Nuggets & Snacks",
            "image": "assets/images/subcategories/frozennugImage.png"
          },
          {
            "title": "Samosa & Rolls",
            "image": "assets/images/subcategories/frozenrollsamImage.png"
          },
          {
            "title": "Frozen Fruit",
            "image": "assets/images/subcategories/frozenfruitImage.png"
          },
        ]
      },
      {
        "imagePath": "assets/images/freshupImage.png",
        "title": "Pan Shop",
        "subtitle": "Cigrettes, Cigers, Lighters, Mobile Cards",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {"title": "Candies", "image": "assets/images/freshupImage.png"},
        ]
      },
      {
        "imagePath": "assets/images/me-oImage.png",
        "title": "Pet Care",
        "subtitle": "Cat Food, Dog Food",
        "icon": Icons.keyboard_arrow_down_rounded,
        "isExpanded": false,
        "subcategories": [
          {"title": "Cat Food", "image": "assets/images/me-oImage.png"},
          {"title": "Dog Food", "image": "assets/images/me-oImage.png"},
        ]
      }
    ];
    