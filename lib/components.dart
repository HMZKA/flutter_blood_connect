import 'package:flutter/material.dart';
import 'package:flutter_blood_connect/constants.dart';
import 'package:flutter_blood_connect/request_blood_dialog.dart';
import 'package:flutter_blood_connect/text_field.dart';

PreferredSizeWidget myAppBar({List<Widget>? actions, Widget? leading}) {
  return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      leading: leading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/project_icon.png",
            width: 100,
            height: 80,
            fit: BoxFit.fitHeight,
          ),
          const Text(
            "Blood Connect",
            style: TextStyle(
                fontFamily: "GreatVibes",
                fontSize: 25,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
      actions: actions);
}

Widget myButton(
    {required BuildContext context,
    required Widget child,
    required void Function()? onPressed}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
        child:
            SizedBox(width: getScreenSize(context).width / 3.5, child: child)),
  );
}

Widget dropDownButtonForm(
    {required List<DropdownMenuItem> items,
    required void Function(dynamic)? onChanged,
    required String? Function(dynamic)? validator,
    Widget? hint}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      elevation: 0,
      isExpanded: true,
      hint: hint,
      validator: validator,
      borderRadius: BorderRadius.circular(15),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    ),
  );
}

requestBloodDialog(context) {
  showDialog(context: context, builder: (context) => RequestBloodDialog());
}

Widget buildProfileItem({required Widget icon, required String text}) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: icon,
            ),
            Text(text)
          ],
        ),
      ),
    ),
  );
}

Size getScreenSize(context) {
  return MediaQuery.of(context).size;
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

pushNavigation(context, widget) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => widget,
  ));
}

pushAndRemoveUntil(context, screen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);
}
