// CSD1.00 - 2023-10-19 - B. During
//   Chapter 4 - Lab 5
//     - Created new codeunit

codeunit 50003 "Seminar-Post"
{
    TableNo = "Seminar Registration Header";

    trigger OnRun()
    begin
        ClearAll();
        SeminarRegHeader := Rec;
        SeminarRegHeader.TESTFIELD("Posting Date");
        SeminarRegHeader.TESTFIELD("Document Date");
        SeminarRegHeader.TESTFIELD("Seminar No.");
        SeminarRegHeader.TESTFIELD(Duration);
        SeminarRegHeader.TESTFIELD("Instructor Resource No.");
        SeminarRegHeader.TESTFIELD("Room Resource No.");
        SeminarRegHeader.TESTFIELD(Status, SeminarRegHeader.Status::Closed);

        SeminarRegLine.RESET();
        SeminarRegLine.SETRANGE("Document No.", SeminarRegHeader."No.");
        IF SeminarRegLine.ISEMPTY THEN
            ERROR(Text001);

        Window.OPEN(
            '#1#################################\\' +
            Text002);
        Window.UPDATE(1, STRSUBSTNO('%1 %2', Text003, SeminarRegHeader."No."));

        IF SeminarRegHeader."Posting No." = '' THEN BEGIN
            SeminarRegHeader.TESTFIELD("Posting No. Series");
            SeminarRegHeader."Posting No." := NoSeriesMgt.GetNextNo(SeminarRegHeader."Posting No. Series", SeminarRegHeader."Posting Date", TRUE);
            SeminarRegHeader.MODIFY();
            COMMIT();
        END;
        SeminarRegLine.LOCKTABLE();

        SourceCodeSetup.GET();
        SourceCode := SourceCodeSetup.Seminar;

        PstdSeminarRegHeader.INIT();
        PstdSeminarRegHeader.TRANSFERFIELDS(SeminarRegHeader);
        PstdSeminarRegHeader."No." := SeminarRegHeader."Posting No.";
        PstdSeminarRegHeader."No. Series" := SeminarRegHeader."Posting No. Series";
        PstdSeminarRegHeader."Source Code" := SourceCode;
        PstdSeminarRegHeader."User ID" := CopyStr(USERID, 1, MaxStrLen(PstdSeminarRegHeader."User ID"));
        PstdSeminarRegHeader.INSERT();

        Window.UPDATE(1, STRSUBSTNO(Text004, SeminarRegHeader."No.",
            PstdSeminarRegHeader."No."));

        CopyCommentLines(
            SeminarCommentLine."Document Type"::"Seminar Registration",
            SeminarCommentLine."Document Type"::"Posted Seminar Registration",
            SeminarRegHeader."No.", PstdSeminarRegHeader."No.");
        CopyCharges(SeminarRegHeader."No.", PstdSeminarRegHeader."No.");

        LineCount := 0;
        SeminarRegLine.RESET();
        SeminarRegLine.SETRANGE("Document No.", SeminarRegHeader."No.");
        IF SeminarRegLine.FINDSET() THEN
            REPEAT
                LineCount := LineCount + 1;
                Window.UPDATE(2, LineCount);

                SeminarRegLine.TESTFIELD("Bill-to Customer No.");
                SeminarRegLine.TESTFIELD("Participant Contact No.");

                IF NOT SeminarRegLine."To Invoice" THEN BEGIN
                    SeminarRegLine."Seminar Price" := 0;
                    SeminarRegLine."Line Discount %" := 0;
                    SeminarRegLine."Line Discount Amount" := 0;
                    SeminarRegLine.Amount := 0;
                END;

                // Post seminar entry
                PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Participant);

                // Insert posted seminar registration line
                PstdSeminarRegLine.INIT();
                PstdSeminarRegLine.TRANSFERFIELDS(SeminarRegLine);
                PstdSeminarRegLine."Document No." := PstdSeminarRegHeader."No.";
                PstdSeminarRegLine.INSERT();
            UNTIL SeminarRegLine.NEXT() = 0;

        // Post charges to seminar ledger
        PostCharges();

        // Post instructor to seminar ledger
        PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Instructor);

        // Post seminar room to seminar ledger
        PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Room);

        SeminarRegHeader.DELETE();
        SeminarRegLine.DELETEALL();

        SeminarCommentLine.SETRANGE("Document Type",
            SeminarCommentLine."Document Type"::"Seminar Registration");
        SeminarCommentLine.SETRANGE("No.", SeminarRegHeader."No.");
        SeminarCommentLine.DELETEALL();

        SeminarCharge.SETRANGE(Description);
        SeminarCharge.DELETEALL();
        Rec := SeminarRegHeader;
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Posted Seminar Reg. Line";
        PstdSeminarRegHeader: Record "Posted Seminar Reg. Header";
        PstdSeminarRegLine: Record "Posted Seminar Reg. Line";
        SeminarCommentLine: Record "Seminar Comment Line";
        SeminarCommentLine2: Record "Seminar Comment Line";
        SeminarCharge: Record "Seminar Charge";
        PstdSeminarCharge: Record "Posted Seminar Charge";
        Room: Record Resource;
        Instructor: Record Resource;
        Customer: Record Customer;
        ResLedgEntry: Record "Res. Ledger Entry";
        SeminarJnlLine: Record "Seminar Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ResJnlLine: Record "Res. Journal Line";
        SeminarJnlPostLine: Codeunit "Seminar Jnl.-Post Line";
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        SourceCode: Code[10];
        LineCount: Integer;
        Text001: Label 'There is no participant to post.';
        Text002: Label 'Posting lines              #2######\';
        Text003: Label 'Registration';
        Text004: Label 'Registration %1  -> Posted Reg. %2';
        Text005: Label 'The combination of dimensions used in %1 is blocked. %2';
        Text006: Label 'The combination of dimensions used in %1,  line no. %2 is blocked. %3';
        Text007: Label 'The dimensions used in %1 are invalid. %2';
        Text008: Label 'The dimensions used in %1, line no. %2 are invalid. %3';

    local procedure CopyCommentLines(FromDocumentType: Enum "Seminar Document Type"; ToDocumentType: Enum "Seminar Document Type"; FromNumber: Code[20]; ToNumber: Code[20])
    begin
        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Document Type", FromDocumentType);
        SeminarCommentLine.SetRange("No.", FromNumber);
        if SeminarCommentLine.FindSet(false) then
            repeat
                SeminarCommentLine2 := SeminarCommentLine;
                SeminarCommentLine2."Document Type" := ToDocumentType;
                SeminarCommentLine2."No." := ToNumber;
                SeminarCommentLine2.Insert();
            until SeminarCommentLine.Next() = 0;
    end;

    local procedure CopyCharges(FromNumber: Code[20]; ToNumber: Code[20])
    begin
        SeminarCharge.RESET();
        SeminarCharge.SETRANGE("Document No.", FromNumber);
        if SeminarCharge.FINDSET(FALSE) then
            repeat
                PstdSeminarCharge.TRANSFERFIELDS(SeminarCharge);
                PstdSeminarCharge."Document No." := ToNumber;
                PstdSeminarCharge.INSERT();
            until SeminarCharge.NEXT() = 0;
    end;

    local procedure PostResJnlLine(Resource: Record 156): Integer
    begin
        Resource.TESTFIELD("Quantity Per Day");
        ResJnlLine.INIT();
        ResJnlLine."Entry Type" := ResJnlLine."Entry Type"::Usage;
        ResJnlLine."Document No." := PstdSeminarRegHeader."No.";
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        ResJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        ResJnlLine.Description := SeminarRegHeader."Seminar Name";
        ResJnlLine."Gen. Prod. Posting Group" := SeminarRegHeader."Gen. Prod. Posting Group";
        ResJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        ResJnlLine."Source Code" := SourceCode;
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Unit of Measure Code" := Resource."Base Unit of Measure";
        ResJnlLine."Unit Cost" := Resource."Unit Cost";
        ResJnlLine."Qty. per Unit of Measure" := 1;
        ResJnlLine.Quantity := SeminarRegHeader.Duration * Resource."Quantity Per Day";
        ResJnlLine."Total Cost" := ResJnlLine."Unit Cost" * ResJnlLine.Quantity;
        ResJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        ResJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        ResJnlPostLine.RunWithCheck(ResJnlLine);

        ResLedgEntry.FINDLAST();
        EXIT(ResLedgEntry."Entry No.");
    end;

    local procedure PostSeminarJnlLine(ChargeType: Enum "Seminar Journal Line Type")
    begin
        SeminarJnlLine.INIT();
        SeminarJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        SeminarJnlLine."Document Date" := SeminarRegHeader."Document Date";
        SeminarJnlLine."Document No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Charge Type" := ChargeType;
        SeminarJnlLine."Instructor Resource No." := SeminarRegHeader."Instructor Resource No.";
        SeminarJnlLine."Starting Date" := SeminarRegHeader."Starting Date";
        SeminarJnlLine."Seminar Registration No." := PstdSeminarRegHeader."No.";
        SeminarJnlLine."Room Resource No." := SeminarRegHeader."Room Resource No.";
        SeminarJnlLine."Source Type" := SeminarJnlLine."Source Type"::Seminar;
        SeminarJnlLine."Source No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Source Code" := SourceCode;
        SeminarJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        SeminarJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        CASE ChargeType OF
            ChargeType::Instructor:
                BEGIN
                    Instructor.GET(SeminarRegHeader."Instructor Resource No.");
                    SeminarJnlLine.Description := Instructor.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := FALSE;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    SeminarJnlLine."Res. Ledger Entry No." := PostResJnlLine(Instructor);
                END;
            ChargeType::Room:
                BEGIN
                    Room.GET(SeminarRegHeader."Room Resource No.");
                    SeminarJnlLine.Description := Room.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := FALSE;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    // Post to resource ledger
                    SeminarJnlLine."Res. Ledger Entry No." := PostResJnlLine(Room);
                END;
            ChargeType::Participant:
                BEGIN
                    SeminarJnlLine."Bill-to Customer No." := SeminarRegLine."Bill-to Customer No.";
                    SeminarJnlLine."Participant Contact No." := SeminarRegLine."Participant Contact No.";
                    SeminarJnlLine."Participant Name" := SeminarRegLine."Participant Name";
                    SeminarJnlLine.Description := SeminarRegLine."Participant Name";
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := SeminarRegLine."To Invoice";
                    SeminarJnlLine.Quantity := 1;
                    SeminarJnlLine."Unit Price" := SeminarRegLine.Amount;
                    SeminarJnlLine."Total Price" := SeminarRegLine.Amount;
                END;
            ChargeType::Charge:
                BEGIN
                    SeminarJnlLine.Description := SeminarCharge.Description;
                    SeminarJnlLine."Bill-to Customer No." := SeminarCharge."Bill-to Customer No.";
                    SeminarJnlLine.Type := SeminarCharge.Type;
                    SeminarJnlLine.Quantity := SeminarCharge.Quantity;
                    SeminarJnlLine."Unit Price" := SeminarCharge."Unit Price";
                    SeminarJnlLine."Total Price" := SeminarCharge."Total Price";
                    SeminarJnlLine.Chargeable := SeminarCharge."To Invoice";
                END;
        END;

        SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);
    end;

    local procedure PostCharges()
    begin
        SeminarCharge.RESET();
        SeminarCharge.SETRANGE("Document No.", SeminarRegHeader."No.");
        IF SeminarCharge.FINDSET(FALSE) THEN
            repeat
                PostSeminarJnlLine(SeminarJnlLine."Charge Type"::Charge); // Charge
            until SeminarCharge.Next() = 0;
    end;
}

