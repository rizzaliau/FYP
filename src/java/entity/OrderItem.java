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
public class OrderItem {
    private String itemCode;
    private String description;
    private String descriptionChinese;
    private String unitPrice;
    private String imageURL;
    private String defaultQuantity;
    private String quantityMultiples;
    
    public OrderItem(String itemCode, String description, String descriptionChinese, String unitPrice, String imageURL, 
            String defaultQuantity, String quantityMultiples){
        
        this.itemCode=itemCode;
        this.description=description;
        this.descriptionChinese=descriptionChinese;
        this.unitPrice=unitPrice;
        this.imageURL=imageURL;
        this.defaultQuantity=defaultQuantity;
        this.quantityMultiples=quantityMultiples;
    }
    
    public String getItemCode(){
        return itemCode;
    }
    
    public String getDescription(){
        return description;
    }
    public String getDescriptionChinese(){
        return descriptionChinese;
    }
    
    public String getUnitPrice(){
        return unitPrice;
    }
    public String getImageURL(){
        return imageURL;
    }
    
    public String getDefaultQuantity(){
        return defaultQuantity;
    }

    public String getQuantityMultiples(){
        return quantityMultiples;
    }
    
}
