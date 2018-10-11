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
    private Double rebateAmount;
    private String debtorCode;    
    
    public Wallet(String id, Double refundAmount, Double rebateAmount,String debtorCode){
        
        this.id = id;
        this.refundAmount = refundAmount;
        this.rebateAmount = rebateAmount;
        this.debtorCode = debtorCode;
        
    }
    
    public String getID(){
        return id;
    }
    
    public Double getRefundAmount(){
        return refundAmount;
    }    
    
    public Double getRebateAmount(){
        return rebateAmount;
    }
    
    public String getDebtorCode(){
        return debtorCode;
    }
    
}
