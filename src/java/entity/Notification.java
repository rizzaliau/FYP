/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Rizza
 */
public class Notification {
    private String orderID;
    private String debtorName;
    private String companyName;
    private String createdTimeStamp;
    private int flag;
    
    public Notification(String orderID, String debtorName, String companyName, String createdTimeStamp, int flag){
        this.orderID = orderID;
        this.debtorName = debtorName;
        this.companyName = companyName;
        this.createdTimeStamp = createdTimeStamp;
        this.flag = flag;
    }
    
    public String getOrderID() {
        return orderID;
    } 
    
    public String getDebtorName() {
        return debtorName;
    } 
    
    public String getCompanyName() {
        return companyName;
    } 
    
    public String getCreatedTimeStamp() {
        return createdTimeStamp;
    } 
    
    public int getFlag() {
        return flag;
    }
    
    public String getFormattedCreatedTimeStamp(){
        String year = createdTimeStamp.substring(0,4);
        String month = createdTimeStamp.substring(5,7);
        String day = createdTimeStamp.substring(8,10);
        String time = createdTimeStamp.substring(11,19);
        
        return day+"-"+month+"-"+year+" "+time;
    }
    
    
}
