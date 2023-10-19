// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 2
//     - Created new codeunit

codeunit 50034 "Seminar Reg.-Show Ledger"
{
    TableNo = "Seminar Register";

    trigger OnRun()
    begin
        SeminarLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        Page.Run(Page::"Seminar Ledger Entries", SeminarLedgerEntry);
    end;

    var
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
}

