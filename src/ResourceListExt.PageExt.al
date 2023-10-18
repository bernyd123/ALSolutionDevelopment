// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 1
//     - Added the Internal/External and Maximum number of Participants fields to the list
//     - Adding code to make the showing of the fields conditional

pageextension 50001 ResourceListExt extends "Resource List"
{
    layout
    {
        addlast(Control1)
        {
            field("Internal/External"; Rec."Internal/External")
            {
                ApplicationArea = All;
                ToolTip = 'Shows if the Resource is Internal to the company or external.';
            }
            field("Maximum Participants"; Rec."Maximum Participants")
            {
                ApplicationArea = All;
                ToolTip = 'Shows how many people Max a room is able to hold.';
                Visible = ShowMaxParticipants;
            }
        }
        modify(Type)
        {
            Visible = ShowType;
        }
    }

    var
        ShowType, ShowMaxParticipants : Boolean;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(3);
        ShowType := Rec.GetFilter(Type) = '';
        ShowMaxParticipants := Rec.GetFilter(Type) = Format(Rec.Type::Machine);
        Rec.FilterGroup(0);
    end;
}