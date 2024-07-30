import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Common/utils/storage_utils.dart';
import 'package:myecomapp/Common/widgets/custom_text_field.dart';
import 'package:myecomapp/Common/widgets/toast_msg.dart';
import 'package:myecomapp/Features/Home%20Page/ui/pages/home_screen.dart';
import 'package:myecomapp/Features/Login%20Page/bloc/loginwithsocialmedia_bloc.dart';
import 'package:myecomapp/Features/Login%20Page/bloc/loginwithsocialmedia_event.dart';
import 'package:myecomapp/Features/Login%20Page/cubit/user_cubit.dart';
import 'package:myecomapp/Features/Login%20Page/model/user_model.dart';
import 'package:myecomapp/Features/Login%20Page/ui/widgets/bottom_condition_text.dart';
import 'package:myecomapp/Features/Login%20Page/ui/widgets/custom_icon_button.dart';
import 'package:myecomapp/Features/Login%20Page/ui/widgets/login_header_text.dart';
import 'package:myecomapp/Features/Login%20Page/ui/widgets/or_text_divider.dart';
import 'package:myecomapp/Features/Login%20Page/ui/widgets/sign_up_btntext.dart';
import 'package:page_transition/page_transition.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool rememberMe = false;
  bool isLoading = false;
  final GlobalKey<FormBuilderState> _loginFormKey =
      GlobalKey<FormBuilderState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    initialization();
    super.initState();
  }

  Future initialization() async {
    final response = await StorageUtils.getLoginCredential();
    emailController.text = response.email;
    passwordController.text = response.password;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //remove keyboard focus
        return FocusScope.of(context).unfocus();
      },
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          body: BlocListener<LoginwithsocialmediaBloc, CommonState>(
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

              if (state is CommonSuccessState<UserModel>) {
                //Login Success Message Toast
                toastMsg(context, "Login Success", Colors.green);
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const HomeScreen(),
                        type: PageTransitionType.fade));
              } else if (state is CommonErrorState) {
                //Login Error or Failed Message Toast
                toastMsg(context, state.errorMsg, Colors.red);
              }
            },
            child: BlocListener<UserCubit, CommonState>(
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

                if (state is CommonSuccessState<UserModel>) {
                  //Login Success Message Toast
                  toastMsg(context, "Login Success", Colors.green);
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const HomeScreen(),
                          type: PageTransitionType.fade));
                } else if (state is CommonErrorState) {
                  //Login Error or Failed Message Toast
                  toastMsg(context, state.errorMsg, Colors.red);
                } else {
                  return;
                }
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),

                  //Welcome and info Text
                  const SliverToBoxAdapter(
                    child: LoginHeaderText(),
                  ),

                  //Textfields
                  FormBuilder(
                    key: _loginFormKey,
                    child: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),

                          //textfield of Email
                          CustomTextField(
                            controller: emailController,
                            fieldName: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email can't be empty";
                              } else if (EmailValidator.validate(value)) {
                                return null;
                              } else {
                                return "please enter valid email";
                              }
                            },
                            title: "Email",
                            hintText: "Enter email address",
                            icon: Icons.person,
                          ),

                          //textfield of passeword
                          CustomTextField(
                            controller: passwordController,
                            fieldName: "Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password can't be Empty";
                              } else if (value.length <= 4) {
                                return "Password must have at least 4 character";
                              } else {
                                return null;
                              }
                            },
                            title: "Password",
                            hintText: "Enter password",
                            icon: Icons.lock,
                            isPasswordField: true,
                            bottomMargin: 10,
                          ),

                          //Remember Me
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Transform.scale(
                                  scale: 0.6,
                                  child: CupertinoSwitch(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //or
                          const OrTextDivider(),

                          //Login with social Media
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Login with facebook
                              CustomIconButton(
                                onPressed: () {
                                  context
                                      .read<LoginwithsocialmediaBloc>()
                                      .add(LoginwithsocialFacebookEvent());
                                },
                                size: 30,
                                icon: FontAwesomeIcons.facebook,
                                iconColor: Colors.blue,
                              ),

                              //Login with google
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomIconButton(
                                  size: 30,
                                  onPressed: () {
                                    context
                                        .read<LoginwithsocialmediaBloc>()
                                        .add(
                                          LoginwithsocialGooogleEvent(),
                                        );
                                  },
                                  icon: FontAwesomeIcons.google,
                                  iconColor: Colors.red,
                                ),
                              ),

                              //Login with apple
                              CustomIconButton(
                                onPressed: () {},
                                size: 30,
                                icon: FontAwesomeIcons.apple,
                                iconColor: Colors.black,
                              ),
                            ],
                          ),

                          //Login Button
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: MaterialButton(
                              onPressed: () {
                                //remove keyboard focus
                                FocusScope.of(context).unfocus();

                                //called the bloc
                                if (_loginFormKey.currentState!
                                    .saveAndValidate()) {
                                  context.read<UserCubit>().login(
                                        email: _loginFormKey
                                            .currentState!.value["Email"],
                                        password: _loginFormKey
                                            .currentState!.value["Password"],
                                        rememberMe: rememberMe,
                                      );
                                }
                              },
                              color: Theme.of(context).primaryColor,
                              height: 45,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              minWidth: double.infinity,
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          //Don't have accout and sign up
                          const SignUpButtonText(),
                        ],
                      ),
                    ),
                  ),

                  //term and Condition
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: BottomConditionText(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
