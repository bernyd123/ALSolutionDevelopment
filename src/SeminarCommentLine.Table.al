// CSD1.00 - 2023-10-17 - B. During
//   Chapter 3 - Lab 1
//     - Created new table

table 50004 "Seminar Comment Line"
{
    Caption = 'Seminar Comment Line';
    DrillDownPageID = "Seminar Comment List";
    LookupPageID = "Seminar Comment List";

    fields
    {
        field(1; "Document Type"; Enum "Seminar Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    internal procedure SetUpNewLine()
    var
        SeminarCommentLine: Record "Sales Comment Line";
    begin
        SeminarCommentLine.SETRANGE("Document Type", "Document Type");
        SeminarCommentLine.SETRANGE("No.", "No.");
        SeminarCommentLine.SETRANGE("Document Line No.", "Document Line No.");
        SeminarCommentLine.SETRANGE(Date, WORKDATE());
        if NOT SeminarCommentLine.IsEmpty() then
            Date := WORKDATE();
    end;
}

