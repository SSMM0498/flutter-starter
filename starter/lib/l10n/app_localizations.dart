import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search a item'**
  String get search;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @failedToAuthenticate.
  ///
  /// In en, this message translates to:
  /// **'Failed to authenticate.'**
  String get failedToAuthenticate;

  /// No description provided for @onBoardingPage1Title.
  ///
  /// In en, this message translates to:
  /// **'Welcome To Starter'**
  String get onBoardingPage1Title;

  /// No description provided for @onBoardingPage1SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Immerse yourself in the app.'**
  String get onBoardingPage1SubTitle;

  /// No description provided for @onBoardingPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Explore A Rich Library'**
  String get onBoardingPage2Title;

  /// No description provided for @onBoardingPage2SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Access a large collection of item'**
  String get onBoardingPage2SubTitle;

  /// No description provided for @onBoardingPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Use Anytime, Anywhere'**
  String get onBoardingPage3Title;

  /// No description provided for @onBoardingPage3SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Receive daily notifications, download items, and track your progress'**
  String get onBoardingPage3SubTitle;

  /// No description provided for @onBoardingPage4Title.
  ///
  /// In en, this message translates to:
  /// **'Special features'**
  String get onBoardingPage4Title;

  /// No description provided for @onBoardingPage4SubTitle.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet thioune thioune mbaye'**
  String get onBoardingPage4SubTitle;

  /// No description provided for @emailChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Changez votre e-mail'**
  String get emailChangeTitle;

  /// No description provided for @emailChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You will automatically logout after this action.'**
  String get emailChangeSubtitle;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @usernameChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your username'**
  String get usernameChangeTitle;

  /// No description provided for @usernameChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a username as shorter as possible.'**
  String get usernameChangeSubtitle;

  /// No description provided for @firstname.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get firstname;

  /// No description provided for @lastname.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get lastname;

  /// No description provided for @nameUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your name has been updated.'**
  String get nameUpdated;

  /// No description provided for @nameChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your name'**
  String get nameChangeTitle;

  /// No description provided for @nameChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use real name for easy validation. This name will appear on several pages.'**
  String get nameChangeSubtitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your phone number'**
  String get phoneNumberChangeTitle;

  /// No description provided for @phoneNumberChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use a valid phone number.'**
  String get phoneNumberChangeSubtitle;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'{field} is required.'**
  String fieldRequired(Object field);

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {minCharacters} characters long.'**
  String passwordMinLength(Object minCharacters);

  /// No description provided for @passwordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter.'**
  String get passwordUppercase;

  /// No description provided for @passwordNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number.'**
  String get passwordNumber;

  /// No description provided for @passwordSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character.'**
  String get passwordSpecialChar;

  /// No description provided for @passwordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Password Confirmation'**
  String get passwordConfirmation;

  /// No description provided for @passwordConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'The password confirmation does not match.'**
  String get passwordConfirmationMessage;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format (9 digits required).'**
  String get invalidPhoneNumber;

  /// No description provided for @profileImage.
  ///
  /// In en, this message translates to:
  /// **'Your profile image has been updated!'**
  String get profileImage;

  /// No description provided for @usernameUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your username has been updated.'**
  String get usernameUpdated;

  /// No description provided for @changeEmailMail.
  ///
  /// In en, this message translates to:
  /// **'Please check your inbox and verify your email.'**
  String get changeEmailMail;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to'**
  String get iAgreeTo;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUse;

  /// No description provided for @acceptPolicy.
  ///
  /// In en, this message translates to:
  /// **'Accept Privacy Policy'**
  String get acceptPolicy;

  /// No description provided for @acceptPolicyMessage.
  ///
  /// In en, this message translates to:
  /// **'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.'**
  String get acceptPolicyMessage;

  /// No description provided for @congratulationVerifyMail.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created! Verify email to continue.'**
  String get congratulationVerifyMail;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @letsBecome.
  ///
  /// In en, this message translates to:
  /// **'Let’s become a member'**
  String get letsBecome;

  /// No description provided for @loginSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey of spiritual growth and knowledge.'**
  String get loginSubTitle;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @emailVerification.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get emailVerification;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify your changed email'**
  String get verifyEmail;

  /// No description provided for @verifyEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification link to your new email. Please verify your email to continue.'**
  String get verifyEmailMessage;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @orSignInWith.
  ///
  /// In en, this message translates to:
  /// **'or sign in with'**
  String get orSignInWith;

  /// No description provided for @orSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'or sign up with'**
  String get orSignUpWith;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we process\nyour information...'**
  String get pleaseWait;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get resendEmail;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email Sent'**
  String get emailSent;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get notStarted;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languagesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the language you know.'**
  String get languagesSubtitle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Your Account Created'**
  String get accountCreated;

  /// No description provided for @accountCreatedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully.'**
  String get accountCreatedSubtitle;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My adresses'**
  String get myAddresses;

  /// No description provided for @myAddressesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Define the delivery address for purchases'**
  String get myAddressesSubtitle;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Define any type of notification message'**
  String get notificationsSubtitle;

  /// No description provided for @accountPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get accountPrivacy;

  /// No description provided for @accountPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage data use and connected accounts'**
  String get accountPrivacySubtitle;

  /// No description provided for @loadData.
  ///
  /// In en, this message translates to:
  /// **'Charge data'**
  String get loadData;

  /// No description provided for @loadDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Load all data from the server'**
  String get loadDataSubtitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Mode shadow'**
  String get darkMode;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Protect your eyes with dark mode'**
  String get darkModeSubtitle;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// No description provided for @profileInformation.
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get profileInformation;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @userID.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userID;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @noSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get noSet;

  /// No description provided for @reAuth.
  ///
  /// In en, this message translates to:
  /// **'Re-authenticate User'**
  String get reAuth;

  /// No description provided for @closeAccount.
  ///
  /// In en, this message translates to:
  /// **'Close Account'**
  String get closeAccount;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.'**
  String get deleteAccountWarning;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello My World 😁!'**
  String get helloWorld;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
