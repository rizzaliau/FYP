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
public class Wallet {
    private String id;
    private Double refundAmount;
    private String debtorCode;    
    private String status;    
    
    public Wallet(String id, Double refundAmount, String debtorCode, String status){
        
        this.id = id;
        this.refundAmount = refundAmount;
        this.debtorCode = debtorCode;
        this.status = status;
        
    }
    
    public String getID(){
        return id;
    }
    
    public Double getRefundAmount(){
        return refundAmount;
    }    
    
    
    public String getDebtorCode(){
        return debtorCode;
    }
    
    public String getStatus(){
        return status;
    }
    
}
