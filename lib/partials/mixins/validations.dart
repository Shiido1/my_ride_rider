mixin ValidationMixin {
  String? validateShopNo(String? value) {
    if (value!.trim().isEmpty) return 'Shop number can not be empty';

    return null;
  }

  String? validateShopNoOptional(String? value) {
    if (value!.trim().isEmpty) return null;

    return null;
  }

  String? validateGeolocation(String? value) {
    if (value!.trim().isEmpty) return 'Geolocation can not be empty';

    return null;
  }

  String? validatePassword(String? value) {
    if (value!.trim().isEmpty) {
      return 'Password can not be empty';
    } else if (value.trim().length < 6) {
      return 'Password can not be less than 6 characters';
    }

    return null;
  }

  String? validateCPassword(String? value, String? password) {
    if (value!.trim().isEmpty) {
      return 'Password can not be empty';
    } else if (value != password) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  String? validateAmount(String? value) {
    if (value!.trim().isEmpty) {
      return 'Amount can not be empty';
    } else if (double.parse(value.toString()) < 1.0) {
      return 'Input a valid Amount';
    }

    return null;
  }

  String? validateFullName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Fullname can not be empty';
    } else if (value.trim().length < 6) {
      return 'Fullname can not be less than 6 characters';
    }

    return null;
  }

  String? validateName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Name can not be empty';
    } else if (value.trim().length < 2) {
      return 'Name can not be less than 2 characters';
    }

    return null;
  }

  String? validateShopName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Shop name can not be empty';
    } else if (value.trim().length < 6) {
      return 'Shop name can not be less than 6 characters';
    }

    return null;
  }

  String? validateCompanyName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Company name can not be empty';
    } else if (value.trim().length < 6) {
      return 'Company name can not be less than 6 characters';
    }

    return null;
  }

  String? validatePhone(String? value) {
    if (value!.trim().isEmpty) return 'Phone can not be empty';
    if (value.trim().length != 11) return 'Phone is Invalid';

    return null;
  }

  String? validateSearchController (String? value){
    if (value!.trim().isEmpty) return 'please enter a valid location';

    return null;
  }

  String? validateSearchDestController (String? value){
    if (value!.trim().isEmpty) return 'please enter a valid location';

    return null;
  }

  String? validateOTP(String? value) {
    if (value!.trim().isEmpty) return 'OTP can not be empty';
    return null;
  }
  String? validateOTP_Test(String? value) {
    String otpValue = "1234";
    if (value!.trim().isEmpty) return 'OTP can not be empty';
    if (value.trim() != otpValue) return 'OTP Must be 1234';
    return null;
  }


    String? validateCountryCode(String? value) {
      if (value!.trim().isEmpty) return 'country code cannot be empty';

    return null;
  }
    String? validateDeviceType(String? value) {
      if (value!.trim().isEmpty) return 'enter your device Type';


      return null;
  }

  String? validatePhoneOptional(String? value) {
    if (value!.trim().isEmpty) return null;
    if (value.trim().length != 11) return 'Phone is Invalid';

    return null;
  }

  String? validateContractAmount(String? value) {
    if (value!.trim().isEmpty) {
      return 'Amount can not be empty';
    } else if (double.parse(value.toString()) < 1.0) {
      return 'Input a valid Amount';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return "Email can not be empty";
    } else if (RegExp(
                r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value) ==
        false) {
      return 'Email not valid';
    }
    return null;
  }

  String? validateEmailOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (RegExp(
                r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value) ==
        false) {
      return 'Email not valid';
    }

    return null;
  }

  String? validateDriverLicence(String? value) {
    // (STRUCTURE= 3 letters, 5 numbers, 2 letters, 22 letter. E.g. AKW12345AA1)
    if (value!.trim().isEmpty) {
      return 'Driver Licence can not be empty';
    } else if (RegExp(r"^[A-Z]{3}[0-9]{5}[A-Z]{2}[0-9]{1,2}$").hasMatch(value) == false) {
      return 'Format: AKW12345AA15 or AKW12345AA1';
    }

    return null;
  }

  String? validateDriverLicenceOptional(String? value) {
    // (STRUCTURE= 3 letters, 5 numbers, 2 letters, 2 letter. E.g. AKW12345AA1)
    if (value!.trim().isEmpty) {
      return null;
    } else if (RegExp(r"^[A-Z]{3}[0-9]{5}[A-Z]{2}[0-9]{1,2}$").hasMatch(value) == false) {
      return 'Format: AKW12345AA15, or AKW12345AA1';
    }
    return null;
  }

  String? validatePlateNo(String? value) {
    if (value!.trim().isEmpty) {
      return 'Plate Number can not be empty';
    } else if (value.trim().length < 6) {
      return 'Plate Number can not be less than 6 characters';
    }

    return null;
  }

  String? validatePlateNoOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (value.trim().length < 6) {
      return 'Plate Number can not be less than 6 characters';
    }

    return null;
  }

  String? validateAddress(String? value) {
    if (value!.trim().isEmpty) {
      return 'Address can not be empty';
    } else if (value.trim().length < 10) {
      return 'Address can not be less than 10 characters';
    }

    return null;
  }

  String? validateAddressOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (value.trim().length < 10) {
      return 'Address can not be less than 10 characters';
    }

    return null;
  }

