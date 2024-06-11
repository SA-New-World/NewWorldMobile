import 'package:flutter/material.dart';
import 'package:new_world_mobile/services/settings/settings.dart';
import 'package:new_world_mobile/view/components/product_card.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../services/api/api_service.dart';
import '../components/search_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  static const routeName = '/product';

  List<Product> card = [];
  TextEditingController searchController = TextEditingController();
  Future<List<Product>>? searchFuture;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    if (searchFuture == null) {
      ApiService service = ApiService();
      List<Product> products = await service.getAllProducts();
      setState(() {
        card = products;
      });
    } else {
      setState(() {
        searchFuture = null;
      });
    }
  }

  void searchProduct(String name) {
    if (name.isNotEmpty && name.trim().isNotEmpty) {
      User? user = Settings().user;
      if (user != null) {
        setState(() {
          searchFuture =
              ApiService().searchProduct(user.login, user.password, name);
        });
      }
    } else {
      setState(() {
        searchFuture = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchFuture ?? Future.value(card),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            children: [
              CustomSearchBar(
                  searchController: searchController, onSearch: searchProduct),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ProductCard(
                        cardName: snapshot.data![index].name,
                        cardPrice: snapshot.data![index].price,
                        cardImg: 'images/${snapshot.data![index].name}.jpg',
                        product: snapshot.data![index],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
