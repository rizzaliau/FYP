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
    
    public BreakdownItem(String itemName,Double qty, Double returnedQty){
        this.itemName = itemName;
        this.qty = qty;
        this.returnedQty = returnedQty;
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
    
}
