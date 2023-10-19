// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 1
//     - Added Install Codeunit to showcase the Install feature of Extensions
//   Chapter 4 - Lab 1
//     - Added code to create the Source Code and set it up when the application is installed or re-installed

codeunit 50000 "Seminar App Install"
{
    Subtype = Install;
    trigger OnInstallAppPerCompany();
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        if AppInfo.DataVersion() = Version.Create(0, 0, 0, 0) then
            HandleInstall()
        else
            HandleReInstall();
    end;

    local procedure HandleInstall();
    var
        SeminarSetup: Record "Seminar Setup";
    begin
        SeminarSetup.Reset();
        if not SeminarSetup.Get() then begin
            SeminarSetup.Init();
            SeminarSetup.Insert();
        end;

        CreateSourceCode();
    end;

    local procedure HandleReInstall();
    var
        SeminarSetup: Record "Seminar Setup";
    begin
        SeminarSetup.Reset();
        if not SeminarSetup.Get() then begin
            SeminarSetup.Init();
            SeminarSetup.Insert();
        end;

        CreateSourceCode();
    end;

    local procedure CreateSourceCode()
    var
        SourceCode: Record "Source Code";
        SourceCodeSetup: Record "Source Code Setup";

    begin
        SourceCode.Reset();
        If not SourceCode.Get('Seminar') then begin
            SourceCode.Init();
            SourceCode.Code := 'Seminar';
            SourceCode.Description := 'Created from a Seminar Posting';
            SourceCode.Insert();
        end;

        SourceCodeSetup.Get();
        if SourceCodeSetup.Seminar = '' then begin
            SourceCodeSetup.Seminar := 'Seminar';
            SourceCodeSetup.Modify();
        end;
    end;
}