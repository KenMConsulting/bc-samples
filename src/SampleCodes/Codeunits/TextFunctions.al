codeunit 50803 ParseText
{
    procedure ParseFileName(FileName: Text[250]; var TableID: Integer; var No: Code[20]; var LineNo: Integer; var recID: Integer; var recFName: text)
    var
        FileParts: List of [Text];
        Part: Text;
        Index: Integer;
    begin
        //Sample Text Creation
        //FileName := FORMAT(DocAttachment."Table ID") +'~'+ DocAttachment."No."  +'~'+ FORMAT(DocAttachment."Line No.")  +'~'+ FORMAT(DocAttachment.ID)  +'~' + DocAttachment."File Name" + '.' + DocAttachment."File Extension"; // Use the file name from the record

        //Actual Text
        //114~SCR-3823~0~29~KenM Consulting LLC - Credit Memo SO-72420 Sample Invoicee 80535.pdf
        // Split the file name into parts using "~" as a delimiter
        FileParts := FileName.Split('~');
        // Loop through the result and display each split part
        Index := 1;
        foreach Part in FileParts do begin
            case Index of
                1:
                    TableID := StrToInt(Part);
                2:
                    No := Part;
                3:
                    LineNo := StrToInt(Part);
                4:
                    recID := StrToInt(Part);
                5:
                    recFName := Part;
            end;
            Index += 1;
        end;
    end;

    procedure StrToInt(InputText: Text): Integer
    var
        ResultInt: Integer;
        Success: Boolean;
    begin
        // Try to convert the text to an integer
        Success := Evaluate(ResultInt, InputText);
        if not Success then
            exit(0);

        exit(ResultInt);
    end;

    procedure useBigText()
    var
        extendedTextLine: record "Extended Text Line";
        extText: BigText;
        TempText: Text[250];
    begin
        clear(extText);
        extendedTextLine.reset;
        extendedTextLine.SetRange("Table Name", extendedTextLine."Table Name"::Item);
        extendedTextLine.SetRange("No.", 'KEN ITEM');
        if extendedTextLine.find('-') then
            repeat
                TempText := extendedTextLine.Text;
                extText.AddText(TempText + '\'); // Add a newline after each comment
            until extendedTextLine.next = 0;
    end;
}
