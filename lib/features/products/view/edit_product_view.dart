import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/core/models/product_model.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/custom_app_bar.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_form.dart';
import 'package:supra_cart_admin/features/products/cubit/product_cubit.dart';
import 'package:supra_cart_admin/features/products/view/widget/drop_down.dart';
import '../../../core/helper_function/get_it_services.dart';
import '../../../core/helper_function/sign_out.dart';
import '../../../core/helper_function/validators.dart';
import '../../../core/utilis/constants.dart';
import '../../../core/utilis/show_dialog.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../../../core/widgets/product_img.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.selectedProduct});
  static const String routeName = '/editProduct';
  final ProductModel selectedProduct;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  String? selectedCategory;
   TextEditingController productNameController= TextEditingController();
   TextEditingController productPriceController= TextEditingController();
   TextEditingController productDescriptionController= TextEditingController();
   TextEditingController priceAfterDiscountController= TextEditingController();
  late GlobalKey<FormState> editProductFormKey;
  late AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled;
  double priceAfterDiscount=0;
  double currentPrice=0;
  @override
  void initState() {
    productNameController .text = widget.selectedProduct.name;
    productPriceController.text= widget.selectedProduct.price.toString();
    productDescriptionController.text=widget.selectedProduct.description;
    editProductFormKey = GlobalKey<FormState>();
    selectedCategory = widget.selectedProduct.category;
    super.initState();
  }
  dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    productDescriptionController.dispose();
    editProductFormKey.currentState?.dispose();
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProductCubit,ProductState>(builder: (context,state){
      var cubit = context.read<ProductCubit>();
      return Scaffold(
        appBar: customAppBar(context, title: 'Edit Product'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Stack(
            children: [
              Form(
                  key: editProductFormKey,
                  autovalidateMode: autovalidateMode,
                  child:CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child:
                        Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ProductPicture(
                                  height: 120.h,
                                  width: 240.w,
                                  imgUrl:
                                  widget.selectedProduct.imageUrl,
                                ),
                                Positioned(
                                  bottom: -20.h,
                                  right: 0.w,
                                  child: CircleAvatar(
                                    radius: 22.r,
                                    backgroundColor: Colors.black,
                                    child: IconButton(
                                      icon: Icon(Icons.camera_alt, size: 20.sp, color: Colors.white),
                                      onPressed: () {
                                        // فتح الصور أو الكاميرا لتغيير الصورة
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),

                            CustomTextFormField(hintText: 'Product Name',
                              controller:  productNameController,
                              validator: (String? val) {
                                return FormValidators.validateProductName(val);},

                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Flexible(
                                  child: CustomTextFormField(
                                    hintText: 'Product Price',
                                    keyboardType: TextInputType.number,
                                    controller: productPriceController,
                                    validator: (String? val) {
                                      return FormValidators.validateProductPrice(val);
                                    },
                                  ),
                                ),
                                Spacer(),
                                Flexible(
                                  child: CustomTextFormField(
                                    hintText: 'New Price',
                                    keyboardType: TextInputType.number,
                                    controller: priceAfterDiscountController,
                                    onChanged: (String?val){
                                      updateDiscount(val);

                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            DropDownList(
                              selectedCategory: selectedCategory,
                              dropDownList:DropDownListList, text: 'Category',
                              onChanged: (String? val) {
                                selectedCategory = val;
                                setState(() {});
                              },
                              validator: (String? val) {
                                return FormValidators.validateProductCategory(val);
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomTextFormField(
                              hintText: 'Product Description',
                              maxLines: 5,
                              controller: productDescriptionController,
                              validator: (String? val) {
                                return FormValidators.validateProductDescription(val);
                              },
                              keyboardType: TextInputType.multiline,
                            ),
                            SizedBox(height: 40.h),
                            Center(
                              child: CustomTextButton(
                                onPressed: () {
                                  if (editProductFormKey.currentState!.validate()) {
                                    ProductModel updatedProduct=widget.selectedProduct.copyWith(
                                      name: productNameController.text.trim(),
                                      price:priceAfterDiscountController.text.isNotEmpty? double.tryParse(priceAfterDiscountController.text):
                                      double.tryParse(productPriceController.text),
                                      oldPrice:priceAfterDiscountController.text.isNotEmpty?double.tryParse(productPriceController.text):0,
                                      description: productDescriptionController.text.trim(),
                                      category: selectedCategory ?? widget.selectedProduct.category,
                                      imageUrl: widget.selectedProduct.imageUrl,
                                    );
                                    cubit.updateProduct(updatedProduct);
                                    print('Product updated successfully');
                                    setState(() {
                                      autovalidateMode = AutovalidateMode.disabled;
                                    });
                                  } else {
                                    setState(() {
                                      autovalidateMode = AutovalidateMode.always;
                                    });
                                  }
                                },
                                text: 'Apply Changes',isLoading: state is UpdateProductLoading,
                                style: textStyle.Bold20.copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              if (widget.selectedProduct.oldPrice != 0||priceAfterDiscount!=0)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                    child: Text('${widget.selectedProduct.getSale(priceBeforeDiscount:currentPrice,priceAfterDiscount: priceAfterDiscount)} % OFF', style: textStyle.semiBold16.copyWith(
                        color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },       listener: (context, state) async {
      var cubit=context.read<ProductCubit>();
      if (state is UpdateProductSuccess) {
        customSnackBar(
          context: context,
          msg: "Product updated successfully",
          isError: false,
        );
         await cubit.getAllProducts();
        Navigator.pop(context);

      } else if (state is UpdateProductFailure) {
        customSnackBar(
          context: context,
          msg: 'Failed to update product,Try Again',
        );
      }
      else if (state is AccessTokenExpired) {
        customDialog(context: context,
          title: 'Session Expired',
          content: 'Your session has expired. please log in again',
          actionText: 'Log Out',
          onAction: () {
            signOut(context, getIt.get<SharedPreferences>());
          },
        );
      }
    },
    );
  }

  void updateDiscount(String? val) {
    priceAfterDiscount = double.tryParse(val??'')??0;
    currentPrice = double.tryParse(productPriceController.text)??0;

    setState(() {});
  }
}
