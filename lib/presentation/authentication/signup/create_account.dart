import 'dart:io';
import 'package:datacoup/export.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({Key? key}) : super(key: key);
  final _imagePickerController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        SingleChildScrollView(
            child: GetBuilder<SignUpController>(builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 10 * SizeConfig().heightScale),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 5),
                      margin: const EdgeInsets.only(left: 15),
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: blueGreyLight,
                      ),
                      child: InkWell(
                          onTap: () {
                            Get.delete<LoginController>();
                            Get.offAll(() => Login());
                          },
                          child: const Icon(Icons.arrow_back_ios))),
                ],
              ),
              SizedBox(height: 10 * SizeConfig().heightScale),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  StringConst.CREATE_ACCOUNT,
                  style: TextStyle(
                    letterSpacing: 0.9,
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    fontFamily: AssetConst.RALEWAY_FONT,
                  ),
                ),
              ),
              SizedBox(height: 30 * SizeConfig().heightScale),
              Container(
                  alignment: Alignment.center,
                  child: Column(children: [
                    GetBuilder<ImagePickerController>(
                        builder: (imageController) {
                      return imageController.imagePath == ""
                          ? Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(55)))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(55.0),
                              child: Image.file(
                                File(imageController.imagePath),
                                height: 110.0,
                                width: 110.0,
                                fit: BoxFit.fill,
                              ),
                            );
                    }),
                    TextButton(
                        onPressed: () async {
                          var imagePath = await showImagePickerModal(context);
                          controller.updateDeviceImagePath(imagePath);
                        },
                        child: const Text("Select Profile Photo",
                            style: TextStyle(
                              color: deepOrangeColor,
                              fontWeight: FontWeight.w500,
                            )))
                  ])),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(StringConst.FIRST_NAME,
                                      style: TextStyle(
                                          letterSpacing: 0.9,
                                          fontFamily: AssetConst.RALEWAY_FONT,
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: controller.firstNameController,
                                      scrollPadding: EdgeInsets.zero,
                                      style: TextStyle(
                                        letterSpacing: 0.9,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 18),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(StringConst.LAST_NAME,
                                      style: TextStyle(
                                          letterSpacing: 0.9,
                                          fontFamily: AssetConst.RALEWAY_FONT,
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: controller.lastNameController,
                                      scrollPadding: EdgeInsets.zero,
                                      style: TextStyle(
                                        letterSpacing: 0.9,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 27),
                        Text(StringConst.EMAIL_ADDRESS,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: TextFormField(
                            controller: controller.emailController,
                            // initialValue: _controller.isByEmail?_controller.user.email:'',
                            readOnly: controller.isByEmail ? true : false,
                            scrollPadding: EdgeInsets.zero,
                            style: TextStyle(
                              letterSpacing: 0.9,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        Text(StringConst.PHONE_NUMBER,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: TextFormField(
                            controller: controller.phoneController,
                            // initialValue: !_controller.isByEmail?_controller.user.mobile:'',
                            readOnly: !controller.isByEmail ? true : false,
                            scrollPadding: EdgeInsets.zero,
                            style: TextStyle(
                              letterSpacing: 0.9,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(StringConst.GENDER,
                                      style: TextStyle(
                                          letterSpacing: 0.9,
                                          fontFamily: AssetConst.RALEWAY_FONT,
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                          color: Colors.grey.shade500,
                                        )),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      height: 30,
                                      child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        value: controller.user.gender,
                                        underline: Container(),
                                        icon: Container(
                                            padding:
                                                const EdgeInsets.only(left: 25),
                                            child: const Icon(
                                                Icons.arrow_drop_down)),
                                        items: controller.genderOptions.map(
                                          (val) {
                                            return DropdownMenuItem(
                                              value: val,
                                              child: Text(
                                                val,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: val ==
                                                            controller
                                                                .user.gender
                                                        ? Colors.grey.shade700
                                                        : Colors.grey.shade300,
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
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(StringConst.DOB,
                                      style: TextStyle(
                                          letterSpacing: 0.9,
                                          fontFamily: AssetConst.RALEWAY_FONT,
                                          fontSize: 14,
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
                                      controller: controller.dobController,
                                      scrollPadding: EdgeInsets.zero,
                                      style: TextStyle(
                                        letterSpacing: 0.9,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AssetConst.QUICKSAND_FONT,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 27),
                        Text(StringConst.LOCATION,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                        Container(
                          alignment: Alignment.center,
                          height: 52,
                          child: CSCPicker(
                              showStates: true,
                              showCities: false,
                              flagState: CountryFlag.DISABLE,
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1)),
                              disabledDropdownDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1)),
                              countrySearchPlaceholder: "Search Country",
                              stateSearchPlaceholder: "Search State",
                              countryDropdownLabel: "Country",
                              stateDropdownLabel: "State",

                              // defaultCountry: DefaultCountry.India,
                              ///Disable country dropdown (Note: use it with default country)
                              //disableCountry: true,
                              selectedItemStyle: const TextStyle(
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
                              currentCountry: controller.country,
                              currentState: controller.state,
                              onCountryChanged: (value) {
                                String country = value;
                                controller.updateCountry(country);
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
                        ),
                        const SizedBox(height: 10),
                        Text(StringConst.zipCode,
                            style: TextStyle(
                                letterSpacing: 0.9,
                                fontFamily: AssetConst.RALEWAY_FONT,
                                fontSize: 15,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            controller: controller.zipCodeController,
                            // initialValue: !_controller.isByEmail?_controller.user.mobile:'',
                            scrollPadding: EdgeInsets.zero,
                            style: TextStyle(
                              letterSpacing: 0.9,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                            onPressed: () async {
                              if (controller.firstNameController.text.isEmpty || controller.lastNameController.text.isEmpty){
                                showSnackBar(context, msg: "Enter your first and last name");
                              }

                              if(controller.firstNameController.text.isNotEmpty && controller.lastNameController.text.isNotEmpty){
                                bool value =
                                    await controller.updateUserUsingController();
                                if (value) {
                                  // Get.delete<LoginController>();
                                  Get.offAll(() => Login());
                                }
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        deepOrangeColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(StringConst.CONTINUE,
                                    style: TextStyle(
                                        letterSpacing: 0.9,
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: AssetConst.RALEWAY_FONT)),
                              ],
                            )),
                      ])),
              SizedBox(height: 15 * SizeConfig().heightScale),
              Container(
                  alignment: Alignment.center,
                  width: 320,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: [
                      const Text("By clicking \"CONTINUE\" you agree to our ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: AssetConst.RALEWAY_FONT,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w500,
                          )),
                      InkWell(
                        onTap: () {
                          Get.to(() => (WebViewWidget(
                                url: TERMS_URL,
                                showFav: false,
                                showAppbar: true,
                                title: StringConst.TERMS_AND_CONDITION,
                              )));
                        },
                        highlightColor: lightGreyColor,
                        child: Text(StringConst.TERMS_AND_CONDITION,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: darkGreyColor,
                              fontFamily: AssetConst.RALEWAY_FONT,
                              letterSpacing: 0.9,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const Text(" as well as our ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: AssetConst.RALEWAY_FONT,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w500,
                          )),
                      InkWell(
                        onTap: () {
                          Get.to(() => (WebViewWidget(
                                url: PRIVACY_URL,
                                title: StringConst.PRIVACY_POLICY,
                              )));
                        },
                        highlightColor: lightGreyColor,
                        child: Text(StringConst.PRIVACY_POLICY,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: darkGreyColor,
                              fontFamily: AssetConst.RALEWAY_FONT,
                              letterSpacing: 0.9,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ],
                  )),
              SizedBox(height: 20 * SizeConfig().heightScale),
            ],
          );
        })),
        GetBuilder<SignUpController>(builder: (controller) {
          return Loader(
            isLoading: controller.isUpdating,
            text: 'Creating Profile ....',
          );
        })
      ]),
    ));
  }
}

// class Spinner extends StatefulWidget {
//   const Spinner({ Key? key }) : super(key: key);

//   @override
//   State<Spinner> createState() => _SpinnerState();
// }

// class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
//     late final AnimationController _controller = AnimationController(
//     duration: const Duration(seconds: 2),
//     vsync: this,
//   )..repeat(reverse: false);

//   // Create an animation with value of type "double"
//   late final Animation<double> _animation = CurvedAnimation(
//     parent: _controller,
//     curve: Curves.linear,
//   );

//     @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Center (
//         child: RotationTransition(
//           turns: _animation,
//           child: ,
//         ),
        
//     );
//   }
// }