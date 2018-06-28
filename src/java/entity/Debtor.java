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
public class Debtor {
    
    private String debtorCode;
    private String companyCode;
    private String hashPassword;
    private String companyName;
    private String debtorName;
    private String deliverContact;
    private String deliverFax1;
    private String invAddr1;
    private String invAddr2;        
    private String invAddr3;
    private String invAddr4;
    private String deliverAddr1;
    private String deliverAddr2;
    private String deliverAddr3;
    private String deliverAddr4;
    private String displayTerm;
    private String status;
    private String routeNumber;
    
    public Debtor (String debtorCode, String companyCode, String hashPassword,String companyName,String debtorName, String deliverContact, String deliverFax1,
        String invAddr1,String invAddr2, String invAddr3, String invAddr4, String deliverAddr1, String deliverAddr2,
        String deliverAddr3, String deliverAddr4, String displayTerm, String status, String routeNumber){
        
        this.debtorCode = debtorCode;
        this.companyCode = companyCode;
        this.hashPassword = hashPassword;
        this.companyName = companyName;
        this.debtorName = debtorName;
        this.deliverContact = deliverContact;
        this.deliverFax1 = deliverFax1;
        this.invAddr1 = invAddr1;
        this.invAddr2 = invAddr2;        
        this.invAddr3 = invAddr3;
        this.invAddr4 = invAddr4;
        this.deliverAddr1 = deliverAddr1;
        this.deliverAddr2 = deliverAddr2;
        this.deliverAddr3 = deliverAddr3;
        this.deliverAddr4 = deliverAddr4;
        this.displayTerm = displayTerm;
        this.status = status;
        this.routeNumber = routeNumber;
    }
    
    public String getDebtorCode() {
        return debtorCode;
    } 
    
    public String getCompanyCode() {
        return companyCode;
    } 
    
    public String getPassword() {
        return hashPassword;
    }

    public String getDebtorName() {
        return debtorName;
    }
    
    public String getCompanyName() {
        return companyName;
    }
    
    public String getDeliverContact() {
        return deliverContact;
    }

    public String getDeliverFax1() {
        return deliverFax1;

    }

    public String getInvAddr1() {
        return invAddr1;

    }

    public String getInvAddr2() {
        return invAddr2;

    }

    public String getInvAddr3() {
        return invAddr3;

    }

    public String getInvAddr4() {
        return invAddr4;

    }
    
    public String getDeliverAddr1() {
        return deliverAddr1;

    }

    public String getDeliverAddr2() {
        return deliverAddr2;

    }

    public String getDeliverAddr3() {
        return deliverAddr3;

    }

    public String getDeliverAddr4() {
        return deliverAddr4;

    }

    public String getDisplayTerm() {
        return displayTerm;

    }

    public String getStatus() {
        return status;
    }
    
    public String getRouteNumber() {
        return routeNumber;
    }

}


