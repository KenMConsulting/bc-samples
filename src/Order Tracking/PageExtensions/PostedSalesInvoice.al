pageextension 50702 "Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Package Tracking No.")
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
