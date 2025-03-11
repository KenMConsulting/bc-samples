page 50800 WriteContentToFile
{
    Caption = 'Write content to existing file - Demo';
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("You Text Content"; TextContent)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("New File Name"; gFileName)
                {
                    ApplicationArea = All;
                }
                field("Select File"; selectFile)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        InStr: InStream;
                        FileName: Text;
                        NumberOfBytesRead: Integer;
                        TextRead: Text;
                        OutStr: OutStream;
                        tempBlob: Codeunit "Temp Blob";
                    begin
                        //'Excel Files (*.xlsx)|*.xlsx'
                        if (File.UploadIntoStream('Open File', '', 'All Files (*.*)|*.*',
                                                 FileName, InStr)) then begin
                            InStr.Read(TextRead);
                            Message('Previos file content: \' + TextRead);
                            TextRead := DelStr(TextRead, strpos(TextRead, '999999'));
                            TempBlob.CreateOutStream(OutStr);
                            OutStr.WriteText(TextRead);
                            OutStr.WriteText(' new text');
                            TempBlob.CreateInStream(InStr);
                            TextRead += ' --------- Your Content ---------- ' + TextContent;
                            InStr.Read(TextRead);
                            Message('New File content: ' + TextRead);
                            DownloadFromStream(InStr, '', '', '', gFileName); // Filename is browser download folder
                        end;
                    end;
                }
            }
        }
    }

    var
        selectFile: Text; // File to Read
        TextContent: Text; // Content to write in file
        gFileName: Text; // New Filename to download file

}
