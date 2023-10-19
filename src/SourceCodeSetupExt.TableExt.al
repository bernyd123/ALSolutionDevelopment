// CSD1.00 - 2023-10-16 - B. During
//   Chapter 4 - Lab 1
//     - Created new table extension

tableextension 50000 "SourceCodeSetupExt" extends "Source Code Setup"
{
    fields
    {
        field(50000; Seminar; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
    }
}