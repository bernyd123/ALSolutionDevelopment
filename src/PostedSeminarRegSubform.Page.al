// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 3
//     - Created new page

page 50035 "Posted Seminar Reg. Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Posted Seminar Reg. Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Participated; Rec.Participated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
            }
        }
    }

    actions
    {
    }
}

