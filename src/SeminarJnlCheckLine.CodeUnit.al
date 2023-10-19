// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 2
//     - Created new codeunit

codeunit 50031 "Seminar Jnl.-Check Line"
{
    TableNo = 50031;

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        Text000: Label 'cannot be a closing date.';
        Text001: Label 'is not within your range of allowed posting dates.';

    internal procedure RunCheck(var SemJnlLine: Record "Seminar Journal Line")
    begin
        if SemJnlLine.EmptyLine() then
            exit;

        SemJnlLine.TestField("Posting Date");
        SemJnlLine.TestField("Instructor Resource No.");
        SemJnlLine.TestField("Seminar No.");

        case SemJnlLine."Charge Type" OF
            SemJnlLine."Charge Type"::Instructor:
                SemJnlLine.TestField("Instructor Resource No.");
            SemJnlLine."Charge Type"::Room:
                SemJnlLine.TestField("Room Resource No.");
            SemJnlLine."Charge Type"::Participant:
                SemJnlLine.TestField("Participant Contact No.");
        end;

        if SemJnlLine.Chargeable then
            SemJnlLine.TestField("Bill-to Customer No.");

        if SemJnlLine."Posting Date" = CLOSINGDATE(SemJnlLine."Posting Date") then
            SemJnlLine.FieldError("Posting Date", Text000);

        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if USERID <> '' then
                if UserSetup.Get(USERID) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;
            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                GLSetup.Get();
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            end;
            if AllowPostingTo = 0D then
                AllowPostingTo := 99991231D;
        end;
        if (SemJnlLine."Posting Date" < AllowPostingFrom) OR (SemJnlLine."Posting Date" > AllowPostingTo) then
            SemJnlLine.FieldError("Posting Date", Text001);

        if (SemJnlLine."Document Date" <> 0D) then
            if (SemJnlLine."Document Date" = CLOSINGDATE(SemJnlLine."Document Date")) then
                SemJnlLine.FieldError("Document Date", Text000);
    end;
}

