// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 1
//     - Added Install Codeunit to showcase the Install feature of Extensions

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
    end;
}