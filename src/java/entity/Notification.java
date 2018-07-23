/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

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
    
}
