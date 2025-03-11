page 50701 "Tracking Codes Card"
{
    ApplicationArea = All;
    Caption = 'Tracking Codes Card';
    PageType = Card;
    SourceTable = "Tracking Codes";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
            part(TrackingNotes; "Tracking Notes Subpage")
            {
                Caption = 'Notes';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Tracking Code" = field(code);
            }
        }
    }
}
