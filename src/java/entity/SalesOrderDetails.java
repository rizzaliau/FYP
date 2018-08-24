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
public class SalesOrderDetails {
    
    private String orderID;
    private String createTimeStamp;
    private String lastModifiedTimeStamp;
    private String status;
    private String deliveryDate;
    private String subTotal;
    private String companyName;
    private String debtorName;
    private String deliverContact;
    private String displayTerm;
    private String routeNumber;
    private String deliverAddr1;
    private String deliverAddr2;
    private String deliverAddr3;
    private String deliverAddr4;
    private String lastModifiedBy;
    private String paperBagRequired;
    private String preferredLanguage;
        
    public SalesOrderDetails(String orderID, String createTimeStamp, String lastModifiedTimeStamp, String status, String deliveryDate,
            String subTotal, String companyName, String debtorName, String deliverContact ,String displayTerm, 
            String routeNumber, String deliverAddr1, String deliverAddr2, String deliverAddr3, String deliverAddr4,
            String lastModifiedBy, String paperBagRequired, String preferredLanguage){
        
        this.orderID = orderID;
        this.createTimeStamp = createTimeStamp;
        this.lastModifiedTimeStamp = lastModifiedTimeStamp;
        this.status = status;
        this.deliveryDate = deliveryDate;
        this.subTotal = subTotal;
        this.companyName = companyName;
        this.debtorName = debtorName;
        this.deliverContact = deliverContact;
        this.displayTerm = displayTerm;
        this.routeNumber = routeNumber;
        this.deliverAddr1 = deliverAddr1;
        this.deliverAddr2 = deliverAddr2;
        this.deliverAddr3 = deliverAddr3;
        this.deliverAddr4 = deliverAddr4;
        this.lastModifiedBy = lastModifiedBy;
        this.paperBagRequired = paperBagRequired;
        this.preferredLanguage = preferredLanguage;
    }
    
    
    public String getOrderID(){
        return orderID;
    }
    
    
    public String getCreateTimeStamp(){
        return createTimeStamp;
    }
    
    public String getStatus(){
        return status;
    }
    
    
    public String getLastModifiedTimeStamp(){
        return lastModifiedTimeStamp;
    }
    
    public String getDeliveryDate(){
        return deliveryDate;
    }
    
    public String getSubTotal(){
        return subTotal;
    }
    
    public String getCompanyName(){
        return companyName;
    }
    public String getDebtorName(){
        return debtorName;
    }
    
    public String getDeliverContact(){
        return deliverContact;
    }
    
    public String getDisplayTerm(){
        return displayTerm;
    }
    
    public String getRouteNumber(){
        return routeNumber;
    }
    
    public String getDeliverAddr1(){
        return deliverAddr1;
    }
    
    public String getDeliverAddr2(){
        return deliverAddr2;
    }
    
    public String getDeliverAddr3(){
        return deliverAddr3;
    }
    
    public String getDeliverAddr4(){
        return deliverAddr4;
    }
    
    public String getLastModifiedBy(){
        return lastModifiedBy;
    }
    
    public String getPaperBagRequired(){
        
        if(paperBagRequired.equals("0")){
            return "No";
        }
        
        return "Yes";
    }
    
    public String getPreferredLanguage(){
        return preferredLanguage;
    }
    
}