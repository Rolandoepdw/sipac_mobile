import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    primarySwatch: primarySwatch,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    //AppBar
    appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true),
    //TabBar
    tabBarTheme: TabBarTheme(
        dividerColor: primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white),
    //ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            // fixedSize: MaterialStateProperty.all(const Size(110, 40)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(primaryColor))),
    //FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white, foregroundColor: primaryColor),
    //IconButton
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white))),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(mediumRadius),
    )),
  listTileTheme: ListTileThemeData(iconColor: primaryColor),
  iconTheme: const IconThemeData(color: Colors.amber),
  buttonTheme: const ButtonThemeData(buttonColor: Colors.red)
);
