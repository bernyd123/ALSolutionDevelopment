// CSD1.00 - 2013-10-17 - B. During
//   Chapter 3 - Lab 2
//     - Created new page

page 50011 "Seminar Registration Subform"
{
    Caption = 'Lines';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Seminar Registration Line";

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

