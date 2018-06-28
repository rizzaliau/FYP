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
public class ItemDetails {
    private String itemCode;
    private String qty;
    private String returnedQty;
    private String unitPrice;
    
    public ItemDetails(String itemCode, String qty, String returnedQty, String unitPrice){
        this.itemCode=itemCode;
        this.qty=qty;
        this.returnedQty=returnedQty;
        this.unitPrice=unitPrice;
    }
    
    public String getItemCode(){
        return itemCode;
    }
    
    public String getQty(){
        return qty;
    }
    
    public String getReturnedQty(){
        
        if(returnedQty == null){
            return "0";
        } 
        
        return returnedQty;
    }
    
    public String getUnitPrice(){
        return unitPrice;
    }
    
}
