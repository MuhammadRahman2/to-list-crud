import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final productNameC = TextEditingController();
  final productDetailC = TextEditingController();
  final productPriceC = TextEditingController();

  var products = [];

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey.withOpacity(0.3),
      barrierColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: productNameC,
                decoration: InputDecoration(
                    hintText: 'Enter Product Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: productDetailC,
                decoration: InputDecoration(
                    hintText: 'Enter Prouct Detail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: productPriceC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter Prouct Price',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size(double.infinity, 40)),
                  onPressed: () {
                    products.addAll({
                      productNameC.text,
                      productDetailC.text,
                      productPriceC.text
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Add Data'))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo Crud'),
        actions: [
          IconButton(
            onPressed: () {
              bottomSheet(context);
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: 
      // Column(
      //   children: [
          // ...products.map((e) => Text(e)).toList()
          ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index]),
              );
            },
          )
      //   ],
      // ),
    );
  }
}
