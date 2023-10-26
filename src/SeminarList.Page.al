// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new page
//     - Added Teaching Tips and in app tours
// Chapter 5 - Lab 1
//     - Added actions:
//     - New (Seminar Registration)
//     - Seminar Ledger Entries
//     - Registrations

page 50001 "Seminar List"
{
    Caption = 'Seminar List';
    CardPageID = "Seminar Card";
    Editable = false;
    PageType = List;
    SourceTable = Seminar;
    ApplicationArea = All;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Course, Conference, Training';

    AboutTitle = 'About seminars';
    AboutText = 'Here you overview all your seminars you present, their price, and the seminar statistics. With [Seminar Setup](?page=50002 "Opens the Seminar Setup") you can setup everything for this module.';

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

                    AboutTitle = 'Seminar duration in days';
                    AboutText = 'Here you can see how long a seminar is in days. In other words, 5 means that the seminar is a 5-day seminar.';
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code;';

                    AboutTitle = 'Price of the Seminar.';
                    AboutText = 'Here you can see the **Price** of a Seminar in Local Currency. This is for the entire seminar, and is not a price per day.';
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

