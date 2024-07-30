import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Common/widgets/custom_text_field.dart';
import 'package:myecomapp/Common/widgets/toast_msg.dart';
import 'package:myecomapp/Features/Login%20Page/ui/pages/login_screen.dart';
import 'package:myecomapp/Features/Sign%20Up%20Page/cubit/signup_cubit.dart';
import 'package:myecomapp/Features/Sign%20Up%20Page/ui/widgets/login_text_btn.dart';
import 'package:myecomapp/Features/Sign%20Up%20Page/ui/widgets/signup_header_text.dart';
import 'package:page_transition/page_transition.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormBuilderState> _signupFormKey =
      GlobalKey<FormBuilderState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),

            //header text
            const SliverToBoxAdapter(
              child: SignUpHeaderText(),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),

            //Text Field Area
            BlocListener<SignupCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  setState(() {
                    isLoading = true;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }

                if (state is CommonSuccessState) {
                  toastMsg(context, "User Register Success", Colors.green);
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const LoginScreen(),
                        type: PageTransitionType.fade),
                  );
                } else if (state is CommonErrorState) {
                  toastMsg(context, state.errorMsg, Colors.red);
                }
              },
              child: FormBuilder(
                key: _signupFormKey,
                child: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      //text field of user's Name
                      CustomTextField(
                        fieldName: "Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name can't be empty";
                          } else {
                            return null;
                          }
                        },
                        title: "",
                        bottomMargin: 0,
                        hintText: "Enter full name",
                        icon: Icons.person_add,
                      ),

                      //text field of user's Email
                      CustomTextField(
                        fieldName: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can't be empty";
                          } else if (EmailValidator.validate(value)) {
                            return null;
                          } else {
                            return "please enter valid email address";
                          }
                        },
                        title: "",
                        bottomMargin: 0,
                        hintText: "example@gmail.com",
                        icon: Icons.email,
                      ),

                      //text field of user's password
                      CustomTextField(
                        controller: passwordController,
                        fieldName: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Passport can't be empty";
                          } else {
                            return null;
                          }
                        },
                        title: "",
                        bottomMargin: 0,
                        hintText: "password",
                        isPasswordField: true,
                        icon: Icons.lock,
                      ),

                      //text field of user's Confirm password
                      CustomTextField(
                        controller: confirmPasswordController,
                        fieldName: "Confirm password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password can't be empty";
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            return "Confirm password doesn't match with Password";
                          } else {
                            return null;
                          }
                        },
                        title: "",
                        bottomMargin: 0,
                        hintText: "Confirm password",
                        isPasswordField: true,
                        icon: Icons.lock,
                      ),

                      //text field of user's phone number
                      CustomTextField(
                        fieldName: "Phone number",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number can't be empty";
                          } else {
                            return null;
                          }
                        },
                        title: "",
                        bottomMargin: 0,
                        hintText: "98********",
                        icon: Icons.phone,
                        numKeyboardType: true,
                      ),

                      //text field of user's address
                      CustomTextField(
                        fieldName: "Address",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Address can't be empty";
                          } else {
                            return null;
                          }
                        },
                        title: "",
                        bottomMargin: 0,
                        hintText: "Address",
                        icon: Icons.location_on,
                      ),

                      //sign up button
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 25, left: 25, top: 28),
                        child: MaterialButton(
                          onPressed: () {
                            //called bloc
                            if (_signupFormKey.currentState!
                                .saveAndValidate()) {
                              context.read<SignupCubit>().signUpUser(
                                  name: _signupFormKey
                                      .currentState!.value["Name"],
                                  email: _signupFormKey
                                      .currentState!.value["Email"],
                                  password: _signupFormKey
                                      .currentState!.value["Password"],
                                  phoneNumber: _signupFormKey
                                      .currentState!.value["Phone number"],
                                  address: _signupFormKey
                                      .currentState!.value["Address"]);
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          height: 45,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          minWidth: double.infinity,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //login text button
            const SliverFillRemaining(
              hasScrollBody: false,
              child: LoginTextButton(),
            )
          ],
        ),
      ),
    );
  }
}
