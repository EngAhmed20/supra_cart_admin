import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supra_cart_admin/core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_form.dart';
import 'package:supra_cart_admin/features/products/view/widget/drop_down.dart';
import '../../../core/helper_function/validators.dart';
import '../../../core/utilis/constants.dart';
class AddProductView extends StatefulWidget {
  const AddProductView({super.key});
  static const String routeName = '/addProduct';

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  String? selectedCategory;
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController oldPriceController;
  late TextEditingController productDescriptionController;
  late GlobalKey<FormState> editProductFormKey;
  late AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled;
  File?pickedImage;
  final ImagePicker picker = ImagePicker();


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
      appBar: customAppBar(context, title: 'Add New Product'),
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
                          CircleAvatar(
                            radius: 44.r,
                            backgroundColor: Colors.blue,
                            child: CircleAvatar(
                              radius: 40.r,
                              backgroundColor: Colors.grey[200],
                               backgroundImage:pickedImage !=null?
                              FileImage(pickedImage!):null,
                              child:pickedImage==null?
                              Icon(Icons.camera_alt, size: 30.sp, color: Colors.grey):
                              null,
                            ),
                          ),
                          Positioned(
                            bottom: -20.h,
                            right: 0.w,
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.black,
                              child: IconButton(
                                icon: Icon(Icons.camera_alt, size: 20.sp, color: Colors.white),
                                onPressed: () {
                                  pickImg();
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
                        onChanged: (String? val) {
                          selectedCategory = val;
                          print(val);
                          setState(() {});
                        },
                        validator: (String? val) {
                          return FormValidators.validateProductCategory(val);
                        }, dropDownList:DropDownListList, text: 'Category',
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
  Future<void>pickImg()async{
    final XFile? image=await picker.pickImage(source: ImageSource.gallery);
    if(image!=null ){
      setState(() {
        pickedImage= File(image.path);
      });
    }
  }
}
