// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 2
//     - Created new codeunit

codeunit 50032 "Seminar Jnl.-Post Line"
{
    TableNo = 50031;

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    var
        SeminarJnlLine: Record "Seminar Journal Line";
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
        SeminarRegister: Record "Seminar Register";
        SeminarJnlCheckLine: Codeunit "Seminar Jnl.-Check Line";
        NextEntryNo: Integer;

    internal procedure RunWithCheck(var SeminarJnlLine2: Record "Seminar Journal Line")
    begin
        SeminarJnlLine.COPY(SeminarJnlLine2);
        Code();
        SeminarJnlLine2 := SeminarJnlLine;
    end;

    internal procedure "Code"()
    begin
        if SeminarJnlLine.EmptyLine() then
            exit;

        SeminarJnlCheckLine.RunCheck(SeminarJnlLine);

        if NextEntryNo = 0 then begin
            SeminarLedgerEntry.LockTable();
            ;
            if SeminarLedgerEntry.FindLast() then
                NextEntryNo := SeminarLedgerEntry."Entry No.";
            NextEntryNo := NextEntryNo + 1;
        end;

        if SeminarJnlLine."Document Date" = 0D then
            SeminarJnlLine."Document Date" := SeminarJnlLine."Posting Date";

        if SeminarRegister."No." = 0 then begin
            SeminarRegister.LockTable();
            ;
            if (NOT SeminarRegister.FindLast()) OR (SeminarRegister."To Entry No." <> 0) then begin
                SeminarRegister.Init();
                SeminarRegister."No." := SeminarRegister."No." + 1;
                SeminarRegister."From Entry No." := NextEntryNo;
                SeminarRegister."To Entry No." := NextEntryNo;
                SeminarRegister."Creation Date" := TODAY;
                SeminarRegister."Source Code" := SeminarJnlLine."Source Code";
                SeminarRegister."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
                SeminarRegister."User ID" := CopyStr(USERID, 1, MaxStrLen(SeminarRegister."User ID"));
                SeminarRegister.Insert();
            end;
        end;
        SeminarRegister."To Entry No." := NextEntryNo;
        SeminarRegister.Modify();

        SeminarLedgerEntry.Init();
        ;
        SeminarLedgerEntry."Seminar No." := SeminarJnlLine."Seminar No.";
        SeminarLedgerEntry."Posting Date" := SeminarJnlLine."Posting Date";
        SeminarLedgerEntry."Document Date" := SeminarJnlLine."Document Date";
        SeminarLedgerEntry."Entry Type" := SeminarJnlLine."Entry Type";
        SeminarLedgerEntry."Document No." := SeminarJnlLine."Document No.";
        SeminarLedgerEntry.Description := SeminarJnlLine.Description;
        SeminarLedgerEntry."Bill-to Customer No." := SeminarJnlLine."Bill-to Customer No.";
        SeminarLedgerEntry."Charge Type" := SeminarJnlLine."Charge Type";
        SeminarLedgerEntry.Type := SeminarJnlLine.Type;
        SeminarLedgerEntry.Quantity := SeminarJnlLine.Quantity;
        SeminarLedgerEntry."Unit Price" := SeminarJnlLine."Unit Price";
        SeminarLedgerEntry."Total Price" := SeminarJnlLine."Total Price";
        SeminarLedgerEntry."Participant Contact No." := SeminarJnlLine."Participant Contact No.";
        SeminarLedgerEntry."Participant Name" := SeminarJnlLine."Participant Name";
        SeminarLedgerEntry.Chargeable := SeminarJnlLine.Chargeable;
        SeminarLedgerEntry."Room Resource No." := SeminarJnlLine."Room Resource No.";
        SeminarLedgerEntry."Instructor Resource No." := SeminarJnlLine."Instructor Resource No.";
        SeminarLedgerEntry."Starting Date" := SeminarJnlLine."Starting Date";
        SeminarLedgerEntry."Seminar Registration No." := SeminarJnlLine."Seminar Registration No.";
        SeminarLedgerEntry."Res. Ledger Entry No." := SeminarJnlLine."Res. Ledger Entry No.";
        SeminarLedgerEntry."Source Type" := SeminarJnlLine."Source Type";
        SeminarLedgerEntry."Source No." := SeminarJnlLine."Source No.";
        SeminarLedgerEntry."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
        SeminarLedgerEntry."Source Code" := SeminarJnlLine."Source Code";
        SeminarLedgerEntry."Reason Code" := SeminarJnlLine."Reason Code";
        //TOFIX
        //SeminarLedgerEntry."No. Series" := SeminarJnlLine."Posting No. Series";
        SeminarLedgerEntry."User ID" := CopyStr(USERID, 1, MaxStrLen(SeminarRegister."User ID"));
        SeminarLedgerEntry."Entry No." := NextEntryNo;
        SeminarLedgerEntry.Insert();

        NextEntryNo := NextEntryNo + 1;
    end;
}

