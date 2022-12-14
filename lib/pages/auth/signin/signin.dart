import 'package:flutter/material.dart';
import 'package:my_ride/components/loading_button.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/text_form_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State createState() => _SignInPageState();
}

class _SignInPageState extends StateMVC<SignInPage> with ValidationMixin {
  _SignInPageState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;
  bool obscureValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const SizedBox(),
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: Form(
              key: con.model.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Center(
                        child: Image(
                          height: 100,
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      EditTextForm(
                        validator: validateEmail,
                        controller: con.model.emailController,
                        isMuchDec: true,
                        readOnly: false,
                        obscureText: false,
                        label: 'Email',
                      ),
                      const SizedBox(height: 10),
                      EditTextForm(
                        onPasswordToggle: () {
                          setState(() {
                            obscureValue = !obscureValue;
                          });
                        },
                        suffixIcon: obscureValue
                            ? Icons.visibility_off
                            : Icons.visibility,
                        obscureText: obscureValue,
                        isMuchDec: true,
                        readOnly: false,
                        controller: con.model.passwordController,
                        label: 'Password',
                        validator: validatePassword,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 40,
                            right: Adaptive.w(15),
                            left: Adaptive.w(15)),
                        child: LoadingButton(
                          label: "Sign In",
                          onPressed: con.signIn,
                          disabled: false,
                          isLoading: con.model.isLoginLoading,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>Routers.pushNamed(context, '/forgot'),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
