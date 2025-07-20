import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/features/products/view/edit_product_view.dart';
import 'package:supra_cart_admin/features/products/view/widget/product_card.dart';


class ProductViewBody extends StatelessWidget {
  const ProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context,index)=>ProductCard(productImg: 'https://img.freepik.com/free-photo/3d-rendering-cartoon-shopping-cart_23-2151680638.jpg?ga=GA1.1.220289254.1670056954&semt=ais_hybrid&w=740',
      productName: 'Lenovo IdeaPad 3',
       productDescription: 'Powerful and sleekformance Intel Core i7 processor, 16GB of RAM, and a fast 512GB SSD—perfect for multitasking, content creation, and gaming. The 15.6-inch Full HD display delivers vibrant visuals, while the lightweight aluminum design ensures portability wherever you.',
      productPrice: 120,productOldPrice: 200,editProductFun: (){
        Navigator.pushNamed(context,EditProductView.routeName);
      },
    viewProductFeedbackFun: (){},deleteProductFun: (){},),
        separatorBuilder: (context,index)=>Container(height: 5.h,), itemCount: 10);

  }

}
