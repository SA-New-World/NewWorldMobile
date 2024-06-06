import 'package:flutter/material.dart';
import 'package:new_world_mobile/models/Cart.dart';
import 'package:new_world_mobile/models/product.dart';
import 'package:new_world_mobile/view/pages/product_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatefulWidget {
  final String cardImg;
  final String cardName;
  final double cardPrice;
  final Product product;

  const ProductCard({
    super.key,
    required this.cardImg,
    required this.cardName,
    required this.cardPrice,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0; // Initialize quantity state

  void initState() {
    super.initState();
    quantity = Cart.instance.getQuantity(widget.product) ??
        0; // Fetch initial quantity
  }

  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: 400), // Constraint to a maximum width
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            widget.cardName,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),

          // Use FadeInImage for smooth loading (assuming network image)
          widget.cardImg.startsWith('http')
              ? FadeInImage(
                  placeholder: const AssetImage(
                      'assets/placeholder.png'), // Placeholder image
                  image: NetworkImage(widget.cardImg),
                  fit: BoxFit.cover,
                  width:
                      double.infinity, // Make image take full width available
                  height: 200, // Adjust height as needed
                )
              : SizedBox(
                  width:
                      double.infinity, // Make image take full width available
                  height: 200, // Adjust height as needed
                  child: Image.asset(widget.cardImg, fit: BoxFit.cover),
                ),

          // Buttons section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: widget.product,
                          ),
                        ),
                      );
                    },
                    child: const Text('En savoir plus'),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          const Size(100, 40), // Set desired width and height
                      textStyle: const TextStyle(
                          fontSize: 14), // Reduce font size if needed
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10), // Adjust padding
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Quantity management section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: quantity > 0
                      ? () => setState(() {
                            quantity--;
                            Cart.instance.setQuantity(widget.product, quantity);
                          })
                      : null,
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: TextEditingController(text: '$quantity'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final parsedQuantity = int.tryParse(value) ?? 0;
                      if (parsedQuantity >= 0) {
                        setState(() {
                          quantity = parsedQuantity;
                          Cart.instance.setQuantity(widget.product, quantity);
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.red,
                  onPressed: () => setState(() {
                    quantity++;
                    Cart.instance.setQuantity(widget.product, quantity);
                  }),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => setState(() {
                    quantity = 0;
                    Cart.instance.deleteFromCart(widget.product);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
