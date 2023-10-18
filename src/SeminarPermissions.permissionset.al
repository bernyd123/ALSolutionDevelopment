// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 2
//     - Created new Seminar Permissions
//     - Updated with every release of new code
permissionset 50000 SeminarPermissions
{
    Assignable = true;
    Permissions = tabledata Seminar = RIMD,
        tabledata "Seminar Charge" = RIMD,
        tabledata "Seminar Comment Line" = RIMD,
        tabledata "Seminar Registration Header" = RIMD,
        tabledata "Seminar Registration Line" = RIMD,
        tabledata "Seminar Setup" = RIMD,
        table Seminar = X,
        table "Seminar Charge" = X,
        table "Seminar Comment Line" = X,
        table "Seminar Registration Header" = X,
        table "Seminar Registration Line" = X,
        table "Seminar Setup" = X,
        codeunit "Seminar App Install" = X,
        codeunit "Seminar Notification Mgmt." = X,
        page "Seminar Card" = X,
        page "Seminar Charges" = X,
        page "Seminar Comment List" = X,
        page "Seminar Comment Sheet" = X,
        page "Seminar Details FactBox" = X,
        page "Seminar List" = X,
        page "Seminar Registration" = X,
        page "Seminar Registration List" = X,
        page "Seminar Registration Subform" = X,
        page "Seminar Setup" = X;
}