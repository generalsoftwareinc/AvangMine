abstract class Validators {
  static bool correo(String text) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return text.contains(regExp);
  }

  // DD/MM/YYYY
  static bool date(String text) {
    return text.contains(RegExp(r'^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$'));
  }

  static bool url(String text) {
    return text.contains(RegExp(
        r'^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$'));
  }

  static bool userName(String text) {
    return text.contains(RegExp(r'([a-zA-Z\-0-9]+)$')) && text.length > 2;
  }

  // Other example
  // /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/
  static bool password(String text) {
    return
        // text.contains(RegExp(r'[A-Z]')) &&
        text.contains(RegExp(r'[a-z]')) &&
            text.contains(RegExp(r'[0-9]')) &&
            // text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
            text.length > 5;
  }

  static bool min(String text, int length) => text.trim().length >= length;
  static bool digits(String text) => text.contains(RegExp(r'(\d+)'));
  static bool letters(String text) => text.contains(RegExp(r'(\w+)'));
}
