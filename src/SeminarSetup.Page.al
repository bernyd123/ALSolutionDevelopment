// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new page

page 50002 "Seminar Setup"
{
    Caption = 'Seminar Setup';
    PageType = Card;
    SourceTable = "Seminar Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
            }
        }
    }

    actions
    {
    }



    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

