tableextension 50704 GenJnlLine extends "Gen. Journal Line"
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
