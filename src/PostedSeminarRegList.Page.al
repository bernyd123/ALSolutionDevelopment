// CSD1.00 - 2023-10-18 - B. During
//   Chapter 3 - Lab 2
//     - Created new page
// Chapter 5 - Lab 2
//     - Added the Navigate action

page 50036 "Posted Seminar Reg. List"
{


    Caption = 'Seminar Registration List';
    CardPageID = "Posted Seminar Registration";
    Editable = false;
    PageType = List;
    SourceTable = "Posted Seminar Reg. Header";

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
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
            }
        }
        area(factboxes)
        {
            part(SeminarDetailsFactbox; "Seminar Details FactBox")
            {
                SubPageLink = "No." = Field("No.");
                ApplicationArea = All;
            }
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
            group("Seminar Registration")
            {
                Caption = 'Seminar Registration';
                action("Comments")
                {
                    Caption = 'Comments';
                    Image = Comment;
                    RunObject = Page "Seminar Comment Sheet";
                    RunPageLink = "No." = Field("No.");
                    RunPageView = Where("Document Type" = Const("Posted Seminar Registration"));
                    ApplicationArea = All;
                    Tooltip = 'Demo Code';
                }
                action("Charges")
                {
                    Caption = 'Charges';
                    Image = Costs;
                    RunObject = Page "Posted Seminar Charges";
                    RunPageLink = "Document No." = Field("No.");
                    ApplicationArea = All;
                    Tooltip = 'Demo Code';
                }
            }
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
                    NavigatePage.SetDoc(Rec."Posting Date", rec."No.");
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

