import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/custom_app_bar.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_form.dart';
import 'package:supra_cart_admin/features/products/view/widget/drop_down.dart';

import '../../../core/helper_function/validators.dart';
import '../../../core/utilis/constants.dart';
import '../../../core/widgets/product_img.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key});
  static const String routeName = '/editProduct';

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  String? selectedCategory;
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController oldPriceController;
  late TextEditingController productDescriptionController;
  late GlobalKey<FormState> editProductFormKey;
  late AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled;
  @override
  void initState() {
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    oldPriceController = TextEditingController();
    productDescriptionController = TextEditingController();
    editProductFormKey = GlobalKey<FormState>();
    super.initState();
  }
  dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    oldPriceController.dispose();
    productDescriptionController.dispose();
    editProductFormKey.currentState?.dispose();
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppBar(context, title: 'Edit Product'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Form(
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
                          'https://img.freepik.com/free-photo/3d-rendering-cartoon-shopping-cart_23-2151680638.jpg?ga=GA1.1.220289254.1670056954&semt=ais_hybrid&w=740',
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
                            hintText: 'Old Price',
                            keyboardType: TextInputType.number,
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
                            // Handle the form submission logic here
                            // For example, you can call a method to update the product
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
                        text: 'Apply Changes',
                        style: textStyle.Bold20.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