// voter's card  (STRUCTURE= e.g 90F5B18B4A296830750)
//  National ID number NIN (STRUCTURE= 11 digits only e.g 18939203940)

  String? validatesIDNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'ID Number can not be empty';
    } else if (value.trim().length < 6) {
      return 'ID Number can not be less than 6 characters';
    }

    return null;
  }

  String? validatesIDNumberOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (value.trim().length < 6) {
      return 'ID Number can not be less than 6 characters';
    }

    return null;
  }

  String? validatesBVNNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'BVN Number can not be empty';
    } else if (RegExp(r"^[0-9]{11}$").hasMatch(value) == false) {
      return 'Invalid BVN Number';
    }

    return null;
  }

  String? validatesBVNNumberOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (RegExp(r"^[0-9]{11}$").hasMatch(value) == false) {
      return 'Invalid BVN Number';
    }

    return null;
  }

  String? validatesIntPassport(String? value) {
    if (value!.trim().isEmpty) return "International Passport Number can not be empty";

    return null;
  }

  String? validatesIntPassportOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (value.trim().length != 11) {
      return 'Invalid International Passport Number';
    }

    return null;
  }

  String? validateLandRegNumber(String? value) {
    if (value!.trim().isEmpty) return 'Land Reg Number can not be empty';

    return null;
  }

  String? validateLandRegNumberOptional(String? value) {
    if (value!.trim().isEmpty) return null;

    return null;
  }

  String? validateBusinessAddress(String? value) {
    if (value!.trim().isEmpty) return 'Business address can not be empty';
    if (value.trim().length < 10) return 'Full business address is required';

    return null;
  }

  String? validateResidentialAddress(String? value) {
    if (value!.trim().isEmpty) {
      return 'Residential address can not be empty';
    } else if (value.trim().length < 10) {
      return 'Full residential address is required';
    }

    return null;
  }

  String? validateNoOfStaff(String? value) {
    if (value!.trim().isEmpty) {
      return 'Number of staff can not be empty';
    } else if (double.parse(value.toString()) < 1.0) {
      return 'Input a valid number';
    }

    return null;
  }

  String? validateTown(String? value) {
    if (value!.trim().isEmpty) return 'Town can not be empty';

    return null;
  }

  ///Premises
  String? validatePremiseName(String? value) {
    if (value!.trim().isEmpty) return 'Premise name can not be empty';

    return null;
  }

  String? validatePremiseSize(String? value) {
    if (value!.trim().isEmpty) return 'Premise size can not be empty';

    return null;
  }

  ///Signages
  String? validateSignageAddressDesc(String? value) {
    if (value!.trim().isEmpty) return 'Signage address can not be empty';
    if (value.trim().length < 10) return 'Detailed signage address desc required';

    return null;
  }

  String? validateSignageAddressDescOptional(String? value) {
    if (value!.trim().isEmpty) return null;
    if (value.trim().length < 10) return 'Detailed signage address desc required';

    return null;
  }

  String? validateSignageName(String? value) {
    if (value!.trim().isEmpty) return 'Signage name can not be empty';

    return null;
  }

  /// Mast
  String? validateMastAddressDesc(String? value) {
    if (value!.trim().isEmpty) return 'Mast address can not be empty';
    if (value.trim().length < 10) return 'Detailed mast address desc required';

    return null;
  }

  String? validateMastName(String? value) {
    if (value!.trim().isEmpty) return 'Mast name can not be empty';

    return null;
  }

  String? validateMastNumber(String? value) {
    if (value!.trim().isEmpty) return 'Mast number can not be empty';

    return null;
  }
}
