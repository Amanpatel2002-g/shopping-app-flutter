import 'package:amazon_new/constants/loader.dart';
import 'package:amazon_new/features/admin/screen/add_product_screen.dart';
import 'package:amazon_new/features/admin/services/admin_service.dart';
import 'package:amazon_new/features/screens/account/widgets/single_product.dart';
import 'package:amazon_new/models/product_model.dart';
import 'package:flutter/material.dart';

class PostsScren extends StatefulWidget {
  const PostsScren({Key? key}) : super(key: key);

  @override
  State<PostsScren> createState() => _PostsScrenState();
}

class _PostsScrenState extends State<PostsScren> {
  final AdminServices adminServices = AdminServices();
  List<Product>? products;
  @override
  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProduct(context);
    setState(() {});
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductPage.routename);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    return products == null
        ? const Loader()
        : Scaffold(
            body: Expanded(
              child: SizedBox(
                height: 200,
                child: products!.isEmpty
                    ? Container()
                    : GridView.builder(
                        itemCount: products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          final productData = products![index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 140,
                                child:
                                    SingleProduct(image: productData.images[0]),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete_outlined)),
                                ],
                              ),
                            ],
                          );
                        }),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: "Add a product",
              onPressed: navigateToAddProduct,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
