table 50701 "Tracking Notes"
{
    Caption = 'Tracking Notes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tracking Code"; Code[20])
        {
            Caption = 'Tracking Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Note; Text[250])
        {
            Caption = 'Note';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Tracking Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
