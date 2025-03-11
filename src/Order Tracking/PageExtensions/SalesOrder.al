pageextension 50701 "Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Shipping Advice")
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

