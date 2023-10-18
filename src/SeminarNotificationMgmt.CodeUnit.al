// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new CodeUnit to show the guided setup feature

codeunit 50001 "Seminar Notification Mgmt."
{
    procedure SetupNoSeries(SeminarNosNotification: Notification)
    var
        SeminarSetup: Record "Seminar Setup";

    begin
        CreateNumberSeries('SEM');
        CreateNumberSeries('SEMREG');
        CreateNumberSeries('P-SEMR');

        SeminarSetup.Get();
        SeminarSetup."Seminar Nos." := 'SEM';
        SeminarSetup."Seminar Registration Nos." := 'SEMREG';
        SeminarSetup."Posted Seminar Reg. Nos." := 'P-SEMR';
        SeminarSetup.Modify();
    end;

    procedure CreateNumberSeries(NoSeriesName: Text[20])
    var
        NoSeries: Record "No. Series";
        NoSeriesLines: Record "No. Series Line";

    begin
        NoSeries.Reset();
        if not NoSeries.Get(NoSeriesName) then begin
            NoSeries.Init();
            NoSeries.Code := NoSeriesName;
            NoSeries.Description := 'Seminar Default Numbers System Setup';
            NoSeries."Default Nos." := true;
            NoSeries.Insert();

            NoSeriesLines.Reset();
            NoSeriesLines.Init();
            NoSeriesLines."Series Code" := NoSeries.Code;
            NoSeriesLines."Line No." := 10000;
            NoSeriesLines."Starting No." := CopyStr(NoSeries.Code + '001', 1, 20);
            NoSeriesLines."Ending No." := CopyStr(NoSeries.Code + '999', 1, 20);
            NoSeriesLines."Increment-by No." := 1;
            NoSeriesLines.Insert();
        end;
    end;
}