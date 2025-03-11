pageextension 50700 "Customer Card" extends "Customer Card"
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
