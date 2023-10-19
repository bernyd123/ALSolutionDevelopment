// CSD1.00 - 2023-10-17 - B. During
//   Chapter 3 - Lab 1
//     - Created new table

table 50011 "Seminar Registration Line"
{
    Caption = 'Seminar Registration Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Seminar Registration Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if "Bill-to Customer No." <> xRec."Bill-to Customer No." then
                    if Registered then
                        ERROR(Text001,
                          FieldCaption("Bill-to Customer No."),
                          FieldCaption(Registered),
                          Registered);
            end;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            begin
                ContactBusinessRelation.Reset();
                ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                if ContactBusinessRelation.FINDFIRST() then begin
                    Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                    if Page.RunModal(Page::"Contact List", Contact) = ACTION::LookupOK then
                        "Participant Contact No." := Contact."No.";
                end;

                CalcFields("Participant Name");
            end;

            trigger OnValidate()
            begin
                if ("Bill-to Customer No." <> '') AND
                   ("Participant Contact No." <> '')
                then begin
                    Contact.Get("Participant Contact No.");
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                    ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                    if ContactBusinessRelation.FINDFIRST() then
                        if ContactBusinessRelation."Contact No." <> Contact."Company No." then
                            ERROR(Text002, Contact."No.", Contact.Name, "Bill-to Customer No.");
                end;
            end;
        }
        field(5; "Participant Name"; Text[100])
        {
            CalcFormula = Lookup(Contact.Name Where("No." = Field("Participant Contact No.")));
            Caption = 'Participant Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(8; Participated; Boolean)
        {
            Caption = 'Participated';
        }
        field(9; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date';
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Seminar Price';

            trigger OnValidate()
            begin
                VALIDATE("Line Discount %");
            end;
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then
                    "Line Discount Amount" := 0
                else begin
                    GLSetup.Get();
                    "Line Discount Amount" := ROUND("Line Discount %" * "Seminar Price" * 0.01, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount();
            end;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';

            trigger OnValidate()
            begin
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else begin
                    GLSetup.Get();
                    "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount();
            end;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                GLSetup.Get();
                Amount := ROUND(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else
                    "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
            end;
        }
        field(14; Registered; Boolean)
        {
            Caption = 'Registered';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Registered, FALSE);
    end;

    trigger OnInsert()
    begin
        GetSeminarRegHeader();
        "Registration Date" := WorkDate();
        "Seminar Price" := SeminarRegHeader."Seminar Price";
        Amount := SeminarRegHeader."Seminar Price";
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Seminar Registration Line";
        ContactBusinessRelation: Record "Contact Business Relation";
        Contact: Record Contact;
        GLSetup: Record "General Ledger Setup";
        SkipBillToContact: Boolean;
        Text001: Label 'You cannot change the %1, because %2 is %3.';
        Text002: Label 'Contact %1 %2 is related to a different company than customer %3.';

    internal procedure GetSeminarRegHeader()
    begin
        if SeminarRegHeader."No." <> "Document No." then
            SeminarRegHeader.Get("Document No.");
    end;

    internal procedure CalculateAmount()
    begin
        Amount := ROUND(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;

    internal procedure UpdateAmount()
    begin
        GLSetup.Get();
        Amount := ROUND("Seminar Price" - "Line Discount Amount", GLSetup."Amount Rounding Precision");
    end;
}

