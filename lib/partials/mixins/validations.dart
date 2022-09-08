// ignore_for_file: non_constant_identifier_names

mixin ValidationMixin {
  String? validateShopNo(String? value) {
    if (value!.trim().isEmpty) return 'Shop number cannot be empty';

    return null;
  }

  String? validateField(String? value) {
    if (value!.trim().isEmpty) return 'Field cannot be empty';

    return null;
  }

  String? validateShopNoOptional(String? value) {
    if (value!.trim().isEmpty) return null;

    return null;
  }

  String? validateGeolocation(String? value) {
    if (value!.trim().isEmpty) return 'Geolocation cannot be empty';

    return null;
  }

  String? validatePassword(String? value) {
    if (value!.trim().isEmpty) {
      return 'Password cannot be empty';
    } else if (value.trim().length < 6) {
      return 'Password cannot be less than 6 characters';
    }

    return null;
  }

  String? validateCPassword(String? value, String? password) {
    if (value!.trim().isEmpty) {
      return 'Password cannot be empty';
    } else if (value != password) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  String? validateAmount(String? value) {
    if (value!.trim().isEmpty) {
      return 'Amount cannot be empty';
    } else if (double.parse(value.toString()) < 1.0) {
      return 'Input a valid Amount';
    }

    return null;
  }

  String? validateFullName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Full name cannot be empty';
    } else if (value.trim().length < 6) {
      return 'Full name cannot be less than 6 characters';
    }

    return null;
  }

  String? validateFirstName(String? value) {
    if (value!.trim().isEmpty) {
      return 'First name cannot be empty';
    } else if (value.trim().length < 2) {
      return 'First tname cannot be less than 2 characters';
    }

    return null;
  }
  String? validateLastName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Last name cannot be empty';
    } else if (value.trim().length < 2) {
      return 'Last name cannot be less than 2 characters';
    }

    return null;
  }

  String? validateShopName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Shop name cannot be empty';
    } else if (value.trim().length < 6) {
      return 'Shop name cannot be less than 6 characters';
    }

    return null;
  }

  String? validateCompanyName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Company name cannot be empty';
    } else if (value.trim().length < 6) {
      return 'Company name cannot be less than 6 characters';
    }

    return null;
  }

  String? validatePhone(String? value) {
    if (value!.trim().isEmpty) return 'Phone cannot be empty';
    if (value.trim().length != 10) return 'Phone is Invalid';

    return null;
  }

  String? validateSearchController(String? value) {
    if (value!.trim().isEmpty) return 'please enter a valid location';

    return null;
  }

  String? validateSearchDestController(String? value) {
    if (value!.trim().isEmpty) return 'please enter a valid location';

    return null;
  }

  String? validateOTP(String? value) {
    if (value!.trim().isEmpty) return 'OTP cannot be empty';
    return null;
  }

  String? validateOTP_Test(String? value) {
    // String otpValue = "1234";
    if (value!.trim().isEmpty) return 'OTP cannot be empty';
    // if (value.trim() != otpValue) return 'OTP Must be 1234';
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
      return 'Amount cannot be empty';
    } else if (double.parse(value.toString()) < 1.0) {
      return 'Input a valid Amount';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return "Email cannot be empty";
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
      return 'Driver Licence cannot be empty';
    } else if (RegExp(r"^[A-Z]{3}[0-9]{5}[A-Z]{2}[0-9]{1,2}$")
            .hasMatch(value) ==
        false) {
      return 'Format: AKW12345AA15 or AKW12345AA1';
    }

    return null;
  }

  String? validateDriverLicenceOptional(String? value) {
    // (STRUCTURE= 3 letters, 5 numbers, 2 letters, 2 letter. E.g. AKW12345AA1)
    if (value!.trim().isEmpty) {
      return null;
    } else if (RegExp(r"^[A-Z]{3}[0-9]{5}[A-Z]{2}[0-9]{1,2}$")
            .hasMatch(value) ==
        false) {
      return 'Format: AKW12345AA15, or AKW12345AA1';
    }
    return null;
  }

  String? validatePlateNo(String? value) {
    if (value!.trim().isEmpty) {
      return 'Plate Number cannot be empty';
    } else if (value.trim().length < 6) {
      return 'Plate Number cannot be less than 6 characters';
    }

    return null;
  }

  String? validatePlateNoOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (value.trim().length < 6) {
      return 'Plate Number cannot be less than 6 characters';
    }

    return null;
  }

  String? validateAddress(String? value) {
    if (value!.trim().isEmpty) {
      return 'Address cannot be empty';
    } else if (value.trim().length < 10) {
      return 'Address cannot be less than 10 characters';
    }

    return null;
  }

  String? validateAddressOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (value.trim().length < 10) {
      return 'Address cannot be less than 10 characters';
    }

    return null;
  }

