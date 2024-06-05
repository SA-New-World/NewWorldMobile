import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_world_mobile/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  static const routeName = '/product/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset('images/${product.name.toLowerCase()}.jpg',
                  height: 200),
            ),
            const SizedBox(height: 20),
            Text(
              'Description:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.description,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Quantité disponible:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.quantity.toString(),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Marque:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.brand,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Origine du produit:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.origin,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Pays de vente:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.saleCountry,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            if (product.nutriscore == "A")
              Center(
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Nutri-score-A_light_background_logo.svg/1280px-Nutri-score-A_light_background_logo.svg.png',
                  scale: 5,
                ),
              ),
            if (product.nutriscore == "B")
              Center(
                child: Image.network(
                  'https://www.pensersante.fr/sites/default/files/styles/medium_970x970/public/upload/apprendre-pour-mieux-manger/pour-quelles-raisons/l-alimentation-au-coeur-de-la-sante/valeur-nutritionnelle-des-aliments/nutriscore.jpg?itok=AiAmQDiC',
                  scale: 5,
                ),
              ),
            if (product.nutriscore == "C")
              Center(
                child: Image.network(
                  'https://fac.img.pmdstatic.net/scale/https.3A.2F.2Ffac.2Eimg.2Epmdstatic.2Enet.2Ffit.2Fhttp.2E3A.2E2F.2E2Fprd2-bone-image.2E2Es3-website-eu-west-1.2E2Eamazonaws.2E2Ecom.2E2FFAC.2E2Fvar.2E2Ffemmeactuelle.2E2Fstorage.2E2Fimages.2E2Fmedia.2E2Fimages.2E2Funnamed15.2E2F14962854-1-fre-FR.2E2Funnamed.2E2Ejpg.2F650x404.2Fquality.2F80.2Fthumbnail.2Ejpg/650xauto/quality/80/crop-from/center/picture.jpeg',
                  scale: 3,
                ),
              ),
            if (product.nutriscore == "D")
              Center(
                child: Image.network(
                  'https://img.freepik.com/vecteurs-premium/etiquette-officielle-nutri-score-score-illustration-vectorielle_797523-1646.jpg',
                  scale: 3,
                ),
              ),
            if (product.nutriscore == "E")
              Center(
                child: Image.network(
                  'https://static.vecteezy.com/ti/vecteur-libre/p1/27802340-etiquette-nutritionnel-nutri-score-vectoriel.jpg',
                  scale: 7,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
