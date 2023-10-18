permissionset 50000 SeminarPermissions
{
    // CSD1.00 - 2023-10-16 - B. During
    //   Chapter 2 - Lab 2
    //     - Created new page
    Assignable = true;
    Permissions = tabledata Seminar = RIMD,
        tabledata "Seminar Setup" = RIMD,
        table Seminar = X,
        table "Seminar Setup" = X,
        codeunit "Seminar Notification Mgmt." = X,
        page "Seminar Card" = X,
        page "Seminar List" = X,
        page "Seminar Setup" = X;
}