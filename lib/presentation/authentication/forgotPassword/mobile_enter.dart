// import 'package:country_code_picker/country_code_picker.dart';
import 'package:datacoup/export.dart';
import 'package:country_picker/country_picker.dart';

class ByMobile extends StatelessWidget {
  ByMobile({Key? key}) : super(key: key);
  List<Map<String, String>> countryCodeList = [
    {'UAE': '+971'}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter Phone Number".tr,
            style: TextStyle(
                letterSpacing: 0.9,
                fontFamily: AssetConst.RALEWAY_FONT,
                fontSize: 15,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500)),
        GetBuilder<ForgotPasswordController>(builder: (controller) {
          return Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode:
                          true, // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        controller.updateCountryCode(country.phoneCode);
                      },
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(2, 25, 2, 10),
                      padding: EdgeInsets.fromLTRB(2, 0, 2, 14),
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      )),
                      child: Text(controller.countryCode,
                          style: TextStyle(
                              fontSize: 15,
                              color: darkBlueGreyColor,
                              fontFamily: AssetConst.QUICKSAND_FONT,
                              fontWeight: FontWeight.w500))),
                ),
                Container(
                  width: 255 * SizeConfig().widthScale,
                  // height:20,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    controller: controller.mobileController,
                    autofocus: false,
                    // maxLength: 10,
                    keyboardType: TextInputType.number,
                    scrollPadding: EdgeInsets.zero,
                    style: TextStyle(
                      letterSpacing: 0.9,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                      fontFamily: AssetConst.RALEWAY_FONT,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: 5 * SizeConfig().heightScale),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
