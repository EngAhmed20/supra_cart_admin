import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/core/helper_function/sign_out.dart';
import 'package:supra_cart_admin/core/models/product_model.dart';
import 'package:supra_cart_admin/core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_form.dart';
import 'package:supra_cart_admin/features/products/cubit/product_cubit.dart';
import 'package:supra_cart_admin/features/products/view/widget/drop_down.dart';
import '../../../core/helper_function/get_it_services.dart';
import '../../../core/helper_function/validators.dart';
import '../../../core/utilis/constants.dart';
import '../../../core/utilis/pick_img.dart';
import '../../../core/utilis/show_dialog.dart';
import '../../../core/widgets/custom_snack_bar.dart';

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
  late AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  File? pickedImage;

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
    return BlocConsumer<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = context.read<ProductCubit>();
        return Scaffold(
          appBar: customAppBar(context, title: 'Add New Product'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            child: Form(
              key: editProductFormKey,
              autovalidateMode: autovalidateMode,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
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
                                backgroundImage:
                                    pickedImage != null
                                        ? FileImage(pickedImage!)
                                        : null,
                                child:
                                    pickedImage == null
                                        ? Icon(
                                          Icons.camera_alt,
                                          size: 30.sp,
                                          color: Colors.grey,
                                        )
                                        : null,
                              ),
                            ),
                            Positioned(
                              bottom: -20.h,
                              right: 0.w,
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Colors.black,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    pickedImage = await pickImage(
                                      picker: getIt.get<ImagePicker>(),
                                    );

                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),

                        CustomTextFormField(
                          hintText: 'Product Name',
                          controller: productNameController,
                          validator: (String? val) {
                            return FormValidators.validateProductName(val);
                          },
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
                                  return FormValidators.validateProductPrice(
                                    val,
                                  );
                                },
                              ),
                            ),
                            Spacer(),
                            Flexible(
                              child: CustomTextFormField(
                                hintText: 'Old Price',
                                keyboardType: TextInputType.number,
                                controller: oldPriceController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        DropDownList(
                          selectedCategory: selectedCategory,
                          onChanged: (String? val) {
                            selectedCategory = val;
                            setState(() {});
                          },
                          validator: (String? val) {
                            return FormValidators.validateProductCategory(val);
                          },
                          dropDownList: DropDownListList,
                          text: 'Category',
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          hintText: 'Product Description',
                          maxLines: 5,
                          controller: productDescriptionController,
                          validator: (String? val) {
                            return FormValidators.validateProductDescription(
                              val,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(height: 40.h),
                        Center(
                          child: CustomTextButton(
                            onPressed: () async {
                              if (editProductFormKey.currentState!.validate() &&
                                  pickedImage != null) {
                                ProductModel product = ProductModel(
                                  name: productNameController.text,
                                  price: double.parse(
                                    productPriceController.text,
                                  ),
                                  oldPrice:
                                      oldPriceController.text.isNotEmpty
                                          ? double.parse(
                                            oldPriceController.text,
                                          )
                                          : 0,
                                  category: selectedCategory!,
                                  description:
                                      productDescriptionController.text,
                                  imageUrl: '',
                                );
                                await cubit.addProduct(product, pickedImage!);

                              } else {
                                if (pickedImage == null) {
                                  customSnackBar(
                                    context: context,
                                    msg: 'Please pick a product image.',
                                    isError: true,
                                  );
                                }
                                setState(() {
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              }
                            },
                            text: 'Apply Changes',
                            isLoading: state is AddProductLoading,
                            style: textStyle.Bold20.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddProductSuccess) {
          customSnackBar(
            context: context,
            msg: "Product added successfully",
            isError: false,
          );
          clear();
        } else if (state is AddProductFailure) {
          customSnackBar(
            context: context,
            msg: 'Failed to add product,Try Again',
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

  clear(){
    productNameController.clear();
    productPriceController.clear();
    oldPriceController.clear();
    selectedCategory=null;
    productDescriptionController.clear();
    pickedImage=null;
    autovalidateMode = AutovalidateMode.disabled;
    setState(() {

    });

  }
}
