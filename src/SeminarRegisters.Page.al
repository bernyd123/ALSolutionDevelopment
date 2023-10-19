// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 2
//     - Created new page

page 50022 "Seminar Registers"
{
    Editable = false;
    PageType = List;
    SourceTable = "Seminar Register";
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
                    ToolTip = 'Demo Code';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Register)
            {
                Caption = 'Register';
                action("Seminar Ledger")
                {
                    Caption = 'Seminar Ledger';
                    Image = WarrantyLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Seminar Reg.-Show Ledger";
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
            }
        }
    }
}

