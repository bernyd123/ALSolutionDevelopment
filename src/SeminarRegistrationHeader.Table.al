// CSD1.00 - 2023-10-17 - B. During
//   Chapter 3 - Lab 1
//     - Created new table
//   Completed the lab exercises for Lab 3A
//     - Changed Instructor Code to Instructor Resource No.
//     - Changed Room Code to Room Resource No.
//     - Added code to OnDelete to check if seminar is Registered and block Deletion if it is.
//     - Create InitRecord Procedure and move code to InitRecord 
//   Chapter 5 - Lab 1
//     - Added code to the OnInsert trigger to apply the record link filter

table 50010 "Seminar Registration Header"
{
    Caption = 'Seminar Registration Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.Get();
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Registration Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = Seminar;

            trigger OnValidate()
            begin
                if "Seminar No." <> xRec."Seminar No." then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.SetRange(Registered, TRUE);
                    if NOT SeminarRegLine.ISEMPTY then
                        ERROR(
                          Text002,
                          FieldCaption("Seminar No."),
                          SeminarRegLine.TABLECAPTION,
                          SeminarRegLine.FieldCaption(Registered),
                          TRUE);

                    Seminar.Get("Seminar No.");
                    Seminar.TestField(Blocked, FALSE);
                    Seminar.TestField("Gen. Prod. Posting Group");
                    Seminar.TestField("VAT Prod. Posting Group");
                    "Seminar Name" := Seminar.Name;
                    Duration := Seminar."Seminar Duration";
                    "Seminar Price" := Seminar."Seminar Price";
                    "Gen. Prod. Posting Group" := Seminar."Gen. Prod. Posting Group";
                    "VAT Prod. Posting Group" := Seminar."VAT Prod. Posting Group";
                    "Minimum Participants" := Seminar."Minimum Participants";
                    "Maximum Participants" := Seminar."Maximum Participants";
                end;
            end;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
        }
        field(5; "Instructor Resource No."; Code[10])
        {
            Caption = 'Instructor Resource No.';
            TableRelation = Resource Where(Type = Const(Person));

            trigger OnValidate()
            begin
                rec.CalcFields("Instructor Name");
            end;
        }
        field(6; "Instructor Name"; Text[100])
        {
            CalcFormula = Lookup(Resource.Name Where("No." = Field("Instructor Resource No."), Type = Const(Person)));
            Caption = 'Instructor Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Status; Enum "Seminar Status")
        {
            Caption = 'Status';
        }
        field(8; Duration; Decimal)
        {
            Caption = 'Duration';
            DecimalPlaces = 0 : 1;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(11; "Room Resource No."; Code[10])
        {
            Caption = 'Room Resource No.';
            TableRelation = Resource Where(Type = Const(Machine));

            trigger OnValidate()
            begin
                if "Room Resource No." = '' then begin
                    "Room Name" := '';
                    "Room Address" := '';
                    "Room Address 2" := '';
                    "Room Post Code" := '';
                    "Room City" := '';
                    "Room County" := '';
                    "Room Country/Reg. Code" := '';
                end else begin
                    SeminarRoom.Get("Room Resource No.");
                    "Room Name" := SeminarRoom.Name;
                    "Room Address" := SeminarRoom.Address;
                    "Room Address 2" := SeminarRoom."Address 2";
                    "Room Post Code" := SeminarRoom."Post Code";
                    "Room City" := SeminarRoom.City;
                    "Room County" := SeminarRoom.County;
                    "Room Country/Reg. Code" := SeminarRoom."Country/Region Code";

                    if (CurrFieldNo <> 0) then
                        if (SeminarRoom."Maximum Participants" <> 0) AND
                           (SeminarRoom."Maximum Participants" < "Maximum Participants")
                        then
                            if CONFIRM(Text004, TRUE,
                                 "Maximum Participants",
                                 SeminarRoom."Maximum Participants",
                                 FieldCaption("Maximum Participants"),
                                 "Maximum Participants",
                                 SeminarRoom."Maximum Participants")
                            then
                                "Maximum Participants" := SeminarRoom."Maximum Participants";
                end;
            end;
        }
        field(12; "Room Name"; Text[100])
        {
            Caption = 'Room Name';
        }
        field(13; "Room Address"; Text[100])
        {
            Caption = 'Room Address';
        }
        field(14; "Room Address 2"; Text[100])
        {
            Caption = 'Room Address 2';
        }
        field(15; "Room Post Code"; Code[20])
        {
            Caption = 'Room Post Code';
            TableRelation = "Post Code".Code;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(16; "Room City"; Text[30])
        {
            Caption = 'Room City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(17; "Room Country/Reg. Code"; Code[10])
        {
            Caption = 'Room Country/Reg. Code';
            TableRelation = "Country/Region";
        }
        field(18; "Room County"; Text[30])
        {
            Caption = 'Room County';
        }
        field(19; "Seminar Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Seminar Price';

            trigger OnValidate()
            begin
                if ("Seminar Price" <> xRec."Seminar Price") AND
                   (Status <> Status::Canceled)
                then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.SetRange(Registered, FALSE);
                    if SeminarRegLine.FindSet() then
                        if CONFIRM(Text005, FALSE,
                             FieldCaption("Seminar Price"),
                             SeminarRegLine.TABLECAPTION)
                        then begin
                            repeat
                                SeminarRegLine.VALIDATE("Seminar Price", "Seminar Price");
                                SeminarRegLine.Modify();
                            until SeminarRegLine.Next() = 0;
                            Modify();
                        end;
                end;
            end;
        }
        field(20; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(21; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(22; Comment; Boolean)
        {
            CalcFormula = Exist("Seminar Comment Line" Where("Document Type" = Const("Seminar Registration"), "No." = Field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(24; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(25; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code".Code;
        }
        field(26; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(27; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                SeminarRegHeader := Rec;
                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                if NoSeriesMgt.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", SeminarRegHeader."Posting No. Series")
                then
                    VALIDATE("Posting No. Series");
                Rec := SeminarRegHeader;
            end;

            trigger OnValidate()
            begin
                if "Posting No. Series" <> '' then begin
                    SeminarSetup.Get();
                    SeminarSetup.TestField("Seminar Registration Nos.");
                    SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                    NoSeriesMgt.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
                end;
                TestField("Posting No.", '');
            end;
        }
        field(28; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Room Resource No.")
        {
            SumIndexFields = Duration;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Status, Status::Canceled);

        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Document No.", "No.");
        SeminarRegLine.SetRange(Registered, TRUE);
        if SeminarRegLine.FIND('-') then
            ERROR(
              Text001,
              SeminarRegLine.TABLECAPTION,
              SeminarRegLine.FieldCaption(Registered),
              TRUE);
        SeminarRegLine.SetRange(Registered);
        SeminarRegLine.DeleteAll(TRUE);

        SeminarCharge.Reset();
        SeminarCharge.SetRange("Document No.", "No.");
        if NOT SeminarCharge.ISEMPTY then
            ERROR(Text006, SeminarCharge.TABLECAPTION);

        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Document Type", SeminarCommentLine."Document Type"::"Seminar Registration");
        SeminarCommentLine.SetRange("No.", "No.");
        SeminarCommentLine.DeleteAll();
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        InitRecord();

        if GetFilter("Seminar No.") <> '' then
            if GetRangeMin("Seminar No.") = GetRangeMax("Seminar No.") then
                Validate("Seminar No.", GetRangeMin("Seminar No."));
    end;

    var
        PostCode: Record "Post Code";
        Seminar: Record Seminar;
        SeminarCommentLine: Record "Seminar Comment Line";
        SeminarCharge: Record "Seminar Charge";
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Seminar Registration Line";
        SeminarRoom: Record Resource;
        SeminarSetup: Record "Seminar Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: Label 'You cannot delete the Seminar Registration, because there is at least one %1 where %2=%3.', comment = '%1 is the customer name %2 another value %3 the laste value.';
        Text002: Label 'You cannot change the %1, because there is at least one %2 with %3=%4.';
        Text004: Label 'This Seminar is for %1 participants. \The selected Room has a maximum of %2 participants \Do you want to change %3 for the Seminar from %4 to %5?';
        Text005: Label 'Should the new %1 be copied to all %2 that are not yet invoiced?';
        Text006: Label 'You cannot delete the Seminar Registration, because there is at least one %1.';

    internal procedure AssistEdit(OldSeminarRegHeader: Record "Seminar Registration Header"): Boolean
    begin
        SeminarRegHeader := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Registration Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Registration Nos.", OldSeminarRegHeader."No. Series", SeminarRegHeader."No. Series") then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec := SeminarRegHeader;
            exit(TRUE);
        end;
    end;

    procedure InitRecord()
    begin
        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();
        "Document Date" := WorkDate();
        SeminarSetup.Get();
        NoSeriesMgt.SetDefaultSeries("Posting No. Series", SeminarSetup."Posted Seminar Reg. Nos.");
    end;
}

