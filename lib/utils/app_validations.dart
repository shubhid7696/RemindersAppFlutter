
passwordValidation(String input) {
  if (input.trim().length == 0)
    return "Password enter password.";
  else if (input.trim().length < 8)
    return "Password too short.";
  else
    return null;
}

phoneValidation(String input) {
  if (input.trim().isEmpty) {
    return "Please enter mobile number.";
  } else if(input.trim().length < 10){
    return "Phone number too short.";
  }else {
    return null;
  }
}

nameValidation(String input) {
  if (input.trim().isEmpty) {
    return "Please enter a valid name.";
  } else {
    return null;
  }
}

emailValidation(String input){
  Pattern emaiPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(emaiPattern);

  if (input.trim().isEmpty) {
    return "Please enter email.";
  } else if(!(regex.hasMatch(input))){
    return "Please enter a valid email.";
  } else {
    return null;
  }
}

shopNameValidation(String input) {
  if (input.trim().isEmpty) {
    return "Please enter shop name.";
  } else {
    return null;
  }
}

shopAddressValidation(String input) {
  if (input.trim().length == 0)
    return "Please enter the Address";
  /*else if (input.trim().length < 8)
                            return "Email must be longer than 8 alphanumerics";*/
  else
    return null;
}

