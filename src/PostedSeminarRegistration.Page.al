// CSD1.00 - 2023-10-18 - B. During
//   Chapter 4 - Lab 3
//     - Created new page
// Chapter 5 - Lab 2
//     - Added the Navigate action

page 50034 "Posted Seminar Registration"
{


    Caption = 'Seminar Registration';
    Editable = false;
    PageType = Document;
    SourceTable = "Posted Seminar Reg. Header";
    ApplicationArea = All;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            group(General)
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
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Document Date"; Rec."Document Date")
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
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
            }
            part(SeminarRegistrationLines; "Posted Seminar Reg. Subform")
            {
                SubPageLink = "Document No." = Field("No.");
                ApplicationArea = All;
            }
            group("Seminar Room")
            {
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room Address"; Rec."Room Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room Address 2"; Rec."Room Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room Post Code"; Rec."Room Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room City"; Rec."Room City")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Room County"; Rec."Room County")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
            }
            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Quantity per Day.';
                }
                field("Seminar Price"; Rec."Seminar Price")
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
                SubPageLink = "No." = Field("Seminar No.");
                ApplicationArea = All;
            }
            part(CustomerDetailsFactBox; "Customer Details FactBox")
            {
                Provider = SeminarRegistrationLines;
                SubPageLink = "No." = Field("Bill-to Customer No.");
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
                    ToolTip = 'Demo Code';
                }
                action("Charges")
                {
                    Caption = 'Charges';
                    Image = Costs;
                    RunObject = Page "Posted Seminar Charges";
                    RunPageLink = "Document No." = Field("No.");
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
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

