report 50801 "Excel Import"
{
    ApplicationArea = All;
    Caption = 'Excel Import';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = sorting(Number);
            MaxIteration = 1;

            trigger OnPreDataItem()
            begin
                if _Filename = '' then
                    ERROR('Select Workbook Name');

                if Sheetname = '' then
                    ERROR('Select Sheet Name');

                RowNo := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                CLEAR(TempExcelBuffer);
                TempExcelBuffer.SETFILTER("Row No.", '%1..', StartRow);
                if TempExcelBuffer.FIND('-') then
                    repeat
                        if RowNo <> TempExcelBuffer."Row No." then begin
                            if RowNo <> 0 then
                                ProcessImport(); //We process before clearing the variables

                            //Clear variables
                            ClearVariables();
                        end;
                        RowNo := TempExcelBuffer."Row No.";
                        case TempExcelBuffer."Column No." of
                            1:
                                if EVALUATE(CustNo, TempExcelBuffer."Cell Value as Text") then;
                            2:
                                if EVALUATE(CustName, TempExcelBuffer."Cell Value as Text") then;
                        end;
                    until TempExcelBuffer.Next() = 0;

                ProcessImport();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    group(ExcelOptions)
                    {
                        caption = 'Excel Options';
                        field(FileName; _Filename)
                        {
                            Caption = 'Filename';
                            ToolTip = 'Select Filename';
                            ApplicationArea = Basic, Suite;

                            trigger OnAssistEdit()
                            begin
                                RequestFile();
                            end;
                        }
                        field(Worksheet; Sheetname)
                        {
                            Caption = 'Sheet Name';
                            ToolTip = 'Select Sheet Name';
                            ApplicationArea = Basic, Suite;
                            Editable = false; //Sheet should be selected when selecting file name
                        }
                        field("Starting Row"; Startrow)
                        {
                            Caption = 'Starting Row';
                            ToolTip = 'Enter Starting Row';
                            ApplicationArea = Basic, Suite;
                        }
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            StartRow := 2;
        end;
    }

    trigger OnPostReport()
    begin
        message('Import Complete!!');
    end;

    var
        _Filename: text;
        TempExcelBuffer: record "Excel Buffer" temporary;
        Sheetname: text;
        StartRow: Integer;
        RowNo: Integer;

        //----------Import Variables ---------
        CustNo: code[20];
        CustName: text[80];

    local procedure ProcessImport()
    var
        Cust: Record customer;
    begin
        cust.validate("No.", CustNo);
        cust.validate(name, CustName);
        if not cust.insert(true) then
            cust.modify(true);
    end;

    local procedure ClearVariables()
    begin
        clear(CustNo);
        clear(CustName);
    end;

    procedure RequestFile()
    var
        FileInstream: InStream;
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
    begin
        TempExcelBuffer.DeleteAll();

        TempBlob.CreateInStream(FileInstream);
        _Filename := FileManagement.BLOBImport(TempBlob, _Filename);
        Sheetname := TempExcelBuffer.SelectSheetsNameStream(FileInstream);

        TempExcelBuffer.OpenBookStream(FileInstream, Sheetname);
        TempExcelBuffer.ReadSheet();
    end;
}
