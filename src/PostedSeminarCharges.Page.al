// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 3
//     - Created new page

page 50039 "Posted Seminar Charges"
{
    AutoSplitKey = true;
    Caption = 'Seminar Charges';
    Editable = false;
    PageType = List;
    SourceTable = "Posted Seminar Charge";
    UsageCategory = History;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
            }
        }
    }

    actions
    {
    }
}

