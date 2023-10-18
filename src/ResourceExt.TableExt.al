// CSD1.00 - 2023-10-16 - B. During
//   Chapter 2 - Lab 1
//     - Added new fields:
//       - Internal/External
//       - Maximum Participants
//       - Quantity per Day

tableextension 50001 ResourceExt extends Resource
{

    fields
    {
        field(50001; "Internal/External"; Enum "Resource Internal External")
        {
            Caption = 'Internal/External';
            Description = 'CSD1.00';
        }
        field(50002; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            Description = 'CSD1.00';
        }
        field(50003; "Quantity Per Day"; Decimal)
        {
            Caption = 'Quantity Per Day';
            Description = 'CSD1.00';
        }
    }
}

