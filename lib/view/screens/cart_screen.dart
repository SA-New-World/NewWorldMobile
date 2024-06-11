import 'package:flutter/material.dart';
import 'package:new_world_mobile/models/Cart.dart';
import 'package:new_world_mobile/services/settings/settings.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../services/api/api_service.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cart = [];
  Map<String, int> quantity = {};
  Future<void>? _future;

  Future<void> setProducer() async {
    List<Product> products = [];
    ApiService service = ApiService();
    User? user = Settings().user;
    if (user != null) {
      products = await service.getCart(user.login, user.password);
      for (Product product in products) {
        quantity[product.name] = Cart().getQuantity(product);
      }
      print(quantity);
    }
    setState(() {
      cart = products;
    });
  }

  @override
  void initState() {
    super.initState();
    _future = setProducer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New World'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            double total = cart.fold(
                0,
                (sum, item) =>
                    sum +
                    (item.price * (quantity[item.name] ?? item.quantity)));
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      final productQuantity =
                          quantity[product.name] ?? product.quantity;
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('${product.price} € x $productQuantity'),
                        trailing: Text(
                            '${(product.price * productQuantity).toStringAsFixed(2)} €'),
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${total.toStringAsFixed(2)} €',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your order submission logic here
                    },
                    child: const Text('Passer la commande'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
