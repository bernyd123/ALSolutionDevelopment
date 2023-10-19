// CSD1.00 - 2023-10-19 - B. During
// Chapter 4 - Lab 4
//     - Added new fields:
//     - Seminar No.
//     - Seminar Registration No.

tableextension 50003 ResLedgerEntryExt extends "Res. Ledger Entry"
{
    fields
    {
        field(50000; "Seminar No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Seminar;
        }
        field(50001; "Seminar Registration No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Seminar Registration Header";
        }
    }
}