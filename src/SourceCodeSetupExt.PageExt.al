// CSD1.00 - 2023-10-16 - B. During
//   Chapter 4 - Lab 1
//     - Created new page extension

pageextension 50002 SourceCodeSetupExt extends "Source Code Setup"
{
    layout
    {
        addlast(content)
        {
            group("Seminar Management")
            {
                field(Seminar; Rec.Seminar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Setup the code to be used for Seminars.';
                }
            }
        }
    }
}