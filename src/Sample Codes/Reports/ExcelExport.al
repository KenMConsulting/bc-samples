report 50800 "Excel Export"
{
    ApplicationArea = All;
    Caption = 'Excel Export';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            begin
                ExcelBuf.DELETEALL;

                //Create Header 
                ExcelBuf.AddColumn('No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Credit Limit (LCY)', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn('Last Date Modified', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            end;

            trigger OnAfterGetRecord()
            begin
                ExcelBuf.NewRow;
                ExcelBuf.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Name, FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Credit Limit (LCY)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn("Last Date Modified", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
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
                    field(Option; Option)
                    {
                        Caption = 'Option';
                        ApplicationArea = Basic, Suite;
                        trigger OnValidate()
                        begin
                            UpdateRequestForm();
                        end;
                    }
                    field(FileName; ServerFileName)
                    {
                        Enabled = EnableUpdateFields;
                        Caption = 'Workbook File Name';
                        ApplicationArea = Basic, Suite;
                        trigger OnAssistEdit()
                        begin
                            ClientFileName := FileMgt.GetFileName(ServerFileName);
                        end;
                    }
                    field(SheetName; SheetName)
                    {
                        Enabled = EnableUpdateFields;
                        Caption = 'Worksheet Name';
                        ApplicationArea = Basic, Suite;
                        trigger OnAssistEdit()
                        begin

                        end;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            UpdateRequestForm();
        end;
    }

    trigger OnPostReport()
    begin
        ExcelBuf.CreateNewBook(Customer.TABLECAPTION);
        ExcelBuf.WriteSheet(Customer.TABLECAPTION, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();

        ExcelBuf.SetFriendlyFilename(Customer.TABLECAPTION + '_' + format(CurrentDateTime));
        ExcelBuf.OpenExcel();
    end;

    var
        ExcelBuf: record "Excel Buffer" temporary;
        ServerFileName: Text;
        ClientFileName: Text;
        SheetName: text[250];
        EnableUpdateFields: Boolean;
        Option: Option "Create Workbook","Update Workbook";
        FileMgt: Codeunit "File Management";

    local procedure UpdateRequestForm()
    begin
        if Option = Option::"Update Workbook" then begin
            EnableUpdateFields := true;
        end else begin
            EnableUpdateFields := false;
            ServerFileName := '';
            ClientFileName := '';
            SheetName := '';
        end;
    end;
}
