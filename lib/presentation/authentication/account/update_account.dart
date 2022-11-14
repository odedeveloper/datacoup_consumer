import 'dart:io';

import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/authentication/account/edit_email_phone.dart';
import 'package:datacoup/presentation/authentication/auth_controller/user_profile_controller.dart';
import 'package:datacoup/presentation/authentication/signup/verify_otp.dart';
import 'package:datacoup/presentation/widgets/custom_text.dart';

class UpdateAccount extends StatefulWidget {
  const UpdateAccount({Key? key}) : super(key: key);

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final imagePickerController = Get.put(ImagePickerController());

  final controller = Get.find<UserProfileController>();

  @override
  void initState() {
    controller.loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future openDialog(bool isByEmail) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Center(
                      child: CustomText(
                    'You will recieve an OTP on your changed ${isByEmail ? 'Email.' : 'Mobile Number.'} \n Do you wish to edit your ${isByEmail ? 'Email' : 'Mobile Number'}?',
                    fontFamily: AssetConst.QUICKSAND_FONT,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight,
                    alignment: TextAlign.center,
                  )),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                GetBuilder<UserProfileController>(builder: (controller) {
                  return TextButton(
                      onPressed: () {
                        Get.to(() => EditEmailPhone(
                              isEmail: isByEmail,
                            ));
                        // Get.back();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: darkSkyBlueColor,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                      child: CustomText("Edit",
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700));
                }),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: redOpacityColor,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                    ),
                    child: CustomText("Cancel",
                        color: whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ],
            ));
    return Obx(
      () => SafeArea(
          child: Scaffold(
              body: Stack(children: [
        SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: blueGreyLight,
                    ),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            color: darkBlueGreyColor))),
                const SizedBox(width: 20),
                Text(
                  'Profile'.tr,
                  style: themeTextStyle(
                    context: context,
                    fsize: klargeFont(context),
                    fweight: FontWeight.bold,
                  ),
                )
              ],
            ),
            controller.loadUserData.value
                ? const Center(
                    child: SpinKitThreeBounce(
                      size: 25,
                      duration: Duration(milliseconds: 800),
                      color: Colors.grey,
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                          alignment: Alignment.center,
                          child: Column(children: [
                            SizedBox(
                              height: 110,
                              width: 110,
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                GetBuilder<ImagePickerController>(
                                    init: ImagePickerController(),
                                    builder: (bcontroller) {
                                      return bcontroller.imagePath == ""
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(55.0),
                                              child: controller.updatedUser!
                                                          .profileImage!
                                                          .contains(".jpg") ||
                                                      controller.updatedUser!
                                                          .profileImage!
                                                          .contains(".png")
                                                  ? Image.network(
                                                      controller.updatedUser!
                                                          .profileImage!,
                                                      errorBuilder: (context,
                                                          error, map) {
                                                        return Container(
                                                          height: 110,
                                                          width: 110,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          55)),
                                                        );
                                                      },
                                                      height: 110.0,
                                                      width: 110.0,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Container(
                                                      height: 110,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: const Icon(
                                                          Icons.person,
                                                          size: 60)),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(55.0),
                                              child: Image.file(
                                                File(bcontroller.imagePath),
                                                height: 110.0,
                                                width: 110.0,
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                    }),
                                if (controller.isUpdating.value)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              var imagePath =
                                                  await showImagePickerModal(
                                                      context);
                                              controller.updateDeviceImagePath(
                                                  imagePath);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Icon(Icons.edit),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            if (!controller.isUpdating.value)
                              Text(
                                "${controller.updatedUser!.firstName} ${controller.updatedUser!.lastName}"
                                // +'||' +controller.updatedUser!.odenId
                                ,
                                style: TextStyle(
                                  letterSpacing: 1.7,
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: AssetConst.QUICKSAND_FONT,
                                ),
                              )
                          ])),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.isUpdating.value)
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("firstName".tr,
                                                style: TextStyle(
                                                    letterSpacing: 0.9,
                                                    fontFamily: AssetConst
                                                        .QUICKSAND_FONT,
                                                    fontSize: 13,
                                                    color: Colors.grey[400],
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              child: TextFormField(
                                                readOnly:
                                                    controller.isUpdating.value
                                                        ? false
                                                        : true,
                                                initialValue:
                                                    controller.isUpdating.value
                                                        ? null
                                                        : controller
                                                            .updatedUser!
                                                            .firstName,
                                                controller:
                                                    controller.isUpdating.value
                                                        ? controller
                                                            .firstNameController
                                                        : null,
                                                scrollPadding: EdgeInsets.zero,
                                                style: TextStyle(
                                                  letterSpacing: 0.9,
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      AssetConst.QUICKSAND_FONT,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("lastName".tr,
                                                style: TextStyle(
                                                    letterSpacing: 0.9,
                                                    fontFamily:
                                                        AssetConst.RALEWAY_FONT,
                                                    fontSize: 13,
                                                    color: Colors.grey[400],
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              child: TextFormField(
                                                readOnly:
                                                    controller.isUpdating.value
                                                        ? false
                                                        : true,
                                                initialValue:
                                                    controller.isUpdating.value
                                                        ? null
                                                        : controller
                                                            .updatedUser!
                                                            .lastName,
                                                controller:
                                                    controller.isUpdating.value
                                                        ? controller
                                                            .lastNameController
                                                        : null,
                                                scrollPadding: EdgeInsets.zero,
                                                style: TextStyle(
                                                  letterSpacing: 0.9,
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      AssetConst.QUICKSAND_FONT,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 27),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flexible(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("emailAddress".tr,
                                              style: TextStyle(
                                                  letterSpacing: 0.9,
                                                  fontFamily:
                                                      AssetConst.QUICKSAND_FONT,
                                                  fontSize: 13,
                                                  color: Colors.grey[400],
                                                  fontWeight: FontWeight.w500)),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            child: TextFormField(
                                              initialValue:
                                                  controller.updatedUser!.email,
                                              readOnly: true,
                                              onTap: () {
                                                if (controller
                                                    .isUpdating.value) {
                                                  openDialog(true);
                                                }
                                              },
                                              scrollPadding: EdgeInsets.zero,
                                              decoration: controller
                                                      .isUpdating.value
                                                  ? const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 18))
                                                  : const InputDecoration(
                                                      border: InputBorder.none),
                                              style: TextStyle(
                                                letterSpacing: 0.9,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    AssetConst.QUICKSAND_FONT,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    !controller.isUpdating.value &&
                                            controller.user!.email!.isNotEmpty
                                        ? controller.user!.emailVerified ==
                                                'True'
                                            ? Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .green.shade600,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: const Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : controller.verificationInProgress ==
                                                    true
                                                ? const SpinKitThreeBounce(
                                                    size: 25,
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    color: Colors.grey,
                                                  )
                                                : TextButton(
                                                    onPressed: () async {
                                                      // api to send otp

                                                      String response =
                                                          await controller
                                                              .secondVerification(
                                                                  true,
                                                                  controller
                                                                      .user!
                                                                      .email!);
                                                      Get.to(() => (VerifyOtp(
                                                            isEmail: true,
                                                            isSecondVerification:
                                                                true,
                                                          )));
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    redOpacityColor),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          // side: BorderSide(color: Colors.red)
                                                        ))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Text("Verify",
                                                            style: TextStyle(
                                                                letterSpacing:
                                                                    0.9,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    AssetConst
                                                                        .RALEWAY_FONT)),
                                                      ],
                                                    ))
                                        : const SizedBox(),
                                  ],
                                ),
                                const SizedBox(height: 27),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flexible(
                                      flex: 8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("phoneNumber".tr,
                                              style: TextStyle(
                                                  letterSpacing: 0.9,
                                                  fontFamily:
                                                      AssetConst.QUICKSAND_FONT,
                                                  fontSize: 13,
                                                  color: Colors.grey[400],
                                                  fontWeight: FontWeight.w500)),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            child: TextFormField(
                                              readOnly: true,
                                              onTap: () {
                                                if (controller
                                                    .isUpdating.value) {
                                                  openDialog(false);
                                                }
                                              },
                                              initialValue:
                                                  controller.isUpdating.value
                                                      ? null
                                                      : controller
                                                          .updatedUser!.phone,
                                              // controller: controller
                                              //         .isUpdating.value
                                              //     ? controller
                                              //         .phoneController
                                              //     : null,
                                              decoration: controller
                                                      .isUpdating.value
                                                  ? const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 18))
                                                  : const InputDecoration(
                                                      border: InputBorder.none),
                                              scrollPadding: EdgeInsets.zero,
                                              style: TextStyle(
                                                letterSpacing: 0.9,
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    AssetConst.QUICKSAND_FONT,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    !controller.isUpdating.value &&
                                            controller.user!.phone!.isNotEmpty
                                        ? controller.user!.phoneVerified ==
                                                'True'
                                            ? Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(1),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .green
                                                                    .shade600,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                              )
                                            : TextButton(
                                                onPressed: () async {
                                                  // api to send otp

                                                  String response =
                                                      await controller
                                                          .secondVerification(
                                                              false,
                                                              controller.user!
                                                                  .phone!);
                                                  Get.to(() => (VerifyOtp(
                                                        isEmail: false,
                                                        isSecondVerification:
                                                            true,
                                                      )));
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                redOpacityColor),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      // side: BorderSide(color: Colors.red)
                                                    ))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text("Verify",
                                                        style: TextStyle(
                                                            letterSpacing: 0.9,
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontFamily: AssetConst
                                                                .RALEWAY_FONT)),
                                                  ],
                                                ))
                                        : const SizedBox(),
                                  ],
                                ),
                                const SizedBox(height: 27),
                                Text("gender".tr,
                                    style: TextStyle(
                                        letterSpacing: 0.9,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500)),
                                Container(
                                  decoration: BoxDecoration(
                                    border: controller.isUpdating.value
                                        ? Border(
                                            bottom: BorderSide(
                                            color: Colors.grey.shade500,
                                          ))
                                        : null,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  height: 30,
                                  child: controller.isUpdating.value
                                      ? DropdownButton(
                                          dropdownColor:
                                              context.theme.backgroundColor,
                                          value: controller.updatedUser!.gender,
                                          underline: Container(),
                                          icon: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 25),
                                              child: const Icon(
                                                  Icons.arrow_drop_down)),
                                          items: controller.genderOptions.map(
                                            (val) {
                                              return DropdownMenuItem(
                                                value: val,
                                                child: Text(
                                                  val,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: val ==
                                                              controller
                                                                  .updatedUser!
                                                                  .gender
                                                          ? mediumBlueGreyColor
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .color!,
                                                      fontFamily: AssetConst
                                                          .RALEWAY_FONT),
                                                  textScaleFactor: 1.0,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (value) {
                                            controller
                                                .updateGender(value.toString());
                                          },
                                        )
                                      : Text(
                                          controller.updatedUser!.gender!,
                                          style: TextStyle(
                                            letterSpacing: 0.9,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontWeight: FontWeight.w500,
                                            fontFamily:
                                                AssetConst.QUICKSAND_FONT,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 25),
                                Text("dob".tr,
                                    style: TextStyle(
                                        letterSpacing: 0.9,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500)),
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: TextFormField(
                                      onTap: () async {
                                        String date = await selectDate(context);
                                        print(date);
                                        controller.dobController.text = date;
                                      },
                                      keyboardType: TextInputType.none,
                                      readOnly: controller.isUpdating.value
                                          ? false
                                          : true,
                                      controller: controller.isUpdating.value
                                          ? controller.dobController
                                          : null,
                                      initialValue: controller.isUpdating.value
                                          ? null
                                          : controller.updatedUser!.dob,
                                      scrollPadding: EdgeInsets.zero,
                                      style: TextStyle(
                                        letterSpacing: 0.9,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                      decoration: controller.isUpdating.value
                                          ? const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 18))
                                          : const InputDecoration(
                                              border: InputBorder.none)),
                                ),
                                const SizedBox(height: 27),
                                Text("Country, State".tr,
                                    style: TextStyle(
                                        letterSpacing: 0.9,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500)),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 55,
                                  child: controller.isUpdating.value
                                      ? Container(
                                          alignment: Alignment.center,
                                          height: 55,
                                          child: CSCPicker(
                                              showStates: true,
                                              showCities: false,
                                              flagState: CountryFlag.DISABLE,
                                              dropdownDecoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1)),
                                              disabledDropdownDecoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1)),
                                              countrySearchPlaceholder:
                                                  "Search Country",
                                              stateSearchPlaceholder:
                                                  "Search State",
                                              countryDropdownLabel: "Country",
                                              stateDropdownLabel: "State",
                                              selectedItemStyle:
                                                  const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                              dropdownHeadingStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                              dropdownItemStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                              dropdownDialogRadius: 10.0,
                                              searchBarRadius: 10.0,
                                              currentCountry: controller.user?.country,
                                              currentState: controller.user?.state,
                                              onCountryChanged: (value) {
                                                String country = value;
                                                controller
                                                    .updateCountry(country);
                                              },

                                              ///triggers once state selected in dropdown
                                              onStateChanged: (value) {
                                                String state = value ?? "";
                                                controller.updateState(state);
                                              },

                                              ///triggers once city selected in dropdown
                                              onCityChanged: (value) {
                                                String cityValue = value ?? "";
                                              }),
                                        )
                                      : Text(
                                          controller.updatedUser!.state!
                                                  .isNotEmpty
                                              ? '${controller.updatedUser!.country!}, ${controller.updatedUser!.state!}'
                                              : controller
                                                  .updatedUser!.country!,
                                          style: TextStyle(
                                            letterSpacing: 0.9,
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontWeight: FontWeight.w500,
                                            fontFamily:
                                                AssetConst.QUICKSAND_FONT,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 27),
                                Text("Zip-code".tr,
                                    style: TextStyle(
                                        letterSpacing: 0.9,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500)),
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: TextFormField(
                                    readOnly: controller.isUpdating.value
                                        ? false
                                        : true,
                                    initialValue: controller.isUpdating.value
                                        ? null
                                        : controller.updatedUser!.zipCode,
                                    controller: controller.isUpdating.value
                                        ? controller.zipCodeController
                                        : null,
                                    decoration: controller.isUpdating.value
                                        ? const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(bottom: 18))
                                        : const InputDecoration(
                                            border: InputBorder.none),
                                    scrollPadding: EdgeInsets.zero,
                                    style: TextStyle(
                                      letterSpacing: 0.9,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AssetConst.QUICKSAND_FONT,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                TextButton(
                                    onPressed: () {
                                      if (controller.isUpdating.value) {
                                        controller.updateUserUsingController();
                                      } else {
                                        controller.updateIsUpdating(true);
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                redOpacityColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          // side: BorderSide(color: Colors.red)
                                        ))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            controller.isUpdating.value
                                                ? "update".tr
                                                : "EDIT",
                                            style: const TextStyle(
                                                letterSpacing: 0.9,
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontFamily:
                                                    AssetConst.RALEWAY_FONT)),
                                      ],
                                    ))
                              ])),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
          ],
        )),
        GetBuilder<UserProfileController>(builder: (userProfileController) {
          return Loader(
              isLoading: userProfileController.isProcess,
              text: "Updating profile ...");
        })
      ]))),
    );
  }
}
