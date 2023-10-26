// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new page
//     - Added Teaching Tips and in app tours
// Chapter 5 - Lab 1
//     - Added actions:
//     - New (Seminar Registration)
//     - Seminar Ledger Entries
//     - Registrations

//TODO Upgrade Promoted Actions to new Promotion

page 50000 "Seminar Card"
{
    Caption = 'Seminar Card';
    PageType = Card;
    SourceTable = Seminar;
    UsageCategory = Lists;
    ApplicationArea = All;
    AdditionalSearchTerms = 'Course, Conference, Training';

    AboutTitle = 'About seminar details';
    AboutText = 'With the **Seminar Card** you manage information about a seminar and specify the terms of business, such as the price and duration. From here you can also drill down on past and ongoing sales activity.';

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
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Seminar Duration"; Rec."Seminar Duration")
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
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
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
            systempart(Control16; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control17; Notes)
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
                    ToolTip = 'Show the comments for the Seminar.';
                    Caption = 'Comments';
                    Image = Comment;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = Const(Seminar),
                                  "No." = Field("No.");
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';
                    Image = WarrantyLedger;
                    RunObject = Page "Seminar Ledger Entries";
                    RunPageLink = "Seminar No." = field("No.");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
            group(Registration)
            {
                Image = SalesInvoice;
                action(Registrations)
                {
                    RunObject = page "Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
                    Image = Timesheet;
                    ToolTip = 'View all the registrations for this seminar.';
                }
            }
        }
        area(Creation)
        {
            action(NewSeminarReg)
            {
                AccessByPermission = TableData "Seminar Registration Header" = RIM;
                ApplicationArea = All;
                Caption = 'Seminar Registration';
                Image = NewTimesheet;
                RunObject = Page "Seminar Registration";
                RunPageLink = "Seminar No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
            }
        }
        area(Promoted)
        {
            group(Category_Category4)
            {
                Caption = 'New Document';

                actionref(NewSeminarReg_Promoted; NewSeminarReg)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Seminar';

                actionref(LedgerEntries_Promoted; "Ledger Entries")
                {
                }
                actionref(SeminarRegistrations_Promoted; Registrations)
                {
                }
            }
        }
    }
}

