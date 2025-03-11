codeunit 50700 "Custom Events"
{
    trigger OnRun()
    begin
    end;

    local procedure T21()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure "Cust. Ledger Entry_OnAfterCopyCustLedgerEntryFromGenJnlLine"(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Tracking Code" := GenJournalLine."Tracking Code";
        CustLedgerEntry."Priority Level" := GenJournalLine."Priority Level";
    end;

    local procedure T36()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter, '', false, false)]
    local procedure "Sales Header_OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter"(var SalesHeader: Record "Sales Header"; var SellToCustomer: Record Customer; var IsHandled: Boolean)
    begin
        SalesHeader."Tracking Code" := SellToCustomer."Tracking Code";
        SalesHeader."Priority Level" := SellToCustomer."Priority Level";
    end;

    local procedure T81()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromSalesHeader, '', false, false)]
    local procedure "Gen. Journal Line_OnAfterCopyGenJnlLineFromSalesHeader"(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Tracking Code" := SalesHeader."Tracking Code";
        GenJournalLine."Priority Level" := SalesHeader."Priority Level";
    end;


}
