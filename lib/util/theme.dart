import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4486f6);
  static const Color processingColor = Color.fromARGB(255, 30, 135, 205);
  static const Color primaryColorLigt = Color(0xFF4470c2);
  static const Color dangerColor = Color(0xFFc5000f);
  static const Color appBarBackgroundColor = Colors.white;
  static const Color backgroundColor = Color(0xFFf9fafb);
  static const Color successColor = Color(0xFF068047);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color secondaryColor = Color(0xFFEDEEF0);
  static const Color defaultColor = Color(0xFF5F5F5F);
  static const Color secondaryColorRgb = Color(0xFF0163AA);

  static BorderRadiusGeometry borderRadius = BorderRadius.circular(4);
  static const TextStyle style = TextStyle(
    fontSize: 24.0,
    fontFamilyFallback: ['Gilroy', 'Kantumruy'],
  );
static const double iconExtraLarge = 56;


static const double iconLarge = 48;
  static const double iconMedium = 32;
  static const double iconSmall = 16;
  static const Color   memberClassColor = Color(0xFF3b82f6)  ;
   

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: primaryColor,

      hintColor: Colors.amber,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),

      // Text theme
        textTheme: TextTheme(

        displayLarge: style.copyWith(fontSize: 48.0),
        displayMedium: style.copyWith(fontSize: 32.0),
        displaySmall: style.copyWith(fontSize: 24.0),

        titleLarge: style.copyWith(
          fontSize: 56.0,
          color: Colors.black),
        titleMedium: style.copyWith(
          fontSize: 36.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: style.copyWith(
          fontSize: 32.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
  
        bodyLarge: style.copyWith(
          fontSize: 24.0,
          color: Colors.black,
        ),
        bodyMedium: style.copyWith(
          fontSize: 18.0,
          color: Colors.black,
        ),
        bodySmall: style.copyWith(
          fontSize: 14.0,
          color: Colors.black,
        ),
      ),

      // Button theme
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 84,
        elevation: 1,
        iconTheme: const IconThemeData(color: primaryColor),
        centerTitle: true,
        titleTextStyle: style.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        counterStyle: style.copyWith(
          fontSize: 12.0,
          color: Colors.black,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: primaryColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: style.copyWith(color: Colors.red, fontSize: 12),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: style.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        suffixIconColor: Colors.black54,
      ),

      // ElevatedButton style
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: style,
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
        cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontFamilyFallback: ['Gilroy', 'Kantumruy'],
            ),
          ),
        ),
        confirmButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontFamilyFallback: ['Gilroy', 'Kantumruy'],
            ),
          ),
        ),
        timeSelectorSeparatorTextStyle: WidgetStateProperty.all(
          style.copyWith(
            fontSize: 50,
            color: Colors.black,
          ),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        headerHeadlineStyle: style,
        headerHelpStyle: style,
        dayStyle: style,
        weekdayStyle: style,
        yearStyle: style,
        rangePickerHeaderHeadlineStyle: style,
        rangePickerHeaderHelpStyle: style,
        confirmButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontFamilyFallback: ['Gilroy', 'Kantumruy'],
            ),
          ),
        ),
        cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontFamilyFallback: ['Gilroy', 'Kantumruy'],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: style.copyWith(fontSize: 14.0),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.black,
        leadingAndTrailingTextStyle: style,
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Colors.white,
        labelStyle: style,
        side: BorderSide(color: Colors.transparent),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        titleTextStyle: style,
        contentTextStyle: style,
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
      ),
    );
  }
}
