page 50010 "Seminar Registration"
{
    // CSD1.00 - 2013-10-17 - B. During
    //   Chapter 3 - Lab 2
    //     - Created new page

    Caption = 'Seminar Registration';
    PageType = Card;
    SourceTable = "Seminar Registration Header";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field(Duration; Rec.Duration)
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
            }
            group("Seminar Room")
            {
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room Address"; Rec."Room Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room Address 2"; Rec."Room Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room Post Code"; Rec."Room Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room City"; Rec."Room City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Room County"; Rec."Room County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
            }
            group(Invoicing)
            {
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
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
            }
        }
        area(factboxes)
        {
            part(CustomerDetails; "Customer Details FactBox")
            {
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
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = WHERE("Document Type" = CONST("Seminar Registration"));
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                action("Charges")
                {
                    Caption = 'Charges';
                    Image = Costs;
                    RunObject = Page "Seminar Charges";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
            }
        }
    }
}