// voter's card  (STRUCTURE= e.g 90F5B18B4A296830750)
//  National ID number NIN (STRUCTURE= 11 digits only e.g 18939203940)

  String? validatesIDNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'ID Number cannot be empty';
    } else if (value.trim().length < 6) {
      return 'ID Number cannot be less than 6 characters';
    }

    return null;
  }

  String? validatesIDNumberOptional(String? value) {
    if (value!.trim().isEmpty) {
      return null;
    } else if (value.trim().length < 6) {
      return 'ID Number cannot be less than 6 characters';
    }

    return null;
  }

  String? validatesBVNNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'BVN Number cannot be empty';
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
    if (value!.trim().isEmpty) {
      return "International Passport Number cannot be empty";
    }

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
    if (value!.trim().isEmpty) return 'Land Reg Number cannot be empty';

    return null;
  }

  String? validateLandRegNumberOptional(String? value) {
    if (value!.trim().isEmpty) return null;

    return null;
  }

  String? validateBusinessAddress(String? value) {
    if (value!.trim().isEmpty) return 'Business address cannot be empty';
    if (value.trim().length < 10) return 'Full business address is required';

    return null;
  }

  String? validateResidentialAddress(String? value) {
    if (value!.trim().isEmpty) {
      return 'Residential address cannot be empty';
    } else if (value.trim().length < 10) {
      return 'Full residential address is required';
    }

    return null;
  }

  String? validateNoOfStaff(String? value) {
    if (value!.trim().isEmpty) {
      return 'Number of staff cannot be empty';
    } else if (double.parse(value.toString()) < 1.0) {
      return 'Input a valid number';
    }

    return null;
  }

  String? validateTown(String? value) {
    if (value!.trim().isEmpty) return 'Town cannot be empty';

    return null;
  }

  ///Premises
  String? validatePremiseName(String? value) {
    if (value!.trim().isEmpty) return 'Premise name cannot be empty';

    return null;
  }

  String? validatePremiseSize(String? value) {
    if (value!.trim().isEmpty) return 'Premise size cannot be empty';

    return null;
  }

  ///Signages
  String? validateSignageAddressDesc(String? value) {
    if (value!.trim().isEmpty) return 'Signage address cannot be empty';
    if (value.trim().length < 10) {
      return 'Detailed signage address desc required';
    }

    return null;
  }

  String? validateSignageAddressDescOptional(String? value) {
    if (value!.trim().isEmpty) return null;
    if (value.trim().length < 10) {
      return 'Detailed signage address desc required';
    }

    return null;
  }

  String? validateSignageName(String? value) {
    if (value!.trim().isEmpty) return 'Signage name cannot be empty';

    return null;
  }

  /// Mast
  String? validateMastAddressDesc(String? value) {
    if (value!.trim().isEmpty) return 'Mast address can not be empty';
    if (value.trim().length < 10) return 'Detailed mast address desc required';

    return null;
  }

  String? validateMastName(String? value) {
    if (value!.trim().isEmpty) return 'Mast name cannot be empty';

    return null;
  }

  String? validateMastNumber(String? value) {
    if (value!.trim().isEmpty) return 'Mast number cannot be empty';

    return null;
  }
}
