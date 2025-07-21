import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import 'package:supra_cart_admin/core/widgets/custom_app_bar.dart';

import '../../../core/helper_function/validators.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/custom_text_form.dart';
import '../../auth/view/widgets/login_button.dart';
import '../../products/view/widget/drop_down.dart';

class AddAdminView extends StatefulWidget {
  const AddAdminView({super.key});
  static const String routeName = '/addAdmin';

  @override
  State<AddAdminView> createState() => _AddAdminViewState();
}

class _AddAdminViewState extends State<AddAdminView> {
  @override
  void initState() {
    adminNameController= TextEditingController();
    adminEmailController= TextEditingController();
    adminPasswordController= TextEditingController();
    adminConfirmPasswordController= TextEditingController();
    addAdminFormKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }
  late TextEditingController adminNameController;
  bool hidePass = true;
  bool hideConfirmPass = true;
  late TextEditingController adminEmailController;

  late TextEditingController adminPasswordController;

  late TextEditingController adminConfirmPasswordController;

  late GlobalKey<FormState> addAdminFormKey;

  late AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled;
  String?selectedrole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Add New Admin'),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: addAdminFormKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: AppColors.kWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(hintText: 'Admin Name',
                          keyboardType: TextInputType.name,
                          controller: adminNameController,
                          validator: (value) {
                            return  FormValidators.validateName(value);
                          },
                        ),
                         SizedBox(height: 25.h),
                        CustomTextFormField(hintText: 'Admin Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: adminEmailController,
                          validator: (value) {
                            return FormValidators.validateEmail(value);
                          },
                        ),
                         SizedBox(height: 25.h),
                        CustomTextFormField(
                          hintText: 'Admin Password',
                          isPassword: true,
                          obscureText: hidePass,
                          controller: adminPasswordController,
                          onTogglePasswordVisibility: (){
                            changePasswordVisibility();
                          },
                          validator: (value) {
                            return FormValidators.validatePassword(value);
                          },
                        ),
                         SizedBox(height: 25.h),
                        CustomTextFormField(
                          hintText: 'Confirm Password',
                          isPassword: true,
                          obscureText: hideConfirmPass,
                          controller: adminConfirmPasswordController,
                          onTogglePasswordVisibility: () {
                            changeConfirmPasswordVisibility();
                          },
                          validator: (value) {
                            return FormValidators.validateConfirmPassword(value, adminPasswordController.text);
                          },
                        ),
                         SizedBox(height: 25.h),
                        DropDownList(

                          selectedCategory: selectedrole,
                          onChanged: (String? val) {
                            selectedrole = val;
                            print(val);
                            setState(() {});
                          },
                          validator: (String? val) {
                            return FormValidators.validateProductCategory(val);
                          }, dropDownList:adminRolesList, text: 'Role',
                        ),

                        SizedBox(height: 30.h,),
                        LoginButton(loginText: 'Confirm Addition',onTap: ()async {
                          if (addAdminFormKey.currentState!.validate()) {
                            // Handle the addition of the admin
                            // You can call your API or perform any action here
                            print('Admin Added: ${adminNameController.text}, ${adminEmailController.text}');
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },),
                      ],


                    ),
                  ),
                ),




              ],

            ),
          ),
        ),
      ),
    );

  }
  changePasswordVisibility() {
    setState(() {
      hidePass = !hidePass;
      // toggle password visibility logic
    });
  }
  changeConfirmPasswordVisibility() {
    setState(() {
     hideConfirmPass = !hideConfirmPass;
    });
  }
}
