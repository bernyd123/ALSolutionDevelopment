// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new table

table 50000 Seminar
{
    Caption = 'ð';
    LookupPageID = "Seminar Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.Get();
                    NoSeriesManagement.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
        }
        field(4; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(5; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(6; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(7; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(9; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Seminar),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Seminar Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Seminar Price';
        }
        field(11; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProductPostingGroup.ValidateVatProdPostingGroup(GenProductPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProductPostingGroup."Def. VAT Prod. Posting Group");
            end;
        }
        field(12; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesManagement.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", Rec."No. Series");
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        SeminarSetup: Record "Seminar Setup";
        CommentLine: Record "Comment Line";
        Seminar: Record Seminar;
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    procedure AssistEdit(): Boolean
    begin
        Seminar := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Nos.");
        if NoSeriesManagement.SelectSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", Seminar."No. Series") then begin
            NoSeriesManagement.SetSeries("No.");
            Rec := Seminar;
            exit(true);
        end;
    end;
}

