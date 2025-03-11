page 50700 "Tracking Codes List"
{
    ApplicationArea = All;
    Caption = 'Tracking Codes List';
    PageType = List;
    SourceTable = "Tracking Codes";
    UsageCategory = Lists;
    CardPageId = "Tracking Codes Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
