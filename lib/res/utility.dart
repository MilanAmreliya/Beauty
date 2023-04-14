class Utility {
  static bool isImageChange = true;

  static String googleMapKey = "AIzaSyDkeSrH1tXjPMW4zpZDckW3zKWLRGeWd0M";
  static String emailAddressValidationPattern = r"([a-zA-Z0-9_@.])";
  static String password = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String emailText = "email";
  static String addressText = "address";
  static String passwordText = "password";
  static String somethingWentToWrong = "Something went to wrong...";
  static String nameEmptyValidation = "Name is required";
  static String userNameEmptyValidation = "Username is required";
  static String lastNameEmptyValidation = "Last Na  me is required";
  static String emailEmptyValidation = "Email is required";
  static String addressEmptyValidation = "Address is required";
  static String isRequired = " is required";
  static String aboutEmptyValidation = "About is required";
  static String kUserNameEmptyValidation = 'Please Enter Valid Email';
  static String kEnterBankName = 'Please Enter Bank Name';
  static String kEnterBankAccountNumber = 'Please Enter Account Number';
  static String kEnterBsbNumber = 'Please Enter BSB Number';
  static String kPasswordEmptyValidation = 'Please Enter Password';
  static String kPasswordLengthValidation = 'Must be more than 6 Characters';
  static String kMobileNoLengthValidation = 'Mobile Number Must be 10 Digit';
  static String kPasswordInValidValidation = 'Password Invalid';
  static String mobileNumberInValidValidation = "Mobile Number is required";
  static String amountValidValidation = "amount is required";
  static String mapInValidValidation = "Map is required";
  static String otpInValidValidation = "OTP is required";
  static String alphabetValidationPattern = r"[a-zA-Z]";
  static String alphabetSpaceValidationPattern = r"[a-zA-Z0-9 ]";
  static String userNamevalidationPattern = r"[a-zA-Z ]";
  static String alphabetDigitsValidationPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpaceValidationPattern = r"[a-zA-Z0-9 ]";

  static String alphabetDigitsSpacePlusValidationPattern = r"[a-zA-Z0-9+ ]";

  static String alphabetDigitsSpecialValidationPattern = r"[a-zA-Z0-9#&$%_@. ]";

  static String alphabetDigitsDashValidationPattern = r"[a-zA-Z0-9- ]";
  static String addressValidationPattern = r"[a-zA-Z0-9-@#&* ]";
  static String allowedPattern = r"[a-zA-Z0-9-@#&* ]";
  static String digitsValidationPattern = r'^\d+\.?\d*';

  static String privacyPolicyText =
      "It is a long established fact that a reader will be distracted by the readable content of a page when \n \nlooking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. \n \nMany desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. \n \nVarious versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";

  static String passwordNotMatch =
      "Password and Conform password does not match!";
  static String termsConditions = "Terms & Conditions";
  static String termsConditionsMessage = "Please check Term Condition!";
  static String artistModelRoleMessage = "Please Select Role!";
  static String uploadingTitle = "Uploading Message";
  static String downloadingTitle = "Download Message";
  static String loginError = "Login Error";
  static String invalidPasswordMessage =
      "The password is invalid or the user does not have a password.";
  static String userNotExist = "User Not Exist!";
  static int kPasswordLength = 6;

  static String validateUserName(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool regex = new RegExp(pattern).hasMatch(value);
    if (value.isEmpty) {
      return kUserNameEmptyValidation;
    } else if (regex == false) {
      return kUserNameEmptyValidation;
    }
    return null;
  }

  static String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return kPasswordEmptyValidation;
    } else if (value.length < kPasswordLength) {
      return kPasswordLengthValidation;
    }
    return null;
  }
}
