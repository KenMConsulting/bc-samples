tableextension 50703 CustLedgerEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(50700; "Tracking Code"; Code[20])
        {
            Caption = 'Tracking Code';
            DataClassification = CustomerContent;
            TableRelation = "Tracking Codes";
        }
        field(50701; "Priority Level"; Enum "Tracking Priority Levels")
        {
            Caption = 'Priority Level';
            DataClassification = CustomerContent;
        }
    }
}
