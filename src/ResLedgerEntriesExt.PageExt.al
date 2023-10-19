// CSD1.00 - 2023-10-19 - B. During
// Chapter 4 - Lab 4
//     - Added the Seminar No. field to the Repeater control
//     - Added the Seminar Registration No. field to the Repeater control

pageextension 50003 ResLedgerEntriesExt extends "Resource Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Seminar No."; Rec."Seminar No.")
            {
                ApplicationArea = All;
                ToolTip = 'The Seminar this entry relates to.';
            }
            field("Seminar Registration No."; Rec."Seminar Registration No.")
            {
                ApplicationArea = All;
                ToolTip = 'The Seminar Registration that this entry relates to.';
            }
        }
    }
}