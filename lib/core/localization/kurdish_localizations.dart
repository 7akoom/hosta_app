import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class KurdishMaterialLocalizations extends DefaultMaterialLocalizations {
  const KurdishMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _KurdishMaterialLocalizationsDelegate();

  @override
  String get searchFieldLabel => 'گەڕان';

  @override
  String get closeButtonLabel => 'داخستن';

  @override
  String get cancelButtonLabel => 'هەڵوەشاندنەوە';

  @override
  String get okButtonLabel => 'باشە';

  @override
  String get backButtonTooltip => 'گەڕانەوە';

  @override
  String get nextMonthTooltip => 'مانگی داهاتوو';

  @override
  String get previousMonthTooltip => 'مانگی پێشوو';

  @override
  String get nextPageTooltip => 'لاپەڕەی داهاتوو';

  @override
  String get previousPageTooltip => 'لاپەڕەی پێشوو';

  @override
  String get showMenuTooltip => 'پیشاندانی مێنیو';

  @override
  String get selectAllButtonLabel => 'هەڵبژاردنی هەموو';

  @override
  String get modalBarrierDismissLabel => 'داخستن';

  @override
  String get alertDialogLabel => 'ئاگادارکردنەوە';

  @override
  String get copyButtonLabel => 'کۆپی';

  @override
  String get cutButtonLabel => 'بڕین';

  @override
  String get pasteButtonLabel => 'لکاندن';

  @override
  String get saveButtonLabel => 'پاشەکەوتکردن';

  @override
  String get viewLicensesButtonLabel => 'بینینی مۆڵەتەکان';

  @override
  String get anteMeridiemAbbreviation => 'پ.ن';

  @override
  String get postMeridiemAbbreviation => 'د.ن';

  @override
  String get timePickerHourModeAnnouncement => 'کاتژمێر هەڵبژێرە';

  @override
  String get timePickerMinuteModeAnnouncement => 'خولەک هەڵبژێرە';

  @override
  String get deleteButtonTooltip => 'سڕینەوە';

  @override
  String get dialModeButtonLabel => 'گۆڕین بۆ دۆخی هەڵبژێری کاتژمێر';

  @override
  String get inputTimeModeButtonLabel => 'گۆڕین بۆ دۆخی نووسینی دەق';

  @override
  String get reorderItemDown => 'بڕۆ خوارەوە';

  @override
  String get reorderItemLeft => 'بڕۆ چەپ';

  @override
  String get reorderItemRight => 'بڕۆ ڕاست';

  @override
  String get reorderItemUp => 'بڕۆ سەرەوە';

  @override
  String get reorderItemToEnd => 'بڕۆ کۆتایی';

  @override
  String get reorderItemToStart => 'بڕۆ سەرەتا';

  @override
  String tabLabel({required int tabIndex, required int tabCount}) =>
      'تابی \$tabIndex لە \$tabCount';
}

class _KurdishMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _KurdishMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return SynchronousFuture<MaterialLocalizations>(
      const KurdishMaterialLocalizations(),
    );
  }

  @override
  bool shouldReload(_KurdishMaterialLocalizationsDelegate old) => false;
}

class KurdishCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const KurdishCupertinoLocalizations();

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _KurdishCupertinoLocalizationsDelegate();

  @override
  String get alertDialogLabel => 'ئاگادارکردنەوە';

  @override
  String get modalBarrierDismissLabel => 'داخستن';

  @override
  String get searchTextFieldPlaceholderLabel => 'گەڕان';

  @override
  String get todayLabel => 'ئەمڕۆ';

  @override
  String get copyButtonLabel => 'کۆپی';

  @override
  String get cutButtonLabel => 'بڕین';

  @override
  String get pasteButtonLabel => 'لکاندن';

  @override
  String get selectAllButtonLabel => 'هەڵبژاردنی هەموو';

  @override
  String get anteMeridiemAbbreviation => 'پ.ن';

  @override
  String get postMeridiemAbbreviation => 'د.ن';
}

class _KurdishCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _KurdishCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(
      const KurdishCupertinoLocalizations(),
    );
  }

  @override
  bool shouldReload(_KurdishCupertinoLocalizationsDelegate old) => false;
}
