// CSD1.00 - 2023-10-19 - B. During
// Chapter 4 - Lab 4
//     - Added code to copy Seminar and SEminar Registration from Journal to Ledger

codeunit 50002 "Seminar Integration Code"
{
    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", OnAfterCopyFromResJnlLine, '', false, false)]
    local procedure CopySeminarResJournaltoLedger(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    begin
        ResLedgerEntry."Seminar No." := ResJournalLine."Seminar No.";
        ResLedgerEntry."Seminar Registration No." := ResJournalLine."Seminar Registration No.";
    end;
}