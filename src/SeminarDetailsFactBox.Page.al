// CSD1.00 - 2013-10-17 - B. During
//   Chapter 3 - Lab 2
//     - Created new page

page 50017 "Seminar Details FactBox"
{
    Caption = 'Seminar Details';
    PageType = CardPart;
    SourceTable = Seminar;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                ToolTip = 'Demo Code;';
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
                ToolTip = 'Demo Code;';
            }
            field("Seminar Duration"; Rec."Seminar Duration")
            {
                ApplicationArea = All;
                ToolTip = 'Demo Code;';
            }
            field("Minimum Participants"; Rec."Minimum Participants")
            {
                ApplicationArea = All;
                ToolTip = 'Demo Code;';
            }
            field("Maximum Participants"; Rec."Maximum Participants")
            {
                ApplicationArea = All;
                ToolTip = 'Demo Code;';
            }
            field("Seminar Price"; Rec."Seminar Price")
            {
                ApplicationArea = All;
                ToolTip = 'Demo Code;';
            }
        }
    }

    actions
    {
    }
}

