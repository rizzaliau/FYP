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
public class OrderItem {
    private String itemCode;
    private String description;
    private String descriptionChinese;
    private String unitPrice;
    private String retailPrice;
    private String unitOfMetric;
    private String imageURL;
    private String defaultQuantity;
    private String quantityMultiples;
    private String status;
    private String lastModifiedTimeStamp;
    private String lastModifiedBy;
    
    public OrderItem(String itemCode, String description, String descriptionChinese, String unitPrice,String retailPrice,
            String unitOfMetric, String imageURL, String defaultQuantity, String quantityMultiples, 
            String status, String lastModifiedTimeStamp, String lastModifiedBy){
        
        this.itemCode=itemCode;
        this.description=description;
        this.descriptionChinese=descriptionChinese;
        this.unitPrice=unitPrice;
        this.retailPrice=retailPrice;
        this.unitOfMetric=unitOfMetric;
        this.imageURL=imageURL;
        this.defaultQuantity=defaultQuantity;
        this.quantityMultiples=quantityMultiples;
        this.status = status;
        this.lastModifiedTimeStamp = lastModifiedTimeStamp;
        this.lastModifiedBy = lastModifiedBy;
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
    
    public String getUnitPrice2DP(){
        DecimalFormat df = new DecimalFormat("0.00");
        double unitPriceDouble = Double.parseDouble(unitPrice);
        
        return df.format(unitPriceDouble);
    }
    
    public String getRetailPrice(){
        return retailPrice;
    }
    
    public String getRetailPrice2DP(){
        DecimalFormat df = new DecimalFormat("0.00");
        double retailPriceDouble = Double.parseDouble(retailPrice);
        
        return df.format(retailPriceDouble);
    }
    
    public String getUnitOfMetric(){
        return unitOfMetric;
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
    
     public String getStatus(){
        return status;
    }
     
    public String getLastModifiedTimeStamp(){
        return lastModifiedTimeStamp;
    }
     
    public String getLastModifiedBy(){
        return lastModifiedBy;
    }
}
