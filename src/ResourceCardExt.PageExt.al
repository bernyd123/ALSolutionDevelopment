// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 1
//     - Added the Internal/External field to the General FastTab
//     - Added the Quantity per Day field to the General FasetTab
//     - Added the Room FastTab
//     - Added the Maximum Participants field to the Room FastTab

pageextension 50000 ResourceCardExt extends "Resource Card"
{
    layout
    {
        addafter(Type)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                ApplicationArea = All;
                ToolTip = 'This field indicates if the Resource is Internal or External to our company.';
            }
        }
        addafter("Base Unit of Measure")
        {
            field("Quantity Per Day"; Rec."Quantity Per Day")
            {
                ApplicationArea = All;
                ToolTip = 'The Quantity per Day.';
            }
        }
        addlast(content)
        {
            group(Room)
            {
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                    ToolTip = 'The Maximum number of participants allowed.';
                }
            }
        }
    }
}

