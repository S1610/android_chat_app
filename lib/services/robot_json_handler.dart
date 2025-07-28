import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:android_chat_app/widgets/robot_price_widgets.dart';

class Product {
  final String title;
  final double initialPricePerItem;
  final Map<String, ModelData> modelsWithPrices;
  final String fallbackImageUrl;

  Product({
    required this.title,
    required this.initialPricePerItem,
    required this.modelsWithPrices,
    required this.fallbackImageUrl,
  });

  @override
  String toString() {
    return 'Product{title: $title, initialPrice: $initialPricePerItem, models: ${modelsWithPrices.length}, fallbackImg: $fallbackImageUrl}';
  }
}

class ProductLoader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Loads and parses a list of products from the Firestore `robotProducts` collection.
  Future<List<Product>> loadProductsFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore.collection('robotProducts').get();

      if (querySnapshot.docs.isEmpty) {
        print("Firestore collection 'robotProducts' is empty.");
        return [];
      }

      final List<Product> products = [];

      for (final doc in querySnapshot.docs) {
        final Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;

        final String title = (productData['title'] as String?)?.trim() ?? '';
        final double initialPrice = (productData['initialPricePerItem'] as num?)?.toDouble() ?? 0.0;
        final String fallbackImageUrl = (productData['fallbackImageUrl'] as String?)?.trim() ?? '';

        if (title.isEmpty) {
          print("Warning: Skipping product with empty title in Firestore.");
          continue;
        }

        final Map<String, ModelData> models = {};
        final List<dynamic>? modelsJson = productData['models'] as List<dynamic>?;

        if (modelsJson != null && modelsJson.isNotEmpty) {
          for (final modelJson in modelsJson) {
            if (modelJson is! Map<String, dynamic>) {
              print("Warning: Skipping non-object item in 'models' list for product '$title' in Firestore.");
              continue;
            }

            final String modelName = (modelJson['modelName'] as String?)?.trim() ?? '';
            final double? modelPrice = (modelJson['modelPrice'] as num?)?.toDouble();
            final String modelImageUrl = (modelJson['modelImageUrl'] as String?)?.trim() ?? '';
            final String modelDescription = (modelJson['modelDescription'] as String?)?.trim() ?? '';

            if (modelName.isNotEmpty && modelPrice != null && modelImageUrl.isNotEmpty && modelDescription.isNotEmpty) {
              models[modelName] = ModelData(
                price: modelPrice,
                imageUrl: modelImageUrl,
                description: modelDescription,
              );
            } else {
              print("Warning: Incomplete model data for '$title' - '$modelName' in Firestore. Skipping this model.");
            }
          }
        }

        if (models.isEmpty) {
          print("Warning: Product '$title' from Firestore has no valid models. Skipping product.");
          continue;
        }

        String finalFallbackImage = fallbackImageUrl.isNotEmpty ? fallbackImageUrl : "assets/images/placeholder.jpg";

        products.add(
          Product(
            title: title,
            initialPricePerItem: initialPrice,
            fallbackImageUrl: finalFallbackImage,
            modelsWithPrices: models,
          ),
        );
      }

      print("Successfully loaded ${products.length} products from Firestore.");
      return products;
    } catch (e, s) {
      print("Error loading or parsing products from Firestore: $e");
      print("Stacktrace: $s");
      return [];
    }
  }
}