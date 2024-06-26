import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShoppingListScreen extends StatefulWidget {
  static const String id = 'shopping_list_screen';
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  ShoppingListScreenState createState() => ShoppingListScreenState();
}

class ShoppingListScreenState extends State<ShoppingListScreen> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _itemsCollection =
      FirebaseFirestore.instance.collection('shopping_items');
  User? _currentUser; // Variable to store the current user

  List<Map<String, dynamic>> _shoppingItems = [];

  @override
  void initState() {
    _getCurrentUser();
    _retrieveItemsFromCloud();
    super.initState();
  }

  // Function to get the current user's information
  void _getCurrentUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: _retrieveItemsFromCloud,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      hintText: 'Enter item',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      hintText: 'Enter quantity',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addItem,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _retrieveItemsFromCloud,
            child: const Text('Retrieve Items from Cloud'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _shoppingItems.length,
              itemBuilder: (context, index) {
                String itemName = _shoppingItems[index]['name'];
                String itemQuantity = _shoppingItems[index]['quantity'];
                String itemUserEmail = _shoppingItems[index]['userEmail'];

                return ListTile(
                  title: Text('$itemName - Quantity: $itemQuantity'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    String newItem = _itemController.text.trim();
    String quantity = _quantityController.text.trim();

    if (_currentUser != null && newItem.isNotEmpty) {
      _itemsCollection.add({
        'name': newItem,
        'quantity': quantity,
        'userEmail': _currentUser!.email,
      });
      _itemController.clear();
      _quantityController.clear();
    }
  }

  void _retrieveItemsFromCloud() async {
    try {
      if (_currentUser != null) {
        QuerySnapshot querySnapshot = await _itemsCollection
            .where('userEmail', isEqualTo: _currentUser!.email)
            .get();
        List<Map<String, dynamic>> items = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        setState(() {
          _shoppingItems = items;
        });
      }
    } catch (e) {
      print('Error retrieving items: $e');
    }
  }

  @override
  void dispose() {
    _itemController?.dispose();
    _quantityController?.dispose();
    super.dispose();
  }
}
