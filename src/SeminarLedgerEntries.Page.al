// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 2
//     - Created new page
// Chapter 5 - Lab 2
//     - Added the Navigate action

page 50021 "Seminar Ledger Entries"
{
    Caption = 'Seminar Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Seminar Ledger Entry";
    UsageCategory = History;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Quantity; Rec.Quantity)
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
                field(Chargeable; Rec.Chargeable)
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
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
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
        area(Navigation)
        {
            action(Navigate)
            {
                ApplicationArea = All;
                Caption = 'Find entries...';
                Image = Navigate;
                Scope = Repeater;
                ShortcutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the selected document. (Formerly known as Navigate)';

                trigger OnAction()
                begin
                    NavigatePage.SetDoc(Rec."Posting Date", rec."Document No.");
                    NavigatePage.Run();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(Navigate_Promoted; Navigate)
                {
                }
            }
        }
    }

    var
        NavigatePage: Page Navigate;
}

