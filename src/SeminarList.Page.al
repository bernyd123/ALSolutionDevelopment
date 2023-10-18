// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new page

page 50001 "Seminar List"
{
    Caption = 'Seminar List';
    CardPageID = "Seminar Card";
    Editable = false;
    PageType = List;
    SourceTable = Seminar;
    ApplicationArea = All;
    UsageCategory = Lists;


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
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control11; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Seminar")
            {
                Caption = 'Seminar';
                action("Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Show the Comments for the Current Seminar';
                    Caption = 'Comments';
                    Image = Comment;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Seminar),
                                  "No." = FIELD("No.");
                }
            }
        }
    }
}

