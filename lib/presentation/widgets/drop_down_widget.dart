import '../../export.dart';

class DropDownWidget extends StatefulWidget {
  final List? dropMenuList;
  final String? labelText;
  final Function? selectedReturnValue;
  final String? hintText;

  const DropDownWidget({
    Key? key,
    required this.dropMenuList,
    required this.labelText,
    this.hintText = "",
    required this.selectedReturnValue,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  List? notify;

  String? selectedMenuItem;

  @override
  void initState() {
    notify = widget.dropMenuList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        hintStyle: themeTextStyle(context: context),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
      ),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          child: DropdownButton(
            iconSize: 25,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
            ),
            iconEnabledColor: Theme.of(context).primaryColor,
            iconDisabledColor: Theme.of(context).primaryColor,
            isExpanded: true,
            style: themeTextStyle(context: context),
            hint: Text(
              widget.hintText!,
              style: themeTextStyle(context: context),
            ),
            items: notify!.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() => selectedMenuItem = newValue.toString());
              widget.selectedReturnValue!(selectedMenuItem);
            },
            value: selectedMenuItem,
          ),
        ),
      ),
    );
  }
}
