// CSD1.00 - 2023-10-19 - B. During
// Chapter 4 - Lab 4
//     - Added code to copy Seminar and SEminar Registration from Journal to Ledger
// Chapter 5 - Lab 2
//     - Added code to include the Seminar Solution in the Navigate feature.

codeunit 50002 "Seminar Integration Code"
{
    // The following code extends the Posting Routine to copy the Seminar details from the Journal Line to the Ledger Entry
    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", OnAfterCopyFromResJnlLine, '', false, false)]
    local procedure CopySeminarResJournaltoLedger(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    begin
        ResLedgerEntry."Seminar No." := ResJournalLine."Seminar No.";
        ResLedgerEntry."Seminar Registration No." := ResJournalLine."Seminar Registration No.";
    end;

    // The following section extends the Navigate feature in BC to include the Seminar solution.
    // THis is to find the records
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure NavigateFindSeminarRecords(DocNoFilter: Text; ExtDocNo: Code[250]; HideDialog: Boolean; PostingDateFilter: Text; sender: Page Navigate;
    var DocumentEntry: Record "Document Entry" temporary; var NewSourceRecVar: Variant)
    var
        PostedSeminarRegHeader: Record "Posted Seminar Reg. Header";
        SeminarLedgEntry: Record "Seminar Ledger Entry";

    begin
        if PostedSeminarRegHeader.ReadPermission then begin
            PostedSeminarRegHeader.Reset();
            PostedSeminarRegHeader.SetFilter("No.", DocNoFilter);
            PostedSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
            sender.InsertIntoDocEntry(DATABASE::"Posted Seminar Reg. Header", PostedSeminarRegHeader.TableCaption, PostedSeminarRegHeader.Count());
        end;
        if SeminarLedgEntry.ReadPermission then begin
            SeminarLedgEntry.Reset();
            SeminarLedgEntry.SetCurrentKey("Document No.", "Posting Date");
            SeminarLedgEntry.SetFilter("Document No.", DocNoFilter);
            SeminarLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            sender.InsertIntoDocEntry(DATABASE::"Seminar Ledger Entry", SeminarLedgEntry.TableCaption, SeminarLedgEntry.Count());
        end;
    end;

    // This is to show the records
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', false, false)]
    local procedure OnAfterNavigateShowSeminarRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250])
    var
        PostedSeminarRegHeader: Record "Posted Seminar Reg. Header";
        SeminarLedgEntry: Record "Seminar Ledger Entry";

    begin
        case TableID of
            DATABASE::"Posted Seminar Reg. Header":
                PAGE.RUN(0, PostedSeminarRegHeader);
            DATABASE::"Seminar Ledger Entry":
                PAGE.RUN(0, SeminarLedgEntry);
        end;
    end;
}