package entity;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import static javax.management.Query.value;

public class User {

  private String name;
  private String password;

  public User() {
  } // default constructor
  // Constructor for easy creation

  public User(String name, String password) {
    this.name = name;
    this.password = password;

  }

  public String getName() {
    return name;
  } // getName

  public void setName(String name) {
    this.name = name;
  } // setName

  public void setPassword(String password) {
    // encryption here possible
    this.password = password;
  } // setPassword

  public boolean authenticate(String password) {
    return password.equals(this.password);
  } // authenticate
  
  
}