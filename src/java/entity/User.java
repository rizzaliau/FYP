package entity;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import static javax.management.Query.value;

public class User {
    
  private int id;
  private String name;
  private String password;
  private int isMaster;
  private String status;


  public User() {
  } // default constructor
  // Constructor for easy creation

  public User(int id, String name, String password, int isMaster, String status) {
      
    this.id = id;
    this.name = name;
    this.password = password;
    this.isMaster = isMaster;
    this.status = status;

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

  public int getIsMaster() {
    return isMaster;
  } // setName
  
  public String getIsMasterString() {
      if(isMaster == 1){
          return "Yes";
      }
    return "No";
  }
  
  public String getStatus(){
    return status;
  }
  
  public String getID(){
      return ""+id;
  }
  
}