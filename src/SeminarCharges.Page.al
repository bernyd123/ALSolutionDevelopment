// CSD1.00 - 2013-10-17 - B. During
//   Chapter 3 - Lab 2
//     - Created new page

page 50024 "Seminar Charges"
{
    AutoSplitKey = true;
    Caption = 'Seminar Charges';
    PageType = List;
    SourceTable = "Seminar Charge";
    Permissions =
        tabledata "Seminar Charge" = RIMD;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("To Invoice"; Rec."To Invoice")
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

