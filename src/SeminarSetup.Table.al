// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new table

table 50001 "Seminar Setup"
{
    Caption = 'Seminar Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Seminar Nos."; Code[20])
        {
            Caption = 'Seminar Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Seminar Registration Nos."; Code[10])
        {
            Caption = 'Seminar Registration Nos.';
            TableRelation = "No. Series";
        }
        field(4; "Posted Seminar Reg. Nos."; Code[20])
        {
            Caption = 'Posted Seminar Reg. Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

