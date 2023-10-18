// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new Seminar Permissions
//     - Updated with every release of new code
permissionset 50000 SeminarPermissions
{
    Assignable = true;
    Permissions = tabledata Seminar = RIMD,
        tabledata "Seminar Setup" = RIMD,
        table Seminar = X,
        table "Seminar Setup" = X,
        codeunit "Seminar Notification Mgmt." = X,
        codeunit "Seminar App Install" = X,
        page "Seminar Card" = X,
        page "Seminar List" = X,
        page "Seminar Setup" = X;
}