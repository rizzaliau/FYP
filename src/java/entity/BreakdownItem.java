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
public class BreakdownItem {
    private String itemName;
    private Double qty;
    private Double returnedQty;
    private Double percentageReturned;
    
    public BreakdownItem(String itemName,Double qty, Double returnedQty,Double percentageReturned){
        this.itemName = itemName;
        this.qty = qty;
        this.returnedQty = returnedQty;
        this.percentageReturned = percentageReturned;
    }
    
    public String getItemName(){
        return itemName;
    }
        
    public Double getQty(){
        return qty;
    }
            
    public Double getReturnedQty(){
        return returnedQty;
    }
    
    public Double getPercentageReturned(){
        return percentageReturned;
    }
    
}
