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

  @override
  void initState() {
    _getCurrentUser();
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _itemsCollection
                  .where('userEmail', isEqualTo: _currentUser?.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }

                List<Map<String, dynamic>> items = snapshot.data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    String itemName = items[index]['name'];
                    String itemQuantity = items[index]['quantity'];

                    return ListTile(
                      title: Text('$itemName - Quantity: $itemQuantity'),
                    );
                  },
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

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
