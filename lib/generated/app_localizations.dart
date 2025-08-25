import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ku.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('ku'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Hosta Services'**
  String get app_name;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @kurdish.
  ///
  /// In en, this message translates to:
  /// **'Kurdish'**
  String get kurdish;

  /// No description provided for @continue_as_guest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continue_as_guest;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @book_now.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get book_now;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @please_wait.
  ///
  /// In en, this message translates to:
  /// **'Please Wait'**
  String get please_wait;

  /// No description provided for @error_occurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get error_occurred;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @no_internet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get no_internet;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get no_data;

  /// No description provided for @press_back_again.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get press_back_again;

  /// No description provided for @loading_categories.
  ///
  /// In en, this message translates to:
  /// **'Loading categories...'**
  String get loading_categories;

  /// No description provided for @no_categories_available.
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get no_categories_available;

  /// No description provided for @services_count.
  ///
  /// In en, this message translates to:
  /// **'services'**
  String get services_count;

  /// No description provided for @search_service.
  ///
  /// In en, this message translates to:
  /// **'Search a service...'**
  String get search_service;

  /// No description provided for @my_services.
  ///
  /// In en, this message translates to:
  /// **'My Services'**
  String get my_services;

  /// No description provided for @signup_intro_text.
  ///
  /// In en, this message translates to:
  /// **'Sign up with your email or phone number'**
  String get signup_intro_text;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @verification_code.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verification_code;

  /// No description provided for @send_code.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get send_code;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personal_info;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @language_settings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get language_settings;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode;

  /// No description provided for @system_default.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get system_default;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_of_service;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @rate_app.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rate_app;

  /// No description provided for @share_app.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get share_app;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thank You!'**
  String get thank_you;

  /// No description provided for @your_feedback_helps_us_improve.
  ///
  /// In en, this message translates to:
  /// **'Your feedback helps us improve our services.'**
  String get your_feedback_helps_us_improve;

  /// No description provided for @profile_page_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_page_title;

  /// No description provided for @favorites_page_title.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites_page_title;

  /// No description provided for @search_page_title.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_page_title;

  /// No description provided for @settings_page_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_page_title;

  /// No description provided for @account_page_title.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_page_title;

  /// No description provided for @notifications_page_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_page_title;

  /// No description provided for @chats_page_title.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats_page_title;

  /// No description provided for @my_services_page_title.
  ///
  /// In en, this message translates to:
  /// **'My Services'**
  String get my_services_page_title;

  /// No description provided for @help_support_page_title.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help_support_page_title;

  /// No description provided for @book_service_page_title.
  ///
  /// In en, this message translates to:
  /// **'Book Service'**
  String get book_service_page_title;

  /// No description provided for @schedule_page_title.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule_page_title;

  /// No description provided for @confirm_payment_page_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirm_payment_page_title;

  /// No description provided for @cancel_booking_page_title.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancel_booking_page_title;

  /// No description provided for @provider_details_page_title.
  ///
  /// In en, this message translates to:
  /// **'Provider Details'**
  String get provider_details_page_title;

  /// No description provided for @service_details_page_title.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get service_details_page_title;

  /// No description provided for @category_details_page_title.
  ///
  /// In en, this message translates to:
  /// **'Category Details'**
  String get category_details_page_title;

  /// No description provided for @provider_feedback_page_title.
  ///
  /// In en, this message translates to:
  /// **'Provider Feedback'**
  String get provider_feedback_page_title;

  /// No description provided for @provider_reviews_page_title.
  ///
  /// In en, this message translates to:
  /// **'Provider Reviews'**
  String get provider_reviews_page_title;

  /// No description provided for @information_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Information updated successfully'**
  String get information_updated_successfully;

  /// No description provided for @update_email.
  ///
  /// In en, this message translates to:
  /// **'Update Email'**
  String get update_email;

  /// No description provided for @new_email.
  ///
  /// In en, this message translates to:
  /// **'New Email'**
  String get new_email;

  /// No description provided for @enter_your_new_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your new email'**
  String get enter_your_new_email;

  /// No description provided for @update_phone.
  ///
  /// In en, this message translates to:
  /// **'Update Phone'**
  String get update_phone;

  /// No description provided for @new_phone.
  ///
  /// In en, this message translates to:
  /// **'New Phone'**
  String get new_phone;

  /// No description provided for @enter_your_new_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter your new phone'**
  String get enter_your_new_phone;

  /// No description provided for @update_password.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @enter_your_current_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get enter_your_current_password;

  /// No description provided for @please_enter_your_current_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password'**
  String get please_enter_your_current_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @enter_a_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password'**
  String get enter_a_new_password;

  /// No description provided for @please_enter_a_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get please_enter_a_new_password;

  /// No description provided for @password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get password_min_length;

  /// No description provided for @confirm_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm your new password'**
  String get confirm_your_new_password;

  /// No description provided for @please_confirm_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your new password'**
  String get please_confirm_your_new_password;

  /// No description provided for @passwords_dont_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwords_dont_match;

  /// No description provided for @please_sign_in_to_view_account.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view your account'**
  String get please_sign_in_to_view_account;

  /// No description provided for @account_information.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get account_information;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @once_you_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Once you delete your account, there is no going back. Please be certain.'**
  String get once_you_delete_account;

  /// No description provided for @are_you_sure_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get are_you_sure_delete_account;

  /// No description provided for @choose_email_or_phone_to_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Choose email or phone to reset your password'**
  String get choose_email_or_phone_to_reset_password;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_your_email;

  /// No description provided for @enter_your_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone'**
  String get enter_your_phone;

  /// No description provided for @back_to_signin.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get back_to_signin;

  /// No description provided for @password_changed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get password_changed_successfully;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enter_new_password;

  /// No description provided for @enter_password_please.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get enter_password_please;

  /// No description provided for @password_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Password Confirmation'**
  String get password_confirmation;

  /// No description provided for @location_permission.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get location_permission;

  /// No description provided for @location_permission_message.
  ///
  /// In en, this message translates to:
  /// **'We need your location to show you nearby services'**
  String get location_permission_message;

  /// No description provided for @deny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get deny;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @location_error.
  ///
  /// In en, this message translates to:
  /// **'Location Error'**
  String get location_error;

  /// No description provided for @location_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get location_permission_denied;

  /// No description provided for @select_city.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get select_city;

  /// No description provided for @required_field.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get required_field;

  /// No description provided for @mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobile_number;

  /// No description provided for @iraq.
  ///
  /// In en, this message translates to:
  /// **'Iraq'**
  String get iraq;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enter_password;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get date_of_birth;

  /// No description provided for @agreement_text.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get agreement_text;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @verification_code_sent_phone.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your phone'**
  String get verification_code_sent_phone;

  /// No description provided for @verification_code_sent_email.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your email'**
  String get verification_code_sent_email;

  /// No description provided for @enter_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enter_verification_code;

  /// No description provided for @take_a_photo.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get take_a_photo;

  /// No description provided for @choose_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get choose_from_gallery;

  /// No description provided for @describe_your_issue.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue'**
  String get describe_your_issue;

  /// No description provided for @type_your_issue_here.
  ///
  /// In en, this message translates to:
  /// **'Type your issue here'**
  String get type_your_issue_here;

  /// No description provided for @add_attachment.
  ///
  /// In en, this message translates to:
  /// **'Add Attachment'**
  String get add_attachment;

  /// No description provided for @booking_cancelled_successfully.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled successfully'**
  String get booking_cancelled_successfully;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @provider_not_available.
  ///
  /// In en, this message translates to:
  /// **'Provider not available'**
  String get provider_not_available;

  /// No description provided for @change_of_plans.
  ///
  /// In en, this message translates to:
  /// **'Change of plans'**
  String get change_of_plans;

  /// No description provided for @found_another_provider.
  ///
  /// In en, this message translates to:
  /// **'Found another provider'**
  String get found_another_provider;

  /// No description provided for @price_too_high.
  ///
  /// In en, this message translates to:
  /// **'Price too high'**
  String get price_too_high;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @please_pick_reason_for_cancellation.
  ///
  /// In en, this message translates to:
  /// **'Please pick a reason for cancellation'**
  String get please_pick_reason_for_cancellation;

  /// No description provided for @select_a_reason.
  ///
  /// In en, this message translates to:
  /// **'Select a reason'**
  String get select_a_reason;

  /// No description provided for @please_specify_your_reason.
  ///
  /// In en, this message translates to:
  /// **'Please specify your reason'**
  String get please_specify_your_reason;

  /// No description provided for @loading_services.
  ///
  /// In en, this message translates to:
  /// **'Loading services...'**
  String get loading_services;

  /// No description provided for @no_services_available.
  ///
  /// In en, this message translates to:
  /// **'No services available'**
  String get no_services_available;

  /// No description provided for @services_available.
  ///
  /// In en, this message translates to:
  /// **'services available'**
  String get services_available;

  /// No description provided for @available_services.
  ///
  /// In en, this message translates to:
  /// **'Available Services'**
  String get available_services;

  /// No description provided for @loading_chat.
  ///
  /// In en, this message translates to:
  /// **'Loading chat...'**
  String get loading_chat;

  /// No description provided for @no_chat_available.
  ///
  /// In en, this message translates to:
  /// **'No chat available'**
  String get no_chat_available;

  /// No description provided for @service_provider.
  ///
  /// In en, this message translates to:
  /// **'Service Provider'**
  String get service_provider;

  /// No description provided for @start_conversation_now.
  ///
  /// In en, this message translates to:
  /// **'Start conversation now'**
  String get start_conversation_now;

  /// No description provided for @type_your_message_here.
  ///
  /// In en, this message translates to:
  /// **'Type your message here'**
  String get type_your_message_here;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get now;

  /// No description provided for @please_enter_a_valid_amount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get please_enter_a_valid_amount;

  /// No description provided for @payment_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment Confirmed'**
  String get payment_confirmed;

  /// No description provided for @thank_you_for_confirming_payment.
  ///
  /// In en, this message translates to:
  /// **'Thank you for confirming your payment'**
  String get thank_you_for_confirming_payment;

  /// No description provided for @confirm_payment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirm_payment;

  /// No description provided for @payment_amount.
  ///
  /// In en, this message translates to:
  /// **'Payment Amount'**
  String get payment_amount;

  /// No description provided for @payment_details.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get payment_details;

  /// No description provided for @booking_id.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get booking_id;

  /// No description provided for @provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider;

  /// No description provided for @confirm_payment_button.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirm_payment_button;

  /// No description provided for @remove_from_favorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get remove_from_favorites;

  /// No description provided for @no_favorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get no_favorites;

  /// No description provided for @browse_providers.
  ///
  /// In en, this message translates to:
  /// **'Browse providers'**
  String get browse_providers;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get in_progress;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @service_id.
  ///
  /// In en, this message translates to:
  /// **'Service ID'**
  String get service_id;

  /// No description provided for @date_time.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get date_time;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @mark_all_as_read.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get mark_all_as_read;

  /// No description provided for @no_notifications_yet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get no_notifications_yet;

  /// No description provided for @manage_account_information.
  ///
  /// In en, this message translates to:
  /// **'Manage account information'**
  String get manage_account_information;

  /// No description provided for @language_and_theme_preferences.
  ///
  /// In en, this message translates to:
  /// **'Language and theme preferences'**
  String get language_and_theme_preferences;

  /// No description provided for @help_and_support.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get help_and_support;

  /// No description provided for @contact_us_for_assistance.
  ///
  /// In en, this message translates to:
  /// **'Contact us for assistance'**
  String get contact_us_for_assistance;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @are_you_sure_sign_out.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get are_you_sure_sign_out;

  /// No description provided for @sign_out_of_your_account.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get sign_out_of_your_account;

  /// No description provided for @error_loading_provider_data.
  ///
  /// In en, this message translates to:
  /// **'Error loading provider data'**
  String get error_loading_provider_data;

  /// No description provided for @sign_in_required.
  ///
  /// In en, this message translates to:
  /// **'Sign in required'**
  String get sign_in_required;

  /// No description provided for @please_sign_in_to_chat.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to chat'**
  String get please_sign_in_to_chat;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @great_service.
  ///
  /// In en, this message translates to:
  /// **'Great service!'**
  String get great_service;

  /// No description provided for @excellent_work_quality.
  ///
  /// In en, this message translates to:
  /// **'Excellent work quality'**
  String get excellent_work_quality;

  /// No description provided for @other_providers.
  ///
  /// In en, this message translates to:
  /// **'Other Providers'**
  String get other_providers;

  /// No description provided for @rating_poor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get rating_poor;

  /// No description provided for @rating_fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get rating_fair;

  /// No description provided for @rating_average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get rating_average;

  /// No description provided for @rating_good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get rating_good;

  /// No description provided for @rating_excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get rating_excellent;

  /// No description provided for @please_select_a_rating.
  ///
  /// In en, this message translates to:
  /// **'Please select a rating'**
  String get please_select_a_rating;

  /// No description provided for @how_would_you_rate_experience.
  ///
  /// In en, this message translates to:
  /// **'How would you rate your experience?'**
  String get how_would_you_rate_experience;

  /// No description provided for @additional_comments_optional.
  ///
  /// In en, this message translates to:
  /// **'Additional comments (optional)'**
  String get additional_comments_optional;

  /// No description provided for @share_your_experience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience'**
  String get share_your_experience;

  /// No description provided for @your_feedback_helps_improve.
  ///
  /// In en, this message translates to:
  /// **'Your feedback helps improve our services'**
  String get your_feedback_helps_improve;

  /// No description provided for @thank_you_for_choosing_hosta.
  ///
  /// In en, this message translates to:
  /// **'Thank you for choosing Hosta'**
  String get thank_you_for_choosing_hosta;

  /// No description provided for @available_times.
  ///
  /// In en, this message translates to:
  /// **'Available Times'**
  String get available_times;

  /// No description provided for @booking_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Booking created successfully'**
  String get booking_created_successfully;

  /// No description provided for @free_cancellation.
  ///
  /// In en, this message translates to:
  /// **'Free cancellation'**
  String get free_cancellation;

  /// No description provided for @cancel_before_for_full_refund.
  ///
  /// In en, this message translates to:
  /// **'Cancel before 24 hours for full refund'**
  String get cancel_before_for_full_refund;

  /// No description provided for @search_for_services.
  ///
  /// In en, this message translates to:
  /// **'Search for services'**
  String get search_for_services;

  /// No description provided for @no_categories_found.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get no_categories_found;

  /// No description provided for @providers_sorted_by_distance.
  ///
  /// In en, this message translates to:
  /// **'Providers sorted by distance'**
  String get providers_sorted_by_distance;

  /// No description provided for @providers_sorted_by_price.
  ///
  /// In en, this message translates to:
  /// **'Providers sorted by price'**
  String get providers_sorted_by_price;

  /// No description provided for @providers_sorted_by_rating.
  ///
  /// In en, this message translates to:
  /// **'Providers sorted by rating'**
  String get providers_sorted_by_rating;

  /// No description provided for @loading_providers.
  ///
  /// In en, this message translates to:
  /// **'Loading providers...'**
  String get loading_providers;

  /// No description provided for @no_providers_available.
  ///
  /// In en, this message translates to:
  /// **'No providers available'**
  String get no_providers_available;

  /// No description provided for @available_providers.
  ///
  /// In en, this message translates to:
  /// **'Available Providers'**
  String get available_providers;

  /// No description provided for @filter_and_sort.
  ///
  /// In en, this message translates to:
  /// **'Filter and Sort'**
  String get filter_and_sort;

  /// No description provided for @providers_available.
  ///
  /// In en, this message translates to:
  /// **'providers available'**
  String get providers_available;

  /// No description provided for @sort_providers.
  ///
  /// In en, this message translates to:
  /// **'Sort Providers'**
  String get sort_providers;

  /// No description provided for @nearest_distance.
  ///
  /// In en, this message translates to:
  /// **'Nearest (Distance)'**
  String get nearest_distance;

  /// No description provided for @lowest_price.
  ///
  /// In en, this message translates to:
  /// **'Lowest Price'**
  String get lowest_price;

  /// No description provided for @highest_rating.
  ///
  /// In en, this message translates to:
  /// **'Highest Rating'**
  String get highest_rating;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @app_language.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get app_language;

  /// No description provided for @message_sent.
  ///
  /// In en, this message translates to:
  /// **'Message sent'**
  String get message_sent;

  /// No description provided for @thank_you_contacting_us.
  ///
  /// In en, this message translates to:
  /// **'Thank you for contacting us'**
  String get thank_you_contacting_us;

  /// No description provided for @help_support.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help_support;

  /// No description provided for @how_can_we_help_you.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get how_can_we_help_you;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @what_is_your_issue_about.
  ///
  /// In en, this message translates to:
  /// **'What is your issue about?'**
  String get what_is_your_issue_about;

  /// No description provided for @please_enter_a_subject.
  ///
  /// In en, this message translates to:
  /// **'Please enter a subject'**
  String get please_enter_a_subject;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @describe_your_issue_in_detail.
  ///
  /// In en, this message translates to:
  /// **'Describe your issue in detail'**
  String get describe_your_issue_in_detail;

  /// No description provided for @please_enter_your_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter your message'**
  String get please_enter_your_message;

  /// No description provided for @message_must_be_at_least_10_characters.
  ///
  /// In en, this message translates to:
  /// **'Message must be at least 10 characters'**
  String get message_must_be_at_least_10_characters;

  /// No description provided for @send_message.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get send_message;

  /// No description provided for @contact_information.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contact_information;

  /// No description provided for @support_email.
  ///
  /// In en, this message translates to:
  /// **'Support Email'**
  String get support_email;

  /// No description provided for @support_phone.
  ///
  /// In en, this message translates to:
  /// **'Support Phone'**
  String get support_phone;

  /// No description provided for @booking_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Booking Cancelled'**
  String get booking_cancelled;

  /// No description provided for @your_booking_has_been_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Your booking has been cancelled'**
  String get your_booking_has_been_cancelled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'ku'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'ku':
      return AppLocalizationsKu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
