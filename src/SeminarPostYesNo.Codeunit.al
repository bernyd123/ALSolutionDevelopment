// CSD1.00 - 2023-10-19 - B. During
//   Chapter 4 - Lab 5
//     - Created new codeunit

codeunit 50004 "Seminar-Post (Yes/No)"
{
    TableNo = 50010;

    trigger OnRun()
    begin
        SeminarRegHeader.COPY(Rec);
        Code();
        Rec := SeminarRegHeader;
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarPost: Codeunit "Seminar-Post";
        Text001: Label 'Do you want to post the Registration?';

    local procedure "Code"()
    begin
        if NOT CONFIRM(Text001, FALSE) then
            EXIT;
        SeminarPost.Run(SeminarRegHeader);
        Commit();
    end;
}

