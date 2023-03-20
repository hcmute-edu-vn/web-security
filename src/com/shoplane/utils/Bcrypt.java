package com.shoplane.utils;

import org.mindrot.jbcrypt.BCrypt;

public class Bcrypt {

  public static String hashpwd(String pwd) {
    if (pwd.trim() != null) {
      String hash = BCrypt.hashpw(pwd, BCrypt.gensalt(12));
      return hash;
    }
    return null;
  }

  public static boolean checkpwd(String pwdNotHash, String pwdHashed) {
    try {
      boolean isPwd = BCrypt.checkpw(pwdNotHash, pwdHashed);
      return isPwd;
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return false;
    }
  }
}
