import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Home%20Page/cubit/home_banner_cubit.dart';
import 'package:myecomapp/Features/Home%20Page/ui/widgets/home_banner_loader.dart';

class HomeBannerSection extends StatefulWidget {
  const HomeBannerSection({
    super.key,
  });

  @override
  State<HomeBannerSection> createState() => _HomeBannerSectionState();
}

class _HomeBannerSectionState extends State<HomeBannerSection> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBannerCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoadingState) {
          return const HomeBannerLoader();
        } else if (state is CommonSuccessState<List<String>>) {
          return Stack(
            children: [
              //carousel Slider Section
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.22,
                child: CarouselSlider.builder(
                  itemCount: state.userModel.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: FadeInImage(
                            width: double.infinity,
                            image: NetworkImage(state.userModel[itemIndex]),
                            placeholder: const AssetImage(
                              "assets/images/placeholder.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      height: MediaQuery.of(context).size.height * 0.3),
                ),
              ),

              //carousel Indicator
              Positioned(
                right: 0,
                left: 0,
                bottom: 15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.userModel.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 10,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedIndex == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else if (state is CommonErrorState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Text(state.errorMsg),
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          );
        }
      },
    );
  }
}
