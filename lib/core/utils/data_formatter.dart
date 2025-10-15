import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class DataFormatter{
  static String formatDate(String dateString){
    //2022-01-21T05:00:00Z
    if(dateString.isEmpty) {
      return dateString;
    }else{
    final DateTime now = DateTime.parse(dateString);
    final String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
    return formattedDate;

    }
  }


  /// ==> 'January, 2012'
  static String formatDateToTextMonthYear(String date) {
    if (date.isEmpty) {
      return date;
    }
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat.yMMMM().format(parsedDate);
  }

    /// ==> 'January 10, 2012'
  static String formatDateToStringDateOnly(String date) {
    if (date.isEmpty) {
      return date;
    }
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat.yMMMMd().format(parsedDate);
  }

    /// ==> 'Wednesday, January 10, 2012'
  static String formatDateToString(String date){
    if(date == '') {
      return date;
    }
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat.yMMMMEEEEd().add_jm().format(parsedDate);
  }

  static String formatDateAndTimeToString(String dateString){
    final DateTime now = DateTime.parse(dateString);
    final String formattedDateToString = DateFormat('EE MMMM dd, yyyy HH:mm').format(now);
    return formattedDateToString;
  }

  static String formatDateAndTimeToStringDigit(String dateString){
    if(dateString.isEmpty){
      return dateString;
    }
    final DateTime now = DateTime.parse(dateString);
    final String formattedDateToString = DateFormat('dd-MM-yyyy HH:mm').format(now);
    return formattedDateToString;
  }

 static String formatDateOnly(DateTime date) {
    final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
    return dateFormatter.format(date);
  }


  static String formatDigitGrouping(double num){
    final List<String> value = <String>[];
    final NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    final String number = num.toStringAsFixed(2);
    final String wholeNumber = number.split('.')[0];
    final String decimalNumber = number.split('.')[1];
    final double formattedNumber = double.parse(wholeNumber);
    final String numberInString =  myFormat.format(formattedNumber);
    value.add(numberInString);
    value.add(decimalNumber);
    final String digit = value.join('.');
    return digit;
  }

  /// A number format for compact currency representations, e.g. "GH¢1.2M" instead of "GH¢1,200,000".
  static NumberFormat getLocalCompactCurrencyFormatter(BuildContext context){
    return NumberFormat.compactCurrency(
      symbol: 'GH¢',
    );
  }

  static NumberFormat getLocalCurrencyFormatter(BuildContext context, {bool includeSymbol = true}){
    final NumberFormat formatter = NumberFormat.currency(
        locale: Localizations.localeOf(context).toString(),name:'Ghana Cedis',
        symbol: includeSymbol ? 'GH¢ ' : '',decimalDigits: 2);
    return formatter;
  }
  static NumberFormat getCurrencyFormatter(BuildContext context){
    final NumberFormat formatter = NumberFormat.currency(
        locale: Localizations.localeOf(context).toString(),name:'Ghana Cedis',
        symbol: '',decimalDigits: 2);
    return formatter;
  }
}