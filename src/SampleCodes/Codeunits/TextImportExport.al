codeunit 50804 "Text Import/Export"
{
    //Sample Text Export for Cloud

    trigger OnRun()
    begin

    end;

    procedure CreateTextFile()
    var
        InStr: InStream;
        OutStr: OutStream;
        tempBlob: Codeunit "Temp Blob";
        FileName: Text;
        counter: Integer;

    begin
        FileName := 'TestFile.txt';
        tempBlob.CreateOutStream(OutStr, TextEncoding::Windows);

        for counter := 1 to 100 do begin
            outstr.WriteText(format(counter) + ': Ken Text Export Test....');
            outstr.WriteText(); //This acts as Carriage Return (New Line)
        end;

        tempBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure CreateTextFileTB() //TextBuilder
    var
        TBData: TextBuilder;
        OutStr: OutStream;
        tempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        FileName: Text;
        counter: Integer;

    begin
        FileName := 'TestFileTB.txt';
        tempBlob.CreateOutStream(OutStr, TextEncoding::Windows);

        for counter := 1 to 100 do begin
            TBData.AppendLine(format(counter) + ': Ken Text Export Test....');
        end;

        OutStr.WriteText(TBData.ToText());
        FileMgt.BLOBExport(tempBlob, FileName, true);

    end;
    /* ON PREM
    procedure ImportTextFile()
    var
        TextInStream: InStream;
        FileName: Text;
        LineText: Text;
    begin
        FileName := 'C:\Path\to\your\file.txt'; // Update with your file path

        IF NOT File.Exists(FileName) THEN
            ERROR('File not found');

        TextInStream.OPEN(FileName);

        WHILE NOT TextInStream.EOS DO BEGIN
            TextInStream.READTEXT(LineText);
            // Process each line of the text file as needed
            // For example, you can insert the data into a table or perform other operations
            MESSAGE(LineText); // Displaying the text as an example
        END;

        TextInStream.CLOSE;
    end;
    */
    /* Online */
    procedure ImportTextFile()
    var
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        InStream: InStream;
        LineText: Text;
        _FileName: Text;
    begin
        TempBlob.CreateInStream(Instream);
        _Filename := FileManagement.BLOBImport(TempBlob, _Filename);

        WHILE NOT InStream.EOS DO BEGIN
            InStream.READTEXT(LineText);
            // Process each line of the text file as needed
            // For example, you can insert the data into a table or perform other operations
            MESSAGE(LineText); // Displaying the text as an example
        END;
    end;
}

