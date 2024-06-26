import 'package:flutter/material.dart';
import 'package:peminjaman_lab/admin/edit_alat.dart';
import 'package:peminjaman_lab/admin/formulir_alat.dart';

class KelolaAlatPage extends StatefulWidget {
  const KelolaAlatPage({super.key});

  @override
  _KelolaAlatPageState createState() => _KelolaAlatPageState();
}

class _KelolaAlatPageState extends State<KelolaAlatPage> {
  List<Map<String, dynamic>> alatItems = [
    {'title': 'Proyektor', 'image': 'images/proyektor.jpg'},
    {'title': 'Keyboard', 'image': 'images/keyboard.jpg'},
    {'title': 'Power Supply', 'image': 'images/power_supply.jpg'},
    {'title': 'RAM', 'image': 'images/RAM.jpg'},
  ];

  void deleteAlat(Map<String, dynamic> deletedItem) {
    setState(() {
      alatItems.remove(deletedItem);
    });
  }

  void saveAlat(Map<String, dynamic> updatedItem) {
    setState(() {
      // Implement save functionality here
    });
  }

  void addAlat(Map<String, dynamic> newItem) {
    setState(() {
      alatItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Alat'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildGrid(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormAlatPage(
                onSubmit: (Map<String, dynamic> newAlat) {
                  addAlat(newAlat);
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Cari',
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Expanded(
      child: GridView.builder(
        itemCount: alatItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return _gridItem(context, alatItems[index]);
        },
      ),
    );
  }

  Widget _gridItem(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditAlatPage(
              item: item,
              alatName: item['title'],
              onDelete: deleteAlat,
              onSave: saveAlat,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                item['image'],
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 10),
              Text(
                item['title'],
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
