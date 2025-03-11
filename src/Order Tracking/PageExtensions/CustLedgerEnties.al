pageextension 50703 "Cust. Ledger Enties" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Tracking Code"; Rec."Tracking Code")
            {
                ApplicationArea = all;
            }
            field("Priority Level"; Rec."Priority Level")
            {
                ApplicationArea = all;
            }
        }
    }
}
