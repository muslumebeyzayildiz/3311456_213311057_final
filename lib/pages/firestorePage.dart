import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorePage extends StatefulWidget {
  const FirestorePage({Key? key}) : super(key: key);

  @override
  State<FirestorePage> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  final CollectionReference _products =
  FirebaseFirestore.instance.collection ('products');
/*
await _products.add({"name": name, "price": price});
await _products.update({"name": name, "price": price});
await _products.doc (productId).delete();*/

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Future<void> _update ([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot ['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
// prevent the soft keyboard from covering text fields
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20), // EdgeInsets.only
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration (labelText: 'Name'),
                ), // TextField
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions (decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ), // Input Decoration
                ), // TextField
                const SizedBox (
                  height: 20,
                ), // SizedBox
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                    double.tryParse(_priceController.text);
                    if (price != null) {
                      await _products
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "price": price});
                      _nameController.text = '';
                      _priceController.text = '';
                    }
                  },
                )
              ],
            ),
          );
        });
  }
  Future<void> _create ([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot ['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
// prevent the soft keyboard from covering text fields
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20), // EdgeInsets.only
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration (labelText: 'Name'),
                ), // TextField
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions (decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ), // Input Decoration
                ), // TextField
                const SizedBox (
                  height: 20,
                ), // SizedBox
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                    double.tryParse(_priceController.text);
                    if (price != null) {
                      await _products.add({"name": name, "price": price});
                      _nameController.text = '';
                      _priceController.text = '';
                    }
                  },
                )
              ],
            ),
          );
        });
  }
  Future<void> _delete(String productId) async {
    await _products.doc (productId).delete();

    ScaffoldMessenger.of(context).showSnackBar (const SnackBar (
        content: Text('You have successfully deleted a product'))); // SnackBar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      floatingActionButton: FloatingActionButton (
        onPressed: () => _create(),
        child: const Icon (Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: StreamBuilder (
        stream: _products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //number of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot=
                streamSnapshot.data!.docs[index];
                return Card (
                  margin: const EdgeInsets.all (10),
                  child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text (documentSnapshot['price'].toString()),

                      trailing: SizedBox (
                          width: 100,
                          child: Row(
                              children: [
                                IconButton(
                                    icon: const Icon (Icons.edit),
                                    onPressed: () =>
                                        _update (documentSnapshot)), // IconButton
                                IconButton(
                                    icon: const Icon (Icons.delete),
                                    onPressed: () =>
                                        _delete(documentSnapshot.id)) // IconButton
                              ]
                          ) // Row
                      ) // Sized Box
                  ), // List Tile
                ); // Card
              },
            );
          }
          return const Center (
            child: CircularProgressIndicator(),
          ); // Center
        },
      ), // StreamBuilder
    ); // Scaffold
  }
}
