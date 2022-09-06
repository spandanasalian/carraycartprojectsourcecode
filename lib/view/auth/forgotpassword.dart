import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/viewmodel/auth_viewmodel.dart';
import 'register_view.dart';
import '../../constants.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/custom_button.dart';

class ForgotPasswordView extends GetWidget<AuthViewModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: 16.w, left: 16.w, top: 126.h, bottom: 42.h),
            child: Column(
              children: [
                     Image.asset('assets/images/newlogo.png',height: 120,width:120),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Reset Password',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                             
                                CustomText(
                                  text: 'Check your email after submitting',
                                  fontSize: 18,
                                  color: primaryColor,
                                ),
                              
                            ],
                          ),
                        
                          SizedBox(
                            height: 48.h,
                          ),
                          CustomTextFormField(
                            title: 'Email',
                    
                            hintText: 'CarrayCart@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            validatorFn: (value) {
                              if (value!.isEmpty)
                                return 'Email invalid or not found';
                              return null;
                            },
                            onSavedFn: (value) {
                              controller.email = value;
                            },
                          ),
                      
                        
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomButton(
                            'Submit',
                           () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              controller.sendpasswordresetemail(controller.email!);
                            }
                          },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28.h,
                ),
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonSocial extends StatelessWidget {
  final VoidCallback onPressedFn;
  final String image;
  final String title;

  const CustomButtonSocial({
    required this.onPressedFn,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressedFn,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/icons/$image.png',
              fit: BoxFit.cover,
              height: 20.h,
              width: 20.h,
            ),
            CustomText(
              text: title,
              fontSize: 14,
            ),
            Container(width: 20.h),
          ],
        ),
      ),
    );
  }
}
