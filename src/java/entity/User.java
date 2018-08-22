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
  private int isMaster;
  private String status;
  private String lastModifiedTimestamp;
  private String lastModifiedBy;

  public User() {
  } // default constructor
  // Constructor for easy creation

  public User( String name, String password, int isMaster, String status, String lastModifiedTimestamp, String lastModifiedBy) {
      
    this.name = name;
    this.password = password;
    this.isMaster = isMaster;
    this.status = status;
    this.lastModifiedTimestamp = lastModifiedTimestamp;
    this.lastModifiedBy = lastModifiedBy;
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
  
  public String getHashPassword(){
      return password;
  }
  
  public String getLastModifiedTimestamp(){
      return lastModifiedTimestamp;
  }
  
  public String getLastModifiedBy(){
      return lastModifiedBy;
  }
  
}