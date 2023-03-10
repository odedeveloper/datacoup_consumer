import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/account/update_account.dart';
import 'package:intl/intl.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({Key? key, this.title}) : super(key: key);
  final String? title;

  final controller = Get.find<HomeController>();
  final newsController = Get.find<NewsController>();
  final userProfileController = Get.find<UserProfileController>();

  void openDialog(BuildContext context) {
    Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              content: SizedBox(
                width: width(context)!,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CacheImageWidget(
                      fromAsset: true,
                      imageUrl: AssetConst.LOCATION,
                      imgheight: height(context)! * 0.07,
                      imgwidth: width(context)! * 0.15,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      StringConst.LOCATION,
                      textAlign: TextAlign.center,
                      style: themeTextStyle(
                          context: context,
                          fsize: klargeFont(context),
                          fweight: FontWeight.w900,
                          fontFamily: AssetConst.QUICKSAND_FONT),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Country",
                            style: themeTextStyle(
                              context: context,
                              tColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "State",
                            style: themeTextStyle(
                              context: context,
                              tColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.6),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: CSCPicker(
                        layout: Layout.horizontal,
                        showCities: false,
                        currentCountry: newsController.selectedcountry.value,
                        stateDropdownLabel: newsController.selectedState.value,
                        dropdownDecoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          boxShadow: const [
                            BoxShadow(spreadRadius: 0.4, blurRadius: 0.4)
                          ],
                        ),
                        disabledDropdownDecoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          boxShadow: const [
                            BoxShadow(spreadRadius: 0.4, blurRadius: 0.4)
                          ],
                        ),
                        flagState: CountryFlag.DISABLE,
                        disableCountry: false,
                        selectedItemStyle: themeTextStyle(context: context),
                        onCountryChanged: (value) {
                          controller.selectedreturnCountry!(value);
                          newsController.selectedcountry(value);
                        },
                        onStateChanged: (value) {
                          controller.selectedreturnState!(value);
                          newsController.selectedState(value);
                        },
                        onCityChanged: (value) {},
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // CustomLoginTextField(
                    //   controller: controller.zipCodeTextContoller,
                    //   label: "Zipcode",
                    // ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                newsController.selectedcountry(
                                    controller.user!.value.country);
                                newsController.selectedState(
                                    controller.user!.value.state);
                                newsController.selectedzipCode(
                                    controller.user!.value.zipCode);
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: const StadiumBorder(
                                    side: BorderSide(color: Colors.grey)),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RoundedElevatedButton(
                              onClicked: () async {
                                newsController.selectedcountry(
                                    controller.selectedreturnCountry!.value);
                                newsController.selectedState(
                                    controller.selectedreturnState!.value);
                                newsController.selectedzipCode(
                                    controller.zipCodeTextContoller!.text);
                                Get.back();
                                newsController.refreshAll();
                              },
                              color: deepOrangeColor,
                              title: "Apply",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.user?.value;

      return AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Welcome Back !",
                style: themeTextStyle(
                  tColor: Theme.of(context).primaryColor,
                  fsize: 24,
                  fweight: FontWeight.w800,
                  fontFamily: AssetConst.QUICKSAND_FONT,
                  context: context,
                )),
            Text(
              DateFormat('MMMM d').format(DateTime.now()),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: themeTextStyle(
                tColor: Colors.grey.shade500,
                fsize: 16,
                fweight: FontWeight.w700,
                fontFamily: AssetConst.QUICKSAND_FONT,
                context: context,
              ),
            ),
          ]),
          const Spacer(),
          // InkWell(
          //   onTap: () async {
          //     Get.to(FavouriteScreen());
          //   },
          //   child: const FaIcon(
          //     FontAwesomeIcons.bookmark,
          //     size: 23,
          //   ),
          // ),
          // const SizedBox(
          //   width: 20,
          // ),
          user?.firstName == null
              ? const Center(
                  child: SpinKitThreeBounce(
                  size: 25,
                  duration: Duration(milliseconds: 800),
                  color: Colors.grey,
                ))
              : IconButton(
                  onPressed: () async {
                    openDialog(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.locationDot,
                    size: 25,
                  ),
                ),
          const SizedBox(
            width: 35,
          ),
          InkWell(
              onTap: () async {
                Get.put(UserProfileController());
                userProfileController.isUpdating(false);
                userProfileController.loadUpdatedUserData();
                await Get.to(() => const UpdateAccount())!
                    .then((value) => userProfileController.fetchUserProfile());
              },
              child: controller.user == null ||
                      controller.user!.value.firstName == null
                  ? const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: FaIcon(
                        FontAwesomeIcons.solidUser,
                        color: deepOrangeColor,
                        size: 16,
                      ),
                    )
                  : controller.user!.value.profileImage!.contains("jpg") ||
                          controller.user!.value.profileImage!.contains("png")
                      ? CircleAvatar(
                          radius: 22,
                          backgroundColor: deepOrangeColor,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: greyColor,
                            backgroundImage: NetworkImage(
                                controller.user!.value.profileImage!),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          child: FaIcon(
                            FontAwesomeIcons.solidUser,
                            color: deepOrangeColor,
                            size: 16,
                          ),
                        )),
        ]),

        // leading: user?.firstName == null
        //     ? const Center(
        //         child: SpinKitThreeBounce(
        //         size: 25,
        //         duration: Duration(milliseconds: 800),
        //         color: Colors.grey,
        //       ))
        //     : InkWell(
        //         onTap: () async {
        //           openDialog(context);
        //         },
        //         child:
        //       const FaIcon(
        //         FontAwesomeIcons.locationDot,
        //         size: 22,
        //       ),
        //       const SizedBox(width: 5),
        //       SizedBox(
        //         width: 60,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               newsController.selectedcountry.value,
        //               maxLines: 1,
        //               overflow: TextOverflow.ellipsis,
        //               style: themeTextStyle(
        //                 context: context,
        //                 fsize: kminiFont(context)! - 2,
        //                 fweight: FontWeight.w500,
        //               ),
        //             ),
        //             Text(
        //               newsController.selectedState.value,
        //               maxLines: 1,
        //               overflow: TextOverflow.ellipsis,
        //               style: themeTextStyle(
        //                 context: context,
        //                 fsize: kminiFont(context)! - 2,
        //                 fweight: FontWeight.w500,
        //               ),
        //             ),
        //             Text(
        //               newsController.selectedzipCode.value,
        //               overflow: TextOverflow.ellipsis,
        //               maxLines: 1,
        //               style: themeTextStyle(
        //                 context: context,
        //                 fsize: kminiFont(context)! - 2,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // centerTitle: true,
        // title: title != null
        //     ? Text(
        //         title!,
        //         style: themeTextStyle(
        //           context: context,
        //           fsize: klargeFont(context),
        //           fweight: FontWeight.bold,
        //         ),
        //       )
        //     : CacheImageWidget(
        //         fromAsset: true,
        //         imageUrl: AssetConst.LOGO_PNG,
        //         imgheight: height(context)! * 0.05,
        //         imgwidth: width(context)! * 0.12,
        //       ),
        // actions: [
        //   Row(
        //     children: [
        //       user?.firstName == null
        //           ? const Center(
        //               child: SpinKitThreeBounce(
        //               size: 25,
        //               duration: Duration(milliseconds: 800),
        //               color: Colors.grey,
        //             ))
        //           : SizedBox(
        //               width: 80,
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 children: [
        //                   Text(
        //                     user!.firstName!,
        //                     maxLines: 1,
        //                     textAlign: TextAlign.right,
        //                     overflow: TextOverflow.ellipsis,
        //                     style: themeTextStyle(
        //                       context: context,
        //                       fsize: ksmallFont(context),
        //                       fweight: FontWeight.w500,
        //                     ),
        //                   ),
        //                   Text(
        //                     DateFormat('MMMM d').format(DateTime.now()),
        //                     maxLines: 1,
        //                     overflow: TextOverflow.ellipsis,
        //                     style: themeTextStyle(
        //                       context: context,
        //                       fsize: kminiFont(context),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //       const SizedBox(width: 5),
        //     InkWell(
        //         onTap: () async {
        //           Get.put(UserProfileController());
        //           userProfileController.isUpdating(false);
        //           userProfileController.loadUpdatedUserData();
        //           await Get.to(() => const UpdateAccount())!.then(
        //               (value) => userProfileController.fetchUserProfile());
        //           // controller.showSaveButton(false);
        //           // controller.profileImage = null;
        //           // UpdateAccount
        //           // Get.to(() => const UpdateAccount());
        //           // await userProfileController.loadUpdatedUserData();
        //           // await Get.to(() => UpdateAccount());
        //           // !.then((_) async {
        //           //   loadData();
        //           // });
        //         },
        //         child: controller.user == null ||
        //                 controller.user!.value.firstName == null
        //             ? const CircleAvatar(
        //                 radius: 18,
        //                 backgroundColor: Colors.grey,
        //                 child: FaIcon(
        //                   FontAwesomeIcons.solidUser,
        //                   color: deepOrangeColor,
        //                   size: 16,
        //                 ),
        //               )
        //             : controller.user!.value.profileImage!.contains("jpg") ||
        //                     controller.user!.value.profileImage!
        //                         .contains("png")
        //                 ? CircleAvatar(
        //                     radius: 18,
        //                     backgroundColor: Colors.grey,
        //                     child: CircleAvatar(
        //                       radius: 16,
        //                       backgroundColor: Colors.grey,
        //                       backgroundImage: NetworkImage(
        //                           controller.user!.value.profileImage!),
        //                     ),
        //                   )
        //                 : const CircleAvatar(
        //                     radius: 18,
        //                     backgroundColor: Colors.grey,
        //                     child: FaIcon(
        //                       FontAwesomeIcons.solidUser,
        //                       color: deepOrangeColor,
        //                       size: 16,
        //                     ),
        //                   )),
        //     const SizedBox(width: 10),
        //   ],
        // ),
      );
    });
  }
}
