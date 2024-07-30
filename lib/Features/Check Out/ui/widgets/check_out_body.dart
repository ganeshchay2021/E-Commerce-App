import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myecomapp/Common/app%20bar/my_app_bar.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Common/widgets/custom_text_field.dart';
import 'package:myecomapp/Common/widgets/toast_msg.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/cart_count_cubit.dart';
import 'package:myecomapp/Features/Check%20Out/cubit/create_order_cubit.dart';
import 'package:myecomapp/Features/Check%20Out/model/checkout_model.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';

class CheckOutBody extends StatefulWidget {
  const CheckOutBody({super.key});

  @override
  State<CheckOutBody> createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final userRepo = context.read<UserRepository>();
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: BlocListener<CreateOrderCubit, CommonState>(
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
              toastMsg(context, "Order Success", Colors.green);
              Navigator.popUntil(context, (route) => route.isFirst);
            } else if (state is CommonErrorState) {
              toastMsg(context, state.errorMsg, Colors.red);
            }
          },
          child: CustomScrollView(
            slivers: [
              myAppBar(context, "Check out"),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              FormBuilder(
                key: _formKey,
                child: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CustomTextField(
                        fieldName: "Name",
                        title: "Name",
                        hintText: "Enter your full name",
                        icon: Icons.person,
                        initialValue: userRepo.userModel?.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        fieldName: "Address",
                        title: "Address",
                        hintText: "Enter your address",
                        icon: Icons.location_on,
                        initialValue: userRepo.userModel?.address,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "address can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        fieldName: "City",
                        title: "City",
                        hintText: "Enter your  city",
                        icon: Icons.location_city,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "City can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextField(
                        fieldName: "Phone number",
                        title: "Phone number",
                        hintText: "Enter your phone number",
                        icon: Icons.phone,
                        initialValue: userRepo.userModel?.phone,
                        numKeyboardType: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "phone number can't be empty";
                          } else {
                            return null;
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        // if (_formKey.currentState!.saveAndValidate()) {
                        //   KhaltiScope.of(context).pay(
                        //     config: PaymentConfig(
                        //         amount: 1000,
                        //         productIdentity: "test",
                        //         productName: "test"),
                        //     onSuccess: (value) {
                        //       final param = CheckoutModel.fromMap(
                        //           _formKey.currentState!.value);
                        //       context
                        //           .read<CreateOrderCubit>()
                        //           .createOrder(param: param);
                        //     },
                        //     onFailure: (errorMsg) {
                        //       toastMsg(context, errorMsg.message, Colors.red);
                        //     },
                        //   );
                        // }

                        if (_formKey.currentState!.saveAndValidate()) {
                          final param = CheckoutModel.fromMap(
                              _formKey.currentState!.value);
                          context
                              .read<CreateOrderCubit>()
                              .createOrder(param: param);
                        }
                        context.read<CartCountCubit>().countClear();
                      },
                      child: const Text(
                        "Pay via Khalti",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
