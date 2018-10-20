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
public class Transaction {
    
    private String id;
    private String status;
    private String createdTimeStamp;
    private String amount;
    private String orderID;
    
    public Transaction(String id, String status, String createdTimeStamp, String amount, String orderID){
        this.id = id;
        this.status = status;
        this.createdTimeStamp = createdTimeStamp;
        this.amount = amount;
        this.orderID = orderID;
        
    }
    
    public String getID(){
        return id;
    }
    
    public String getStatus(){
        return status;
    }
    
    public String getCreatedTimeStamp(){
        return createdTimeStamp;
    }
    
    public double getAmount(){
        return Double.parseDouble(amount);
    }
            
    public String getOrderID(){
        return orderID;
    }
    
}
