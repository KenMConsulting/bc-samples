codeunit 50802 "E-mail"
{
    //Based of --> https://businesscentralgeek.com/5-ways-to-send-an-email-in-business-central
    trigger OnRun()
    begin

    end;

    procedure SendEasiestEMail()
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create('', 'This is the subject', 'This is the body');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithAttachment()
    var
        ReportExample: Report "Standard Sales - Invoice";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
    begin
        ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Standard Sales - Invoice", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        //Sample Body Creation
        Body := 'Blah Blah Blah' +
                'Blah Blah Blah' +
                'Blah Blah Blah';
        //

        EmailMessage.Create('To Email Address', 'This is the subject', 'This is the body');
        EmailMessage.AddAttachment('FileName.pdf', 'PDF', InStr);
        //CC & BCC
        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, 'CC Email Address');
        EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'BCC Email Address');
        //
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        /*
        OR
        EmailSentSuccesfully := Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        */
    end;

    procedure SendEmailWithPreviewWindow()
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create('your email goes here', 'This is the subject', 'This is the body');
        Email.OpenInEditor(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEmailWithPreviewWindowHtmlFormatBody()
    var
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
    begin
        Customer.FindFirst();
        Customer.CalcFields(Balance);
        Body := '<h3>TO MESSRS: ' + Customer.Name + '</h3>ATT : ACCOUNTING DEPARTMENT </br> </h3> <hr></br>Your current balance with us is:</br></br><strong>' + format(Customer.Balance) + '</strong></br></br><hr></br>Best regards,</br></br>Financial Department</br></br>Spain</br> <img src="https://businesscentralgeek.com/wp-content/uploads/2022/06/Imagen3.jpg" />';

        EmailMessage.Create('your email goes here', 'This is the subject', Body, true);
        Email.OpenInEditorModally(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure SendEMail()
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Cancelled: Boolean;
        MailSent: Boolean;
        Selection: Integer;
        OptionsLbl: Label 'Send,Open Preview';
        ListTo: List of [Text];
    begin
        Selection := Dialog.StrMenu(OptionsLbl);
        ListTo.Add('your email goes here');
        EmailMessage.Create(ListTo, 'This is the subject', 'This is the body', true);
        Cancelled := false;
        if Selection = 1 then
            MailSent := Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        if Selection = 2 then begin

            MailSent := Email.OpenInEditorModally(
                EmailMessage, Enum::"Email Scenario"::Default) = Enum::"Email Action"::Sent;
            Cancelled := not MailSent;
        end;

        if (Selection <> 0) and not MailSent and not Cancelled then
            Error(GetLastErrorText());
    end;

    //Send E-Mail when PO is released
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnAfterReleasePurchaseDoc, '', false, false)]
    local procedure "Release Purchase Document_OnAfterReleasePurchaseDoc"(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    var
        Vendor: record Vendor;
        DocumentSendingProfile: Record "Document Sending Profile";
        ReportSelections: Record "Report Selections";
        PHeader: record "Purchase Header";
    begin
        if not vendor.get(PurchaseHeader."Buy-from Vendor No.") then
            exit;

        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then
            exit;

        /*if not vendor."Auto Email Purchase Orders" then
            exit;*/

        PHeader.Reset();
        PHeader.SetRange("Document Type", PurchaseHeader."Document Type");
        PHeader.SetRange("No.", PurchaseHeader."No.");
        PHeader.FindFirst();

        //Send E-Mail
        ReportSelections.Usage := ReportSelections.Usage::"P.Order";

        DocumentSendingProfile.Code := 'CUSTOM';
        DocumentSendingProfile.Printer := DocumentSendingProfile.Printer::No;
        DocumentSendingProfile."E-Mail" := DocumentSendingProfile."E-Mail"::"Yes (Use Default Settings)";
        DocumentSendingProfile."E-Mail Attachment" := DocumentSendingProfile."E-Mail Attachment"::PDF;

        DocumentSendingProfile.SendVendor(ReportSelections.Usage.AsInteger(), PHeader, PHeader."No.", PHeader."Buy-from Vendor No.", 'Purchase Order', PHeader.FIELDNO("Buy-from Vendor No."), PHeader.FIELDNO("No."));
    end;
}
