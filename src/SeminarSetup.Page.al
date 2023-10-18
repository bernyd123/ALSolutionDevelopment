// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new page
//     - Added Notification to the Page to Show Guided Setup Feature

page 50002 "Seminar Setup"
{
    Caption = 'Seminar Setup';
    PageType = Card;
    SourceTable = "Seminar Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demo Code';
                }
            }
        }
    }

    actions
    {
    }



    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        if (rec."Seminar Nos." = '') and (rec."Seminar Registration Nos." = '') and (Rec."Posted Seminar Reg. Nos." = '') then
            DoSeminarSetup();
    end;

    local procedure DoSeminarSetup()
    var
        SeminarNosNotification: Notification;
        SeminarNosMessage: Label 'No. Series has not been setup.';
        SetupNotification: Label 'Setup Default Numbers.';

    begin
        SeminarNosNotification.Message(SeminarNosMessage);
        SeminarNosNotification.Scope := NotificationScope::LocalScope;
        SeminarNosNotification.AddAction(SetupNotification, Codeunit::"Seminar Notification Mgmt.", 'SetupNoSeries');
        SeminarNosNotification.Send();
    end;
}

