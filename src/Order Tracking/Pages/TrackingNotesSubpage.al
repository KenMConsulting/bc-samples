page 50702 "Tracking Notes Subpage"
{
    ApplicationArea = All;
    Caption = 'Tracking Notes Subpage';
    PageType = ListPart;
    SourceTable = "Tracking Notes";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Tracking Code"; Rec."Tracking Code")
                {
                    ToolTip = 'Specifies the value of the Tracking Code field.', Comment = '%';
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Editable = false;
                }
                field(Note; Rec.Note)
                {
                    ToolTip = 'Specifies the value of the Note field.', Comment = '%';
                }
            }
        }
    }
}
