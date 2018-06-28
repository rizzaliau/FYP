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
public class SalesOrder {
    
    private String orderID;
    private String debtorCode;
    private String debtorName;
    private String routeNumber;
    
    public SalesOrder(String orderID, String debtorCode, String debtorName, String routeNumber){
        
        this.orderID = orderID;
        this.debtorCode = debtorCode;
        this.debtorName = debtorName;
        this.routeNumber = routeNumber;
        
    }
    
    public String getOrderID(){
        return orderID;
    }
    
    public String getDebtorCode(){
        return debtorCode;
    }
    
    public String getDebtorName(){
        return debtorName;
    }
    
    public String getRouteNumber(){
        return routeNumber;
    }
    
}
