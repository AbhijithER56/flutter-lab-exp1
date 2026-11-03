// ============================================================
// Experiment 1: Working with Widgets and Layouts
// App     : Juicy Basket – a mini fruit shop
// Widgets : Row, Column, Container, Card, ListView
// ============================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const JuicyBasketApp());
}

// -------------------------------------------------------
// Palette
// -------------------------------------------------------
const Color kBackground = Color(0xFF1B1430); // deep plum
const Color kSurface = Color(0xFF2A2145); // card surface
const Color kAmber = Color(0xFFFFB703); // primary accent
const Color kCoral = Color(0xFFFB5607); // secondary accent
const Color kTextSoft = Color(0xFFB9B0D6);

// -------------------------------------------------------
// Root Application Widget
// -------------------------------------------------------
class JuicyBasketApp extends StatelessWidget {
  const JuicyBasketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juicy Basket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kAmber,
          brightness: Brightness.dark,
        ),
      ),
      home: const FruitListPage(),
    );
  }
}

// -------------------------------------------------------
// Data Model
// -------------------------------------------------------
class Fruit {
  final String emoji;
  final String name;
  final String tagline;
  final int price; // in rupees
  final String unit;
  final Color tint;

  const Fruit({
    required this.emoji,
    required this.name,
    required this.tagline,
    required this.price,
    required this.unit,
    required this.tint,
  });
}

const List<Fruit> fruits = [
  Fruit(
    emoji: '🍎',
    name: 'Apple',
    tagline: 'Crisp & juicy',
    price: 80,
    unit: 'kg',
    tint: Color(0xFFEF476F),
  ),
  Fruit(
    emoji: '🍌',
    name: 'Banana',
    tagline: 'Rich in potassium',
    price: 40,
    unit: 'dozen',
    tint: Color(0xFFFFD166),
  ),
  Fruit(
    emoji: '🥭',
    name: 'Mango',
    tagline: 'King of fruits',
    price: 120,
    unit: 'kg',
    tint: Color(0xFFFF9F1C),
  ),
  Fruit(
    emoji: '🍊',
    name: 'Orange',
    tagline: 'Full of vitamin C',
    price: 60,
    unit: 'kg',
    tint: Color(0xFFFB5607),
  ),
  Fruit(
    emoji: '🍇',
    name: 'Grapes',
    tagline: 'Sweet & seedless',
    price: 90,
    unit: 'kg',
    tint: Color(0xFFB388EB),
  ),
  Fruit(
    emoji: '🍓',
    name: 'Strawberry',
    tagline: 'Hand-picked daily',
    price: 150,
    unit: 'box',
    tint: Color(0xFFFF5D8F),
  ),
];

// -------------------------------------------------------
// Main Page – Column + ListView, with a basket counter
// -------------------------------------------------------
class FruitListPage extends StatefulWidget {
  const FruitListPage({super.key});

  @override
  State<FruitListPage> createState() => _FruitListPageState();
}

class _FruitListPageState extends State<FruitListPage> {
  // quantity per fruit index
  final List<int> _qty = List<int>.filled(fruits.length, 0);

  int get _totalItems => _qty.fold(0, (a, b) => a + b);

  int get _totalPrice {
    var sum = 0;
    for (var i = 0; i < fruits.length; i++) {
      sum += fruits[i].price * _qty[i];
    }
    return sum;
  }

  void _change(int index, int delta) {
    setState(() {
      _qty[index] = (_qty[index] + delta).clamp(0, 99);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        title: const Text(
          'Juicy Basket',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: kAmber,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          // Basket chip: icon + count
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kAmber.withValues(alpha: 0.6)),
            ),
            child: Row(
              children: [
                const Icon(Icons.shopping_basket, size: 18, color: kAmber),
                const SizedBox(width: 6),
                Text(
                  '$_totalItems',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // -- Gradient hero banner --
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kCoral, kAmber],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: kCoral.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'EXPERIMENT 1',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fresh picks,\nstraight to you',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Row · Column · Container · Card · ListView',
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const Text('🧺', style: TextStyle(fontSize: 54)),
              ],
            ),
          ),

          // -- Section label --
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                const Text(
                  "Today's Harvest",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  '${fruits.length} varieties',
                  style: const TextStyle(fontSize: 12, color: kTextSoft),
                ),
              ],
            ),
          ),

          // -- ListView of FruitCard widgets --
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                return FruitCard(
                  fruit: fruits[index],
                  quantity: _qty[index],
                  onAdd: () => _change(index, 1),
                  onRemove: () => _change(index, -1),
                );
              },
            ),
          ),

          // -- Checkout bar --
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Basket total',
                        style: TextStyle(fontSize: 11, color: kTextSoft),
                      ),
                      Text(
                        '₹ $_totalPrice',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: kAmber,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '$_totalItems item${_totalItems == 1 ? '' : 's'}',
                    style: const TextStyle(color: kTextSoft, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------
// Reusable Custom Widget – FruitCard
// Uses: Card, Container, Row, Column
// -------------------------------------------------------
class FruitCard extends StatelessWidget {
  final Fruit fruit;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const FruitCard({
    super.key,
    required this.fruit,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSurface,
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          // Coloured accent stripe on the left edge
          Container(width: 6, height: 92, color: fruit.tint),

          const SizedBox(width: 12),

          // Emoji in a tinted rounded square
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: fruit.tint.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(fruit.emoji, style: const TextStyle(fontSize: 30)),
            ),
          ),

          const SizedBox(width: 14),

          // Name, tagline and price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fruit.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  fruit.tagline,
                  style: const TextStyle(fontSize: 12, color: kTextSoft),
                ),
                const SizedBox(height: 6),
                Text(
                  '₹ ${fruit.price} / ${fruit.unit}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: kAmber,
                  ),
                ),
              ],
            ),
          ),

          // Quantity stepper
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: quantity == 0
                ? _roundButton(Icons.add, onAdd, filled: true)
                : Row(
                    children: [
                      _roundButton(Icons.remove, onRemove),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _roundButton(Icons.add, onAdd, filled: true),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onTap,
      {bool filled = false}) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? kAmber : Colors.transparent,
          border: Border.all(color: kAmber, width: 1.5),
        ),
        child: Icon(icon, size: 18, color: filled ? kBackground : kAmber),
      ),
    );
  }
}
