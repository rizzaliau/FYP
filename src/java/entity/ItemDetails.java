/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.text.DecimalFormat;

/**
 *
 * @author Rizza
 */
public class ItemDetails {
    private String itemCode;
    private String qty;
    private String returnedQty;
    private String reducedQty;
    private String unitPrice;
    
    public ItemDetails(String itemCode, String qty, String returnedQty, String reducedQty, String unitPrice){
        this.itemCode=itemCode;
        this.qty=qty;
        this.returnedQty=returnedQty;
        this.reducedQty= reducedQty;
        this.unitPrice=unitPrice;
    }
    
    public String getItemCode(){
        return itemCode;
    }
    
    public String getQty(){
        return qty;
    }
    
    public String getReturnedQty(){
        
        if(returnedQty == null || returnedQty == ""){
            return "0";
        } 
        
        return returnedQty;
    }
    
    public String getUnitPrice(){
        return unitPrice;
    }
    
    public String getUnitPrice2DP(){
        DecimalFormat df = new DecimalFormat("0.00");
        double unitPriceDouble = Double.parseDouble(unitPrice);
        
        return df.format(unitPriceDouble);
    }
    
    public String getReducedQty(){
        return reducedQty;
    }
}
